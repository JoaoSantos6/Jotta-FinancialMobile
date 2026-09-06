import 'package:drift/drift.dart';

class Debts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get creditor => text().nullable()();
  IntColumn get totalCents => integer().named('total_cents')();
  IntColumn get installmentCount => integer().named('installment_count')();
  IntColumn get installmentCents => integer().named('installment_cents')();
  TextColumn get firstDueOn => text().named('first_due_on')();
  TextColumn get settledAt => text().named('settled_at').nullable()();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column> get primaryKey => {id};
}
