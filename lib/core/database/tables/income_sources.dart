import 'package:drift/drift.dart';

class IncomeSources extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// 'salary' | 'freelance' | 'rent' | 'other'.
  TextColumn get type => text()();

  IntColumn get expectedCents => integer().named('expected_cents').nullable()();
  BoolColumn get isRecurring =>
      boolean().named('is_recurring').withDefault(const Constant(false))();

  /// 1..31, quando recorrente.
  IntColumn get expectedDay => integer().named('expected_day').nullable()();

  TextColumn get archivedAt => text().named('archived_at').nullable()();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column> get primaryKey => {id};
}
