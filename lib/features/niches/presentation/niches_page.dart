import 'package:flutter/material.dart';

/// Nichos — tela genérica de gasto. Vazia neste ADR; lançamento, lista e
/// desfazer chegam no ADR-2 (M1).
class NichesPage extends StatelessWidget {
  const NichesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Nada aqui ainda — Nichos')),
    );
  }
}
