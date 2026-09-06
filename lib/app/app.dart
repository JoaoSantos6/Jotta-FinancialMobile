import 'package:financial/app/bootstrap_gate.dart';
import 'package:flutter/material.dart';

/// Raiz do app. Tema (T-40) e rotas (T-41) chegam nos próximos commits —
/// por ora, a casca é um placeholder atrás do [BootstrapGate].
class JottaApp extends StatelessWidget {
  const JottaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jotta',
      debugShowCheckedModeBanner: false,
      home: const BootstrapGate(
        child: Scaffold(body: Center(child: Text('Jotta'))),
      ),
    );
  }
}
