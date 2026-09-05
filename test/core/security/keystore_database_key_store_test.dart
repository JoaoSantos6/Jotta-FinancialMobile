import 'package:financial/core/security/database_key_store.dart';
import 'package:financial/core/security/keystore_database_key_store.dart';
import 'package:flutter_test/flutter_test.dart';

/// Storage falso em memória — nenhum destes testes toca canal de plataforma.
final class _FakeSecureKeyValueStore implements SecureKeyValueStore {
  final Map<String, String> _values = {};
  int writeCount = 0;

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async {
    writeCount++;
    _values[key] = value;
  }

  @override
  Future<void> delete(String key) async => _values.remove(key);
}

void main() {
  group('KeystoreDatabaseKeyStore.getOrCreate', () {
    test('a 1ª chamada gera e persiste; a 2ª devolve a mesma chave', () async {
      final fake = _FakeSecureKeyValueStore();
      final store = KeystoreDatabaseKeyStore(storage: fake);

      final first = await store.getOrCreate();
      final second = await store.getOrCreate();

      final firstKey = first.fold(ok: (k) => k, err: (_) => null);
      final secondKey = second.fold(ok: (k) => k, err: (_) => null);

      expect(firstKey, isNotNull);
      expect(secondKey, isNotNull);
      expect(firstKey!.toHex(), secondKey!.toHex());
      expect(fake.writeCount, 1);
    });
  });

  group('KeystoreDatabaseKeyStore — valor corrompido', () {
    test('valor não-hex vira KeyCorrupted, sem sobrescrever', () async {
      final fake = _FakeSecureKeyValueStore();
      await fake.write('jotta.db.key', 'nao-e-hex');
      final store = KeystoreDatabaseKeyStore(storage: fake);

      final result = await store.getOrCreate();

      expect(result.fold(ok: (_) => null, err: (f) => f), isA<KeyCorrupted>());
      expect(await fake.read('jotta.db.key'), 'nao-e-hex');
    });
  });

  group('KeystoreDatabaseKeyStore.destroy', () {
    test(
      'apaga o material; a chamada seguinte gera uma chave diferente',
      () async {
        final fake = _FakeSecureKeyValueStore();
        final store = KeystoreDatabaseKeyStore(storage: fake);

        final before = await store.getOrCreate();
        await store.destroy();
        expect(await fake.read('jotta.db.key'), isNull);
        final after = await store.getOrCreate();

        final beforeKey = before.fold(ok: (k) => k, err: (_) => null)!;
        final afterKey = after.fold(ok: (k) => k, err: (_) => null)!;
        expect(beforeKey.toHex(), isNot(afterKey.toHex()));
      },
    );
  });

  group('FlutterSecureKeyValueStore.androidOptions', () {
    test('enforceBiometrics é false — a chave não é amarrada a biometria', () {
      // A partir da v11, AndroidOptions.toMap() expõe o valor publicamente.
      // Fixa a expectativa para que uma atualização da dependência não mude
      // o padrão em silêncio (SEG-1 do guarda-chuva §6.3).
      final params = FlutterSecureKeyValueStore.androidOptions.toMap();
      expect(params['enforceBiometrics'], 'false');
    });
  });
}
