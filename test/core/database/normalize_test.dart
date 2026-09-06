import 'package:financial/core/database/normalize.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizeForSearch', () {
    test('"Açúcar" normaliza para "acucar"', () {
      expect(normalizeForSearch('Açúcar'), 'acucar');
    });

    test('caixa alta normaliza para minúscula', () {
      expect(normalizeForSearch('AÇÚCAR'), 'acucar');
    });

    test('nulo produz nulo', () {
      expect(normalizeForSearch(null), isNull);
    });

    test('string sem acento passa só pelo lowercase', () {
      expect(normalizeForSearch('Mercado Livre'), 'mercado livre');
    });
  });
}
