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

  group('transactions — T-21', () {
    late AppDatabase db;

    setUp(() => db = _openTestDatabase());
    tearDown(() => db.close());

    Future<void> insertWithAmount(int cents) => db.customStatement(
      "INSERT INTO transactions (id, kind, amount_cents, occurred_on, "
      "created_at, updated_at) VALUES ('t1', 'expense', $cents, "
      "'2026-09-05', '2026-09-05T00:00:00', '2026-09-05T00:00:00');",
    );

    test('amount_cents = 0 é rejeitado pelo CHECK', () async {
      await expectLater(insertWithAmount(0), throwsException);
    });

    test('amount_cents negativo é rejeitado pelo CHECK', () async {
      await expectLater(insertWithAmount(-1), throwsException);
    });

    test('amount_cents = 1 é aceito', () async {
      await insertWithAmount(1);
      final rows = await db.customSelect('SELECT * FROM transactions;').get();
      expect(rows, hasLength(1));
    });
  });

  group('idx_tx_search — T-22', () {
    late AppDatabase db;

    setUp(() => db = _openTestDatabase());
    tearDown(() => db.close());

    test('existe e é parcial (WHERE deleted_at IS NULL)', () async {
      final rows = await db
          .customSelect(
            "SELECT sql FROM sqlite_master WHERE type = 'index' "
            "AND name = 'idx_tx_search';",
          )
          .get();
      expect(rows, hasLength(1));
      final sql = rows.first.data['sql'] as String;
      expect(sql.contains('deleted_at IS NULL'), isTrue);
    });

    test(
      'LIKE sobre description_norm encontra "Açúcar" buscando "acucar"',
      () async {
        await db.customStatement(
          "INSERT INTO transactions (id, kind, amount_cents, occurred_on, "
          "description, description_norm, created_at, updated_at) VALUES "
          "('t1', 'expense', 500, '2026-09-05', 'Açúcar', 'acucar', "
          "'2026-09-05T00:00:00', '2026-09-05T00:00:00');",
        );
        final rows = await db
            .customSelect(
              "SELECT * FROM transactions WHERE description_norm LIKE '%acucar%';",
            )
            .get();
        expect(rows, hasLength(1));
      },
    );
  });

  group('app_usage_days — T-23', () {
    late AppDatabase db;

    setUp(() => db = _openTestDatabase());
    tearDown(() => db.close());

    test('registrar o mesmo dia duas vezes mantém uma linha', () async {
      await db.customStatement(
        "INSERT OR IGNORE INTO app_usage_days (day) VALUES ('2026-09-05');",
      );
      await db.customStatement(
        "INSERT OR IGNORE INTO app_usage_days (day) VALUES ('2026-09-05');",
      );
      final rows = await db.customSelect('SELECT * FROM app_usage_days;').get();
      expect(rows, hasLength(1));
    });

    test('dois dias diferentes produzem duas linhas', () async {
      await db.customStatement(
        "INSERT INTO app_usage_days (day) VALUES ('2026-09-05');",
      );
      await db.customStatement(
        "INSERT INTO app_usage_days (day) VALUES ('2026-09-06');",
      );
      final rows = await db.customSelect('SELECT * FROM app_usage_days;').get();
      expect(rows, hasLength(2));
    });
  });

  group('error_log — T-24', () {
    late AppDatabase db;

    setUp(() => db = _openTestDatabase());
    tearDown(() => db.close());

    test(
      'tem exatamente as 5 colunas — nenhuma de valor ou descrição',
      () async {
        final rows = await db
            .customSelect("PRAGMA table_info('error_log');")
            .get();
        final columnNames = rows.map((r) => r.data['name'] as String).toSet();

        expect(
          columnNames,
          {'id', 'occurred_at', 'type', 'screen', 'stack'},
          reason:
              'SEG-6: nunca o dado que causou o erro. Uma coluna de valor, '
              'descrição, credor ou fonte de renda aqui é o achado, não a '
              'exceção',
        );
      },
    );

    test('aceita um registro de exceção', () async {
      await db.customStatement(
        "INSERT INTO error_log (id, occurred_at, type, screen, stack) "
        "VALUES ('e1', '2026-09-05T00:00:00', 'FormatException', "
        "'/ajustes', 'stack trace aqui');",
      );
      final rows = await db.customSelect('SELECT * FROM error_log;').get();
      expect(rows, hasLength(1));
    });
  });

  group('income_sources, investments, investment_balances — T-25', () {
    late AppDatabase db;

    setUp(() => db = _openTestDatabase());
    tearDown(() => db.close());

    test('income_sources existe com as 8 colunas da seção 5.3', () async {
      await db.customStatement(
        'SELECT id, name, type, expected_cents, is_recurring, expected_day, '
        'archived_at, created_at FROM income_sources;',
      );
    });

    test('investments existe com as 7 colunas da seção 5.3', () async {
      await db.customStatement(
        'SELECT id, name, type, balance_cents, balance_updated_at, '
        'archived_at, created_at FROM investments;',
      );
    });

    test('investment_balances referencia investments', () async {
      await db.customStatement(
        "INSERT INTO investments (id, name, type, created_at) "
        "VALUES ('i1', 'Tesouro', 'fixed', '2026-09-05');",
      );
      await db.customStatement(
        "INSERT INTO investment_balances (id, investment_id, balance_cents, "
        "recorded_on) VALUES ('b1', 'i1', 10000, '2026-09-05');",
      );
      final rows = await db
          .customSelect('SELECT * FROM investment_balances;')
          .get();
      expect(rows, hasLength(1));
    });

    test('transactions.income_source_id referencia income_sources', () async {
      await db.customStatement(
        "INSERT INTO income_sources (id, name, type, created_at) "
        "VALUES ('s1', 'Salário', 'salary', '2026-09-05');",
      );
      await db.customStatement(
        "INSERT INTO transactions (id, kind, amount_cents, occurred_on, "
        "income_source_id, created_at, updated_at) VALUES ('t1', 'income', "
        "840000, '2026-09-05', 's1', '2026-09-05T00:00:00', "
        "'2026-09-05T00:00:00');",
      );
      final rows = await db.customSelect('SELECT * FROM transactions;').get();
      expect(rows, hasLength(1));
    });
  });

  group('debts, debt_installments — T-26', () {
    late AppDatabase db;

    setUp(() => db = _openTestDatabase());
    tearDown(() => db.close());

    Future<void> insertDebt() => db.customStatement(
      "INSERT INTO debts (id, name, total_cents, installment_count, "
      "installment_cents, first_due_on, created_at) VALUES ('d1', "
      "'Cartão', 120000, 12, 10000, '2026-10-05', '2026-09-05');",
    );

    test('debts existe com as 9 colunas da seção 5.3', () async {
      await db.customStatement(
        'SELECT id, name, creditor, total_cents, installment_count, '
        'installment_cents, first_due_on, settled_at, created_at FROM debts;',
      );
    });

    test('UNIQUE (debt_id, number) rejeita parcela duplicada', () async {
      await insertDebt();
      await db.customStatement(
        "INSERT INTO debt_installments (id, debt_id, number, due_on, "
        "amount_cents) VALUES ('p1', 'd1', 1, '2026-10-05', 10000);",
      );
      await expectLater(
        db.customStatement(
          "INSERT INTO debt_installments (id, debt_id, number, due_on, "
          "amount_cents) VALUES ('p2', 'd1', 1, '2026-11-05', 10000);",
        ),
        throwsException,
      );
    });

    test('a mesma parcela number em dívidas diferentes é permitida', () async {
      await insertDebt();
      await db.customStatement(
        "INSERT INTO debts (id, name, total_cents, installment_count, "
        "installment_cents, first_due_on, created_at) VALUES ('d2', "
        "'Empréstimo', 60000, 6, 10000, '2026-10-10', '2026-09-05');",
      );
      await db.customStatement(
        "INSERT INTO debt_installments (id, debt_id, number, due_on, "
        "amount_cents) VALUES ('p1', 'd1', 1, '2026-10-05', 10000);",
      );
      await db.customStatement(
        "INSERT INTO debt_installments (id, debt_id, number, due_on, "
        "amount_cents) VALUES ('p2', 'd2', 1, '2026-10-10', 10000);",
      );
      final rows = await db
          .customSelect('SELECT * FROM debt_installments;')
          .get();
      expect(rows, hasLength(2));
    });

    test(
      'transactions.debt_installment_id referencia debt_installments',
      () async {
        await insertDebt();
        await db.customStatement(
          "INSERT INTO debt_installments (id, debt_id, number, due_on, "
          "amount_cents) VALUES ('p1', 'd1', 1, '2026-10-05', 10000);",
        );
        await db.customStatement(
          "INSERT INTO transactions (id, kind, amount_cents, occurred_on, "
          "debt_installment_id, created_at, updated_at) VALUES ('t1', "
          "'debt_payment', 10000, '2026-10-05', 'p1', "
          "'2026-10-05T00:00:00', '2026-10-05T00:00:00');",
        );
        final rows = await db.customSelect('SELECT * FROM transactions;').get();
        expect(rows, hasLength(1));
      },
    );
  });

  group('app_settings e fechamento do schema — T-27', () {
    late AppDatabase db;

    setUp(() => db = _openTestDatabase());
    tearDown(() => db.close());

    test('app_settings existe como chave-valor', () async {
      await db.customStatement(
        "INSERT INTO app_settings (key, value) VALUES ('tema', 'escuro');",
      );
      final rows = await db.customSelect('SELECT * FROM app_settings;').get();
      expect(rows, hasLength(1));
    });

    test(
      'o banco tem exatamente 10 tabelas — nem uma a mais, nem a menos',
      () async {
        final rows = await db
            .customSelect(
              "SELECT name FROM sqlite_master WHERE type = 'table' "
              "AND name NOT LIKE 'sqlite_%';",
            )
            .get();
        final tableNames = rows.map((r) => r.data['name'] as String).toSet();

        expect(tableNames, {
          'niches',
          'transactions',
          'income_sources',
          'investments',
          'investment_balances',
          'debts',
          'debt_installments',
          'app_settings',
          'app_usage_days',
          'error_log',
        });
      },
    );
  });
}
