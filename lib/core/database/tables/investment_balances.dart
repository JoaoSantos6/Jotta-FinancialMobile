import 'package:drift/drift.dart';

import 'investments.dart';

/// Histórico de saldo, para o gráfico de evolução patrimonial (guarda-chuva §5.3).
class InvestmentBalances extends Table {
  TextColumn get id => text()();
  TextColumn get investmentId =>
      text().named('investment_id').references(Investments, #id)();
  IntColumn get balanceCents => integer().named('balance_cents')();
  TextColumn get recordedOn => text().named('recorded_on')();

  @override
  Set<Column> get primaryKey => {id};
}
