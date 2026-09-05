// T-14 — SQLCipher resolvido pelo hook e ativo (CA-2).
//
// A task mais importante do ADR-1: `PRAGMA key` em uma SQLite que não é
// SQLCipher é aceito e IGNORADO — o banco fica em claro e nada avisa (risco
// A1). O hook (pubspec.yaml, `hooks.user_defines.sqlite3.source: sqlcipher`)
// resolve o mesmo binário SQLCipher em qualquer plataforma que rodar o app ou
// o teste — não há mais "loader" nem override manual (docs/DECISIONS.md).
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

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
}
