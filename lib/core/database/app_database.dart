import 'package:drift/drift.dart';

import 'tables/niches.dart';
import 'tables/transactions.dart';

part 'app_database.g.dart';

/// Schema v1 do banco (guarda-chuva §5.3, emendado em 2026-09-05 com
/// `description_norm`, `app_usage_days` e `error_log`).
///
/// `enableMigrations` no `NativeDatabase.opened` (ver `providers.dart`) faz o
/// Drift gerenciar o `PRAGMA user_version` e chamar [migration] sozinho.
@DriftDatabase(tables: [Niches, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    // Não existe v2 ainda. Um onUpgrade vazio que aceita qualquer versão é
    // uma armadilha esperando o próximo ADR — melhor recusar explicitamente
    // (docs/adr-1/PRD.md, §8, AB-2).
    onUpgrade: (m, from, to) async {
      throw UnsupportedError(
        'Não existe migração de schema definida ainda (schemaVersion == 1). '
        'from=$from to=$to',
      );
    },
  );
}
