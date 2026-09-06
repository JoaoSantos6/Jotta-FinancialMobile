import 'package:drift/drift.dart';

/// Métrica M1 (guarda-chuva §2): um dia com sessão = uma linha. `day` como PK
/// torna a contagem idempotente — registrar o mesmo dia duas vezes não
/// duplica. Fica vazia até o M5 preenchê-la; dia não registrado é dia
/// perdido para sempre (docs/adr-1/PRD.md, AB-2).
class AppUsageDays extends Table {
  /// 'YYYY-MM-DD', hora local.
  TextColumn get day => text()();

  @override
  Set<Column> get primaryKey => {day};
}
