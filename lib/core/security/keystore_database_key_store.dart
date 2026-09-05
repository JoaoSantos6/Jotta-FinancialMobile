import 'package:financial/core/result/result.dart';
import 'package:financial/core/security/database_key.dart';
import 'package:financial/core/security/database_key_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Ponto de injeção mínimo sobre `flutter_secure_storage`, só para que os
/// testes de [KeystoreDatabaseKeyStore] não precisem de canal de plataforma —
/// um "storage falso em memória" implementa esta interface sem tocar Android.
abstract interface class SecureKeyValueStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// Implementação real, sobre `flutter_secure_storage`.
final class FlutterSecureKeyValueStore implements SecureKeyValueStore {
  FlutterSecureKeyValueStore()
    : _storage = const FlutterSecureStorage(aOptions: androidOptions);

  /// SEG-1: o construtor padrão de `AndroidOptions` já usa AES-GCM com chave
  /// embrulhada no Keystore (o equivalente moderno de EncryptedSharedPreferences
  /// — a versão 11 do pacote removeu esse parâmetro porque virou o padrão).
  ///
  /// `enforceBiometrics: false` é explícito, não só o default: com `false`, a
  /// própria dependência documenta que "the key will be generated with
  /// setUserAuthenticationRequired(false)". O gate de acesso é o SEG-2, na
  /// camada de UI — amarrar a chave à biometria forçaria autenticação durante
  /// o bootstrap, antes de existir interface para pedi-la (guarda-chuva §6.3).
  static const androidOptions = AndroidOptions(enforceBiometrics: false);

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

/// Chave do banco no Android Keystore, via [SecureKeyValueStore].
final class KeystoreDatabaseKeyStore implements DatabaseKeyStore {
  KeystoreDatabaseKeyStore({SecureKeyValueStore? storage})
    : _storage = storage ?? FlutterSecureKeyValueStore();

  static const _storageKey = 'jotta.db.key';

  final SecureKeyValueStore _storage;

  @override
  Future<Result<DatabaseKey, KeyStoreFailure>> getOrCreate() async {
    final existing = await _storage.read(_storageKey);

    if (existing == null) {
      final generated = DatabaseKey.generate();
      await _storage.write(_storageKey, generated.toHex());
      return Ok(generated);
    }

    try {
      return Ok(DatabaseKey.fromHex(existing));
    } on FormatException {
      // Nunca sobrescreve: gerar uma chave nova por cima de um valor
      // ilegível transformaria um erro de leitura na destruição permanente
      // do banco (docs/adr-1/SPEC.md §5.2).
      return const Err(KeyCorrupted());
    }
  }

  @override
  Future<Result<void, KeyStoreFailure>> destroy() async {
    await _storage.delete(_storageKey);
    return const Ok(null);
  }
}
