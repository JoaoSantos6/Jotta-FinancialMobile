import 'package:financial/core/database/app_database.dart';

/// As 7 linhas de `niches` (guarda-chuva §3.2, SPEC §5.6). Fixas no MVP: o
/// usuário não cria nem remove nichos.
///
/// `icon` é nome de ícone Material Symbols, resolvido por um `const Map` na
/// apresentação (nunca `IconData(codePoint)` da string — desliga o
/// tree-shaking de ícones e infla o APK). `color` é ARGB fixo, escolhido para
/// se distinguir dos demais na distribuição da Home.
final List<NichesCompanion> kNicheSeed = [
  NichesCompanion.insert(
    id: 'casa',
    name: 'Casa',
    icon: 'home',
    color: 0xFFE07A1F,
    kind: 'expense',
    sortOrder: 1,
  ),
  NichesCompanion.insert(
    id: 'transporte',
    name: 'Transporte',
    icon: 'directions_car',
    color: 0xFF1E6FD9,
    kind: 'expense',
    sortOrder: 2,
  ),
  NichesCompanion.insert(
    id: 'alimentacao',
    name: 'Alimentação',
    icon: 'restaurant',
    color: 0xFF2E8B4A,
    kind: 'expense',
    sortOrder: 3,
  ),
  NichesCompanion.insert(
    id: 'saude',
    name: 'Saúde',
    icon: 'medical_services',
    color: 0xFFD32F4B,
    kind: 'expense',
    sortOrder: 4,
  ),
  NichesCompanion.insert(
    id: 'lazer',
    name: 'Lazer',
    icon: 'movie',
    color: 0xFF7B4DBF,
    kind: 'expense',
    sortOrder: 5,
  ),
  NichesCompanion.insert(
    id: 'investimentos',
    name: 'Investimentos',
    icon: 'trending_up',
    color: 0xFF0F8C8C,
    kind: 'investment',
    sortOrder: 6,
  ),
  NichesCompanion.insert(
    id: 'dividas',
    name: 'Dívidas',
    icon: 'credit_card',
    color: 0xFF5A6472,
    kind: 'debt',
    sortOrder: 7,
  ),
];
