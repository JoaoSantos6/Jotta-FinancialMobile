import 'dart:io';

import 'package:financial/core/security/database_key.dart';
import 'package:sqlite3/sqlite3.dart';

/// Ponto de injeção para teste. Por padrão é `sqlite3.open`, que usa o binário
/// SQLCipher resolvido pelo hook (pubspec.yaml). Um teste pode injetar um
/// `Database` falso para provar [SqlCipherUnavailableException] sem
/// depender de um binário diferente existir em tempo de execução — o hook
/// fixa o binário no build inteiro, então não há mais como trocá-lo em
/// runtime (docs/adr-1/SPEC.md §5.3).
typedef DatabaseOpener = Database Function(String path);

/// O binário carregado não é SQLCipher: `PRAGMA cipher_version` veio vazio.
/// `PRAGMA key` foi aceito e ignorado, e o banco estaria em claro sem nenhum
/// erro visível se este cheque não existisse (risco A1).
final class SqlCipherUnavailableException implements Exception {
  const SqlCipherUnavailableException();

  @override
  String toString() =>
      'SqlCipherUnavailableException: PRAGMA cipher_version veio vazio — '
      'o binário carregado não é SQLCipher';
}

/// A chave não abriu o arquivo (chave errada, ou arquivo corrompido).
final class DatabaseLockedException implements Exception {
  const DatabaseLockedException();

  @override
  String toString() =>
      'DatabaseLockedException: a chave fornecida não abriu o banco';
}

/// Abre [file] cifrado com [key] e prova que o SQLCipher está de fato ativo.
///
/// Ordem obrigatória: `PRAGMA key` ANTES de qualquer outra instrução. Um
/// `SELECT` antes do key faz o SQLCipher marcar a conexão como não-cifrada.
Database openEncryptedDatabase({
  required File file,
  required DatabaseKey key,
  DatabaseOpener? open,
}) {
  final opener = open ?? sqlite3.open;
  final db = opener(file.path);

  db.execute('PRAGMA key = "${key.pragmaLiteral}";');

  final cipherVersion = db.select('PRAGMA cipher_version;');
  final version = cipherVersion.isEmpty
      ? null
      : cipherVersion.first.values.firstOrNull as String?;
  if (version == null || version.isEmpty) {
    db.close();
    throw const SqlCipherUnavailableException();
  }

  try {
    // Transforma "chave errada" num erro imediato aqui, em vez de uma
    // exceção obscura na primeira query da Home.
    db.select('SELECT count(*) FROM sqlite_master;');
  } on Exception {
    db.close();
    throw const DatabaseLockedException();
  }

  return db;
}
