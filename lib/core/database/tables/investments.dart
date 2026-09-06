import 'package:drift/drift.dart';

class Investments extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// 'fixed' | 'variable' | 'fund' | 'crypto' | 'other'.
  TextColumn get type => text()();

  IntColumn get balanceCents =>
      integer().named('balance_cents').withDefault(const Constant(0))();
  TextColumn get balanceUpdatedAt =>
      text().named('balance_updated_at').nullable()();
  TextColumn get archivedAt => text().named('archived_at').nullable()();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column> get primaryKey => {id};
}
