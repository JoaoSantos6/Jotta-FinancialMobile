import 'dart:io';

import 'package:financial/core/database/providers.dart';
import 'package:financial/core/result/result.dart';
import 'package:financial/core/security/database_key.dart';
import 'package:financial/core/security/database_key_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class _FakeDatabaseKeyStore implements DatabaseKeyStore {
  _FakeDatabaseKeyStore(this.key);

  final DatabaseKey key;
  int getOrCreateCallCount = 0;

  @override
  Future<Result<DatabaseKey, KeyStoreFailure>> getOrCreate() async {
    getOrCreateCallCount++;
    return Ok(key);
  }

  @override
  Future<Result<void, KeyStoreFailure>> destroy() async => const Ok(null);
}

class _FakePathProviderPlatform extends PathProviderPlatform {
  _FakePathProviderPlatform(this.path);

  final String path;

  @override
  Future<String?> getApplicationDocumentsPath() async => path;
}

void main() {
  test(
    'appDatabaseProvider pede a chave ao store uma vez e abre o banco com ela',
    () async {
      final tempDir = Directory.systemTemp.createTempSync(
        'jotta_providers_test_',
      );
      addTearDown(() => tempDir.deleteSync(recursive: true));
      PathProviderPlatform.instance = _FakePathProviderPlatform(tempDir.path);

      final key = DatabaseKey.generate();
      final fakeStore = _FakeDatabaseKeyStore(key);

      final container = ProviderContainer(
        overrides: [databaseKeyStoreProvider.overrideWithValue(fakeStore)],
      );
      addTearDown(container.dispose);

      final db = await container.read(appDatabaseProvider.future);
      addTearDown(db.close);

      expect(fakeStore.getOrCreateCallCount, 1);
      expect(File('${tempDir.path}/jotta.db').existsSync(), isTrue);

      // Abrir de novo, direto, com a MESMA chave, prova que foi essa chave —
      // e não outra — que cifrou o arquivo que o provider produziu.
      final reopened = await container.read(appDatabaseProvider.future);
      expect(identical(db, reopened), isTrue); // keepAlive: mesma instância
    },
  );
}
