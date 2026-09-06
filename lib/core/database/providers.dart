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
///
/// `retry: _neverRetry`: o Riverpod 3 tenta de novo com backoff por padrão
/// quando um provider falha. As falhas daqui (Keystore indisponível, chave
/// corrompida, SQLCipher indisponível) não são transitórias — repetir na
/// hora não resolve, e ficaria escondido atrás de "carregando" para sempre
/// em vez de mostrar a [BootstrapFailureScreen] (T-37/T-39).
@Riverpod(keepAlive: true, retry: _neverRetry)
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

Duration? _neverRetry(int retryCount, Object error) => null;
