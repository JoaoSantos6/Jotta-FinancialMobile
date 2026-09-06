// Regera o golden `test/fixtures/schema_v1.sql` a partir do schema real do
// AppDatabase (docs/adr-1/TASK.md, T-31).
//
// Rode conscientemente quando alterar o schema de propósito:
//   dart run tool/dump_schema.dart > test/fixtures/schema_v1.sql
//
// Uma alteração de schema que muda este arquivo sem ninguém rodar o comando
// acima é exatamente o que o teste de snapshot (schema_snapshot_test.dart)
// existe para pegar.
import 'package:drift/native.dart';
import 'package:financial/core/database/app_database.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3_lib;

Future<void> main() async {
  final raw = sqlite3_lib.sqlite3.openInMemory();
  final db = AppDatabase(NativeDatabase.opened(raw));
  await db.customSelect('SELECT 1;').get(); // força a criação do schema

  final rows = await db
      .customSelect(
        "SELECT sql FROM sqlite_master WHERE sql IS NOT NULL "
        "AND name NOT LIKE 'sqlite_%' ORDER BY type DESC, name;",
      )
      .get();

  for (final row in rows) {
    // ignore: avoid_print
    print('${row.data['sql']};');
  }

  await db.close();
}
