// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(databaseKeyStore)
final databaseKeyStoreProvider = DatabaseKeyStoreProvider._();

final class DatabaseKeyStoreProvider
    extends
        $FunctionalProvider<
          DatabaseKeyStore,
          DatabaseKeyStore,
          DatabaseKeyStore
        >
    with $Provider<DatabaseKeyStore> {
  DatabaseKeyStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseKeyStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseKeyStoreHash();

  @$internal
  @override
  $ProviderElement<DatabaseKeyStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DatabaseKeyStore create(Ref ref) {
    return databaseKeyStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DatabaseKeyStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DatabaseKeyStore>(value),
    );
  }
}

String _$databaseKeyStoreHash() => r'ba00d71ca82fda261aee2b4a215f903c30d3a743';

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

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

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

final class AppDatabaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppDatabase>,
          AppDatabase,
          FutureOr<AppDatabase>
        >
    with $FutureModifier<AppDatabase>, $FutureProvider<AppDatabase> {
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
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: _neverRetry,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $FutureProviderElement<AppDatabase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AppDatabase> create(Ref ref) {
    return appDatabase(ref);
  }
}

String _$appDatabaseHash() => r'f2c019c27777608a7987548c5f4b39247a054cbb';
