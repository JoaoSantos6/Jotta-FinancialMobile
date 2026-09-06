import 'package:financial/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('buildJottaTheme', () {
    test('useMaterial3 é true no claro, sem cor dinâmica', () {
      final theme = buildJottaTheme(brightness: Brightness.light);
      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
    });

    test('useMaterial3 é true no escuro, sem cor dinâmica', () {
      final theme = buildJottaTheme(brightness: Brightness.dark);
      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.dark);
    });

    test('sem cor dinâmica, não lança — cai no ColorScheme.fromSeed', () {
      expect(
        () => buildJottaTheme(brightness: Brightness.light),
        returnsNormally,
      );
    });

    test('com cor dinâmica fornecida, usa exatamente aquele esquema', () {
      final dynamicScheme = const ColorScheme.light(primary: Colors.red);
      final theme = buildJottaTheme(
        brightness: Brightness.light,
        dynamicScheme: dynamicScheme,
      );
      expect(theme.colorScheme.primary, Colors.red);
    });
  });
}
