// T-06 — regra de dependência executável (CA-8, guarda-chuva §5.2).
//
// `domain` nunca importa Flutter nem Drift: é isso que mantém regra de negócio
// (cálculo de sobra, fronteiras de período, geração de parcelas) testável sem
// emulador. Convenção documentada não roda na CI; este teste roda.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _forbiddenImports = ['package:flutter/', 'package:drift/'];

void main() {
  test('nenhum arquivo em lib/features/*/domain/ importa Flutter ou Drift', () {
    final featuresDir = Directory('lib/features');
    if (!featuresDir.existsSync()) {
      fail(
        'lib/features/ não existe — a árvore de pastas da T-06 não foi criada',
      );
    }

    final violations = <String>[];
    for (final feature in featuresDir.listSync().whereType<Directory>()) {
      final domainDir = Directory('${feature.path}/domain');
      if (!domainDir.existsSync()) continue;

      for (final entity in domainDir.listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) continue;

        final content = entity.readAsStringSync();
        for (final forbidden in _forbiddenImports) {
          if (content.contains("import '$forbidden") ||
              content.contains('import "$forbidden')) {
            violations.add('${entity.path} importa $forbidden');
          }
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'domain não pode depender de Flutter nem Drift (presentation -> domain '
          '<- data): ${violations.join('; ')}',
    );
  });

  test('as 4 pastas de domínio existem (mesmo vazias)', () {
    for (final feature in ['overview', 'niches', 'income', 'settings']) {
      expect(
        Directory('lib/features/$feature/domain').existsSync(),
        isTrue,
        reason: 'lib/features/$feature/domain/ deveria existir, mesmo vazia',
      );
    }
  });
}
