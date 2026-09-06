// T-14 — SQLCipher resolvido pelo hook e ativo (CA-2).
//
// A task mais importante do ADR-1: `PRAGMA key` em uma SQLite que não é
// SQLCipher é aceito e IGNORADO — o banco fica em claro e nada avisa (risco
// A1). O hook (pubspec.yaml, `hooks.user_defines.sqlite3.source: sqlcipher`)
// resolve o mesmo binário SQLCipher em qualquer plataforma que rodar o app ou
// o teste — não há mais "loader" nem override manual (docs/DECISIONS.md).
import 'dart:io';

import 'package:financial/core/database/open_encrypted_database.dart';
import 'package:financial/core/security/database_key.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqlite3/sqlite3.dart';

class _FakeDatabase extends Mock implements Database {}

/// `ResultSet` e `Row` são `final class` no pacote `sqlite3` — não dá para
/// mockar diretamente (Dart proíbe `implements` fora da biblioteca dona).
/// Em vez disso, usamos um banco em memória real só para produzir um
/// `ResultSet` de verdade (vazio, de uma consulta que não bate com nada) —
/// legítimo e sem tocar o binário SQLCipher de propósito.
ResultSet _emptyResultSet() {
  final db = sqlite3.openInMemory();
  final empty = db.select('SELECT 1 WHERE 0;');
  db.close();
  return empty;
}

void main() {
  test('PRAGMA cipher_version não é vazio — SQLCipher realmente ativo', () {
    final db = sqlite3.openInMemory();
    addTearDown(db.close);

    final rows = db.select('PRAGMA cipher_version;');

    expect(
      rows,
      isNotEmpty,
      reason:
          'cipher_version vazio significa que o binário carregado é SQLite '
          'puro — o PRAGMA key seria aceito e ignorado, e o banco ficaria '
          'em claro sem nenhum erro visível (risco A1)',
    );
    final version = rows.first.values.first as String;
    expect(version, isNotEmpty);
  });

  group('openEncryptedDatabase', () {
    test('cipher_version vazio lança SqlCipherUnavailableException', () {
      final fakeDb = _FakeDatabase();
      when(() => fakeDb.execute(any())).thenReturn(null);
      when(() => fakeDb.select('PRAGMA cipher_version;'))
          .thenReturn(_emptyResultSet());
      when(() => fakeDb.close()).thenReturn(null);

      expect(
        () => openEncryptedDatabase(
          file: File('irrelevante.db'),
          key: DatabaseKey.generate(),
          open: (_) => fakeDb,
        ),
        throwsA(isA<SqlCipherUnavailableException>()),
      );
      verify(() => fakeDb.close()).called(1);
    });

    test('chave errada (SELECT falha) lança DatabaseLockedException', () {
      // cipher_version real e não-vazio (o primeiro teste deste arquivo
      // garante isso) — aqui o que falha é a query seguinte, simulando
      // chave errada ou arquivo corrompido.
      final realCipherVersionDb = sqlite3.openInMemory();
      addTearDown(realCipherVersionDb.close);
      final realCipherVersion = realCipherVersionDb.select(
        'PRAGMA cipher_version;',
      );

      final fakeDb = _FakeDatabase();
      when(() => fakeDb.execute(any())).thenReturn(null);
      when(() => fakeDb.select('PRAGMA cipher_version;'))
          .thenReturn(realCipherVersion);
      when(() => fakeDb.select('SELECT count(*) FROM sqlite_master;'))
          .thenThrow(Exception('file is not a database'));
      when(() => fakeDb.close()).thenReturn(null);

      expect(
        () => openEncryptedDatabase(
          file: File('irrelevante.db'),
          key: DatabaseKey.generate(),
          open: (_) => fakeDb,
        ),
        throwsA(isA<DatabaseLockedException>()),
      );
      verify(() => fakeDb.close()).called(1);
    });
  });
}
