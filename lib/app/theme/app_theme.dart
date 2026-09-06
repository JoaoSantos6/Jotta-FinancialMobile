import 'package:flutter/material.dart';

/// Semente usada quando o aparelho não oferece cor dinâmica (Material You).
/// Combina com o teal do nicho "Investimentos" — não é uma escolha
/// arbitrária, mas também não é crítica: é só o ponto de partida da paleta
/// quando não há papel de parede para derivar dela.
const _fallbackSeed = Color(0xFF0F8C8C);

/// Constrói o tema M3 para [brightness]. Usa [dynamicScheme] quando o
/// aparelho oferece Material You; cai em `ColorScheme.fromSeed` sem lançar
/// quando não oferece (desktop, aparelhos antigos, ou a resposta do SO
/// ainda não chegou).
ThemeData buildJottaTheme({
  required Brightness brightness,
  ColorScheme? dynamicScheme,
}) {
  final colorScheme =
      dynamicScheme ??
      ColorScheme.fromSeed(seedColor: _fallbackSeed, brightness: brightness);

  return ThemeData(useMaterial3: true, colorScheme: colorScheme);
}
