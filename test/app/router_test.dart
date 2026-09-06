import 'package:financial/app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpAt(WidgetTester tester, String location) async {
    appRouter.go(location);
    await tester.pumpWidget(MaterialApp.router(routerConfig: appRouter));
    await tester.pumpAndSettle();
  }

  group('T-41 — rotas e telas vazias', () {
    testWidgets('/ resolve para a Home', (tester) async {
      await pumpAt(tester, '/');
      expect(find.textContaining('Home'), findsOneWidget);
    });

    testWidgets('/nichos resolve para Nichos', (tester) async {
      await pumpAt(tester, '/nichos');
      expect(find.textContaining('Nichos'), findsOneWidget);
    });

    testWidgets('/renda resolve para Renda', (tester) async {
      await pumpAt(tester, '/renda');
      expect(find.textContaining('Renda'), findsOneWidget);
    });

    testWidgets('/ajustes resolve para Ajustes', (tester) async {
      await pumpAt(tester, '/ajustes');
      expect(find.textContaining('Ajustes'), findsOneWidget);
    });
  });
}
