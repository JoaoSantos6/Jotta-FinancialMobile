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

  group('T-42 — bottom nav e FAB persistente', () {
    testWidgets('o FAB está presente nas 4 abas', (tester) async {
      for (final location in ['/', '/nichos', '/renda', '/ajustes']) {
        await pumpAt(tester, location);
        expect(
          find.byType(FloatingActionButton),
          findsOneWidget,
          reason: 'FAB deveria estar presente em $location',
        );
      }
    });

    testWidgets('tocar cada aba troca a tela visível', (tester) async {
      await pumpAt(tester, '/');
      expect(find.textContaining('Home'), findsOneWidget);

      await tester.tap(find.byTooltip('Nichos'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Nichos'), findsOneWidget);

      await tester.tap(find.byTooltip('Renda'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Renda'), findsOneWidget);

      await tester.tap(find.byTooltip('Ajustes'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Ajustes'), findsOneWidget);
    });

    testWidgets(
      'trocar de aba e voltar preserva a pilha (IndexedStack mantém montado)',
      (tester) async {
        await pumpAt(tester, '/');
        expect(find.textContaining('Home'), findsOneWidget);

        await tester.tap(find.byTooltip('Nichos'));
        await tester.pumpAndSettle();

        // IndexedStack mantém as abas não-visíveis montadas — a Home
        // continua na árvore de widgets, só offstage.
        expect(
          find.textContaining('Home', skipOffstage: false),
          findsOneWidget,
        );

        await tester.tap(find.byTooltip('Home'));
        await tester.pumpAndSettle();
        expect(find.textContaining('Home'), findsOneWidget);
      },
    );
  });

  group('T-43 — alvos de toque ≥ 48dp (guarda-chuva RNF-7)', () {
    testWidgets('cada item da bottom nav tem altura e largura ≥ 48dp', (
      tester,
    ) async {
      await pumpAt(tester, '/');

      for (final tooltip in ['Home', 'Nichos', 'Renda', 'Ajustes']) {
        final size = tester.getSize(find.byTooltip(tooltip));
        expect(
          size.width,
          greaterThanOrEqualTo(48),
          reason: '$tooltip: largura ${size.width}',
        );
        expect(
          size.height,
          greaterThanOrEqualTo(48),
          reason: '$tooltip: altura ${size.height}',
        );
      }
    });

    testWidgets('o FAB tem altura e largura ≥ 48dp', (tester) async {
      await pumpAt(tester, '/');
      final size = tester.getSize(find.byType(FloatingActionButton));
      expect(size.width, greaterThanOrEqualTo(48));
      expect(size.height, greaterThanOrEqualTo(48));
    });
  });
}
