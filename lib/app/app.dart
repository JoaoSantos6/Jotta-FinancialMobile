import 'package:dynamic_color/dynamic_color.dart';
import 'package:financial/app/bootstrap_gate.dart';
import 'package:financial/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Raiz do app. Rotas (T-41) chegam no próximo commit — por ora, a casca é
/// um placeholder atrás do [BootstrapGate].
class JottaApp extends StatelessWidget {
  const JottaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
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
          home: const BootstrapGate(
            child: Scaffold(body: Center(child: Text('Jotta'))),
          ),
        );
      },
    );
  }
}
