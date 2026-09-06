import 'package:drift/drift.dart';

import 'income_sources.dart';
import 'investments.dart';

/// Toda movimentação de caixa vive aqui. Fonte única de verdade da Home
/// (guarda-chuva §5.3).
///
/// Dinheiro é sempre `IntColumn` em centavos — nunca `RealColumn`, ponto
/// flutuante em dinheiro é bug garantido. Datas são `TextColumn` em
/// `YYYY-MM-DD`, hora local — nunca `DateTimeColumn`, que o Drift persistiria
/// como timestamp e reintroduziria fuso onde não existe fuso.
///
/// A referência a `debt_installments` ganha `.references(...)` quando essa
/// tabela existir (T-26) — não dá para referenciar uma tabela que ainda não
/// está na lista do `@DriftDatabase`.
class Transactions extends Table {
  TextColumn get id => text()();

  /// 'expense' | 'income' | 'investment_in' | 'investment_out' | 'debt_payment'.
  TextColumn get kind => text()();

  IntColumn get amountCents => integer().named('amount_cents')();

  TextColumn get occurredOn => text().named('occurred_on')();
  TextColumn get description => text().nullable()();

  /// `description` em minúscula e sem acento (RF-14) — gravada, não
  /// calculada em tempo de consulta: o `LIKE` do SQLite não faz *accent
  /// folding*.
  TextColumn get descriptionNorm =>
      text().named('description_norm').nullable()();

  /// 'debit' | 'credit' | 'pix' | 'cash' | null.
  TextColumn get paymentMethod => text().named('payment_method').nullable()();

  TextColumn get nicheId => text().named('niche_id').nullable()();
  TextColumn get incomeSourceId => text()
      .named('income_source_id')
      .nullable()
      .references(IncomeSources, #id)();
  TextColumn get investmentId =>
      text().named('investment_id').nullable().references(Investments, #id)();
  TextColumn get debtInstallmentId =>
      text().named('debt_installment_id').nullable()();

  /// null | 'monthly'.
  TextColumn get recurrence => text().nullable()();
  TextColumn get recurrenceGroupId =>
      text().named('recurrence_group_id').nullable()();

  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();

  /// Soft delete. Nulo significa vivo.
  TextColumn get deletedAt => text().named('deleted_at').nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['CHECK (amount_cents > 0)'];
}
