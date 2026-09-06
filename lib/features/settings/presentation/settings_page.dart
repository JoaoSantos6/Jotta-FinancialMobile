import 'package:flutter/material.dart';

/// Ajustes. Vazia neste ADR; backup, bloqueio e recorrência chegam no
/// ADR-6 (M5).
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Nada aqui ainda — Ajustes')),
    );
  }
}
