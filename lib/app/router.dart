import 'package:financial/features/income/presentation/income_page.dart';
import 'package:financial/features/niches/presentation/niches_page.dart';
import 'package:financial/features/overview/presentation/overview_page.dart';
import 'package:financial/features/settings/presentation/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

/// Casca de navegação: bottom nav + FAB central persistente (guarda-chuva
/// §3.1). O FAB não abre nada neste ADR — é um placeholder visual até o
/// formulário de lançamento existir (ADR-2). Cada aba mantém sua própria
/// pilha: trocar de aba e voltar preserva onde você estava.
class JottaShell extends StatelessWidget {
  const JottaShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Novo lançamento',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              index: 0,
              navigationShell: navigationShell,
            ),
            _NavItem(
              icon: Icons.category_outlined,
              label: 'Nichos',
              index: 1,
              navigationShell: navigationShell,
            ),
            const SizedBox(width: 48), // espaço para o FAB entalhado
            _NavItem(
              icon: Icons.attach_money,
              label: 'Renda',
              index: 2,
              navigationShell: navigationShell,
            ),
            _NavItem(
              icon: Icons.settings_outlined,
              label: 'Ajustes',
              index: 3,
              navigationShell: navigationShell,
            ),
          ],
        ),
      ),
    );
  }
}

/// Um item da bottom nav. Alvo de toque ≥ 48dp (T-43, guarda-chuva RNF-7).
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.navigationShell,
  });

  final IconData icon;
  final String label;
  final int index;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final selected = navigationShell.currentIndex == index;
    return IconButton(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      tooltip: label,
      isSelected: selected,
      icon: Icon(icon),
      onPressed: () => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
    );
  }
}

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          JottaShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const OverviewPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/nichos',
              builder: (context, state) => const NichesPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/renda',
              builder: (context, state) => const IncomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/ajustes',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
