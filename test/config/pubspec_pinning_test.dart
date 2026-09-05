// T-04 — versões travadas nas dependências sensíveis (guarda-chuva §6.6, V-04).
//
// Nenhuma dependência que toque cripto, banco ou segredos pode usar `^`, `any`
// ou intervalo aberto: uma atualização silenciosa nelas é exatamente o tipo de
// mudança que este projeto não quer descobrir em produção.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

/// Dependências onde uma versão solta é inaceitável: tocam cripto, banco ou
/// segredos. As demais (cupertino_icons, flutter_lints, ferramentas de teste)
/// não entram nesta lista — não fazem parte da superfície de segurança.
const _sensitive = {
  'drift',
  'sqlite3',
  'flutter_secure_storage',
  'path_provider',
  'flutter_riverpod',
  'riverpod_annotation',
  'go_router',
  'dynamic_color',
  'drift_dev',
  'build_runner',
  'riverpod_generator',
};

bool _isExactPin(String value) {
  // Uma versão exata não começa com ^, não é "any" e não contém operadores de
  // intervalo (<, >, um espaço separando dois limites).
  final trimmed = value.trim();
  if (trimmed.isEmpty || trimmed == 'any') return false;
  if (trimmed.startsWith('^') || trimmed.contains('<') || trimmed.contains('>')) {
    return false;
  }
  return RegExp(r'^\d+\.\d+\.\d+').hasMatch(trimmed);
}

void main() {
  test('dependências sensíveis usam versão exata, sem ^, any ou intervalo', () {
    final pubspec =
        loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;
    final deps = <String, dynamic>{
      ...?(pubspec['dependencies'] as YamlMap?)?.cast<String, dynamic>(),
      ...?(pubspec['dev_dependencies'] as YamlMap?)?.cast<String, dynamic>(),
    };

    final failures = <String>[];
    for (final name in _sensitive) {
      final value = deps[name];
      expect(
        value,
        isNotNull,
        reason: 'dependência sensível "$name" não está declarada em pubspec.yaml',
      );
      if (value is! String || !_isExactPin(value)) {
        failures.add('$name: "$value"');
      }
    }

    expect(
      failures,
      isEmpty,
      reason:
          'dependências sensíveis sem versão exata (^, any ou intervalo '
          'aberto não são permitidos aqui): ${failures.join(', ')}',
    );
  });

  test('pubspec.lock existe e está versionado junto', () {
    expect(File('pubspec.lock').existsSync(), isTrue);
  });

  test('hook do sqlite3 está configurado para sqlcipher (docs/DECISIONS.md)', () {
    final pubspec =
        loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;
    final hooks = pubspec['hooks'] as YamlMap?;
    final userDefines = hooks?['user_defines'] as YamlMap?;
    final sqlite3Define = userDefines?['sqlite3'] as YamlMap?;
    expect(
      sqlite3Define?['source'],
      'sqlcipher',
      reason:
          'sqlcipher_flutter_libs está EOL — o binário SQLCipher vem do hook '
          'do próprio sqlite3, não de um plugin separado',
    );
  });

  test('sqlcipher_flutter_libs (EOL) não é dependência', () {
    final pubspec =
        loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;
    final deps = <String, dynamic>{
      ...?(pubspec['dependencies'] as YamlMap?)?.cast<String, dynamic>(),
      ...?(pubspec['dev_dependencies'] as YamlMap?)?.cast<String, dynamic>(),
    };
    expect(deps.containsKey('sqlcipher_flutter_libs'), isFalse);
  });
}
