import 'package:drift/native.dart';
import 'package:financial/app/bootstrap_gate.dart';
import 'package:financial/core/database/app_database.dart';
import 'package:financial/core/database/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3_lib;

void main() {
  testWidgets('com o provider em erro, mostra a tela de falha e não a casca', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWith(
            (ref) async => throw Exception('falha simulada de bootstrap'),
          ),
        ],
        child: const MaterialApp(
          home: BootstrapGate(child: Text('CASCA DE NAVEGAÇÃO')),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('CASCA DE NAVEGAÇÃO'), findsNothing);
    expect(find.byType(BootstrapFailureScreen), findsOneWidget);
  });

  testWidgets(
    'com o provider resolvido, mostra a casca e não a tela de falha',
    (tester) async {
      final db = AppDatabase(
        NativeDatabase.opened(sqlite3_lib.sqlite3.openInMemory()),
      );
      addTearDown(db.close);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWith((ref) async => db)],
          child: const MaterialApp(
            home: BootstrapGate(child: Text('CASCA DE NAVEGAÇÃO')),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('CASCA DE NAVEGAÇÃO'), findsOneWidget);
      expect(find.byType(BootstrapFailureScreen), findsNothing);
    },
  );
}
