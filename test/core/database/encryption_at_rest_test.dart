// T-16 a T-19 — o banco cifrado em repouso, provado em arquivo real (CA-3).
//
// É a versão automatizada de "extrair jotta.db do aparelho e tentar abrir com
// sqlite3": aqui rodamos os mesmos três cheques contra um arquivo de verdade,
// a cada push, sem precisar de emulador.
import 'dart:io';

import 'package:financial/core/database/open_encrypted_database.dart';
import 'package:financial/core/security/database_key.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3_lib;

void main() {
  late Directory tempDir;
  late File dbFile;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('jotta_encryption_test_');
    dbFile = File('${tempDir.path}/jotta_test.db');
  });

  tearDown(() {
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  test(
    'T-16 — round-trip: escreve, fecha, reabre com a chave certa e lê de volta',
    () {
      final key = DatabaseKey.generate();

      final db1 = openEncryptedDatabase(file: dbFile, key: key);
      db1.execute('CREATE TABLE t (id INTEGER PRIMARY KEY, v TEXT);');
      db1.execute("INSERT INTO t (v) VALUES ('ola-jotta');");
      db1.close();

      final db2 = openEncryptedDatabase(file: dbFile, key: key);
      final rows = db2.select('SELECT v FROM t;');
      db2.close();

      expect(rows, hasLength(1));
      expect(rows.first['v'], 'ola-jotta');
    },
  );

  test('T-17 — reabrir sem chave (PRAGMA key nunca chamado) falha', () {
    final key = DatabaseKey.generate();
    final db1 = openEncryptedDatabase(file: dbFile, key: key);
    db1.execute('CREATE TABLE t (id INTEGER PRIMARY KEY);');
    db1.close();

    // Abre o arquivo direto pelo sqlite3, sem passar por
    // openEncryptedDatabase — ou seja, sem nunca executar PRAGMA key.
    final rawOpen = sqlite3_lib.sqlite3.open(dbFile.path);
    expect(
      () => rawOpen.select('SELECT * FROM sqlite_master;'),
      throwsException,
      reason:
          'sem a chave, o arquivo cifrado não é um banco SQLite legível — '
          'a leitura do schema deve falhar',
    );
    rawOpen.close();
  });

  test('T-18 — reabrir com chave errada falha', () {
    final correctKey = DatabaseKey.generate();
    final wrongKey = DatabaseKey.generate();

    final db1 = openEncryptedDatabase(file: dbFile, key: correctKey);
    db1.execute('CREATE TABLE t (id INTEGER PRIMARY KEY);');
    db1.close();

    expect(
      () => openEncryptedDatabase(file: dbFile, key: wrongKey),
      throwsA(isA<DatabaseLockedException>()),
    );
  });

  test(
    'T-19 — uma descrição-marcador gravada não aparece nos bytes do arquivo',
    () {
      const marker = 'DESCRICAO-MARCADOR-QUE-NAO-PODE-APARECER-EM-CLARO';
      final key = DatabaseKey.generate();

      final db = openEncryptedDatabase(file: dbFile, key: key);
      db.execute('CREATE TABLE t (id INTEGER PRIMARY KEY, descricao TEXT);');
      db.execute('INSERT INTO t (descricao) VALUES (?);', [marker]);
      db.close();

      final bytes = dbFile.readAsBytesSync();
      final content = String.fromCharCodes(bytes);

      expect(
        content.contains(marker),
        isFalse,
        reason:
            'é a versão automatizada do `strings jotta.db` — o marcador não '
            'pode aparecer em claro no arquivo cifrado',
      );
    },
  );
}
