// T-32 a T-34 — seed dos 7 nichos.
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:financial/core/database/app_database.dart';
import 'package:financial/core/database/seed/niche_seed.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3_lib;

AppDatabase _openTestDatabase() {
  final raw = sqlite3_lib.sqlite3.openInMemory();
  return AppDatabase(NativeDatabase.opened(raw));
}

void main() {
  late AppDatabase db;

  setUp(() => db = _openTestDatabase());
  tearDown(() => db.close());

  group('T-32 — seed dos 7 nichos', () {
    test('banco novo tem 7 nichos', () async {
      final niches = await db.select(db.niches).get();
      expect(niches, hasLength(7));
    });

    test('ids batem com a tabela da seção 5.6', () async {
      final niches = await db.select(db.niches).get();
      final ids = niches.map((n) => n.id).toSet();
      expect(ids, {
        'casa',
        'transporte',
        'alimentacao',
        'saude',
        'lazer',
        'investimentos',
        'dividas',
      });
    });

    test('sort_order vai de 1 a 7, sem buraco nem repetição', () async {
      final niches = await db.select(db.niches).get();
      final orders = niches.map((n) => n.sortOrder).toList()..sort();
      expect(orders, [1, 2, 3, 4, 5, 6, 7]);
    });

    test('icon e color preenchidos nos 7', () async {
      final niches = await db.select(db.niches).get();
      for (final n in niches) {
        expect(n.icon, isNotEmpty);
        expect(n.color, greaterThan(0));
      }
    });
  });

  group('T-33 — distribuição de kind', () {
    test('5 expense, 1 investment, 1 debt', () async {
      final niches = await db.select(db.niches).get();
      final byKind = <String, int>{};
      for (final n in niches) {
        byKind[n.kind] = (byKind[n.kind] ?? 0) + 1;
      }
      expect(byKind, {'expense': 5, 'investment': 1, 'debt': 1});
    });
  });

  group('T-34 — seed idempotente', () {
    test('rodar o seed duas vezes no mesmo banco mantém 7 linhas', () async {
      await db.batch((b) {
        b.insertAll(db.niches, kNicheSeed, mode: InsertMode.insertOrIgnore);
      });
      final niches = await db.select(db.niches).get();
      expect(niches, hasLength(7));
    });
  });
}
