import 'package:drift/drift.dart';

import 'debts.dart';

class DebtInstallments extends Table {
  TextColumn get id => text()();
  TextColumn get debtId => text().named('debt_id').references(Debts, #id)();

  /// 1..N.
  IntColumn get number => integer()();
  TextColumn get dueOn => text().named('due_on')();
  IntColumn get amountCents => integer().named('amount_cents')();

  /// Nulo = em aberto.
  TextColumn get paidOn => text().named('paid_on').nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {debtId, number},
  ];
}
