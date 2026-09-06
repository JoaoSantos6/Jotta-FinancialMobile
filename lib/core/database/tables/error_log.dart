import 'package:drift/drift.dart';

/// Métrica M5 (guarda-chuva §2) e SEG-6: guarda o que aconteceu, nunca o dado
/// que causou. Não há coluna para valor, descrição ou nome de credor — e
/// essa ausência é a garantia estrutural, não uma disciplina de quem
/// escreve o código que insere aqui (docs/adr-1/TASK.md, T-24).
class ErrorLog extends Table {
  TextColumn get id => text()();

  /// ISO 8601 local.
  TextColumn get occurredAt => text().named('occurred_at')();

  /// Nome da exceção.
  TextColumn get type => text()();

  /// Rota onde ocorreu.
  TextColumn get screen => text().nullable()();

  TextColumn get stack => text()();

  @override
  Set<Column> get primaryKey => {id};
}
