// T-31 — golden do schema v1.
//
// Qualquer alteração de coluna, tipo ou índice quebra este teste e obriga a
// atualizar o golden conscientemente (`dart run tool/dump_schema.dart`), em
// vez de deixar o schema mudar em silêncio.
import 'dart:io';

import 'package:drift/native.dart';
import 'package:financial/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3_lib;

Future<String> _dumpSchema(AppDatabase db) async {
  final rows = await db
      .customSelect(
        "SELECT sql FROM sqlite_master WHERE sql IS NOT NULL "
        "AND name NOT LIKE 'sqlite_%' ORDER BY type DESC, name;",
      )
      .get();
  return rows.map((r) => '${r.data['sql']};').join('\n');
}

void main() {
  test('sqlite_master bate byte a byte com o golden schema_v1.sql', () async {
    final raw = sqlite3_lib.sqlite3.openInMemory();
    final db = AppDatabase(NativeDatabase.opened(raw));
    await db.customSelect('SELECT 1;').get();

    final actual = await _dumpSchema(db);
    await db.close();

    final golden = File('test/fixtures/schema_v1.sql')
        .readAsStringSync()
        .trim();

    expect(
      actual,
      golden,
      reason:
          'o schema mudou sem o golden ser atualizado. Se a mudança foi '
          'intencional, rode: dart run tool/dump_schema.dart > '
          'test/fixtures/schema_v1.sql',
    );
  });
}
