import 'package:drift/drift.dart';

/// Seed fixo de 7 linhas, não editável pelo usuário no MVP (guarda-chuva §5.3).
class Niches extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// Nome de ícone Material Symbols (`home`, `directions_car`, …), não emoji —
  /// ícone nativo herda a cor do tema e o TalkBack lê o rótulo do nicho
  /// (docs/DECISIONS.md).
  TextColumn get icon => text()();

  /// ARGB fixo, escolhido para se distinguir dos demais na distribuição da
  /// Home (docs/DECISIONS.md).
  IntColumn get color => integer()();

  /// 'expense' | 'investment' | 'debt'.
  TextColumn get kind => text()();
  IntColumn get sortOrder => integer().named('sort_order')();

  @override
  Set<Column> get primaryKey => {id};
}
