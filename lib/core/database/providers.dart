import 'package:drift/native.dart';
import 'package:financial/core/security/database_key_store.dart';
import 'package:financial/core/security/keystore_database_key_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_database.dart';
import 'database_location.dart';
import 'open_encrypted_database.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
DatabaseKeyStore databaseKeyStore(Ref ref) => KeystoreDatabaseKeyStore();

/// Orquestra: pede a chave ao [databaseKeyStoreProvider] (gerando na 1ª vez),
/// resolve o caminho de `jotta.db` e abre o banco cifrado com ela.
///
/// `keepAlive`: o banco vive enquanto o app viver — nenhum `autoDispose`
/// fecha a conexão por trás da UI.
@Riverpod(keepAlive: true)
Future<AppDatabase> appDatabase(Ref ref) async {
  final store = ref.watch(databaseKeyStoreProvider);
  final result = await store.getOrCreate();

  final key = result.fold(
    ok: (key) => key,
    err: (failure) =>
        throw StateError('Não foi possível obter a chave do banco: $failure'),
  );

  final file = await resolveDatabaseFile();
  final rawDatabase = openEncryptedDatabase(file: file, key: key);

  return AppDatabase(NativeDatabase.opened(rawDatabase));
}
