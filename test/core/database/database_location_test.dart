import 'package:financial/core/database/database_location.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class _FakePathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async => '/dados/privados/app';
}

void main() {
  test(
    'o caminho resolvido cai no diretório privado do app e termina em jotta.db',
    () async {
      PathProviderPlatform.instance = _FakePathProviderPlatform();

      final file = await resolveDatabaseFile();

      expect(file.path, '/dados/privados/app/jotta.db');
    },
  );
}
