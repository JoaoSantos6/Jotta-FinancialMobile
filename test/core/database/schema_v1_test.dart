// T-20 a T-30 — schema v1 completo (guarda-chuva §5.3, emendado com
// description_norm, app_usage_days e error_log — docs/DECISIONS.md).
import 'package:drift/native.dart';
import 'package:financial/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3_lib;

AppDatabase _openTestDatabase() {
  final raw = sqlite3_lib.sqlite3.openInMemory();
  return AppDatabase(NativeDatabase.opened(raw));
}

void main() {
  group('AppDatabase — T-20', () {
    late AppDatabase db;

    setUp(() => db = _openTestDatabase());
    tearDown(() => db.close());

    test('schemaVersion é 1', () {
      expect(db.schemaVersion, 1);
    });

    test('a tabela niches existe com as 6 colunas da seção 5.3', () async {
      await db.customStatement(
        'SELECT id, name, icon, color, kind, sort_order FROM niches;',
      );
    });
  });
}
