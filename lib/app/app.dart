import 'package:dynamic_color/dynamic_color.dart';
import 'package:financial/app/bootstrap_gate.dart';
import 'package:financial/app/router.dart';
import 'package:financial/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Raiz do app: tema (T-40) + rotas (T-41) atrás do [BootstrapGate], que
/// decide entre splash, tela de falha e a casca de navegação.
class JottaApp extends StatelessWidget {
  const JottaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp.router(
          title: 'Jotta',
          debugShowCheckedModeBanner: false,
          theme: buildJottaTheme(
            brightness: Brightness.light,
            dynamicScheme: lightDynamic,
          ),
          darkTheme: buildJottaTheme(
            brightness: Brightness.dark,
            dynamicScheme: darkDynamic,
          ),
          routerConfig: appRouter,
          builder: (context, child) => BootstrapGate(child: child!),
        );
      },
    );
  }
}
