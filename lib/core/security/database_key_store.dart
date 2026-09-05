import 'package:financial/core/result/result.dart';
import 'package:financial/core/security/database_key.dart';

/// Guarda a [DatabaseKey] do banco fora do alcance do app e de backups
/// (Android Keystore, com respaldo em hardware quando o aparelho oferecer).
abstract interface class DatabaseKeyStore {
  /// Devolve a chave existente ou gera e persiste uma na primeira chamada.
  /// Chamadas seguintes devolvem sempre a mesma chave.
  ///
  /// Não é atômico entre processos, e não precisa ser: o app tem um único
  /// processo e a chamada acontece uma vez, no bootstrap, antes de qualquer UI.
  Future<Result<DatabaseKey, KeyStoreFailure>> getOrCreate();

  /// Apaga o material do Keystore. Primitiva para o RF-29 (M5) — "apagar
  /// todos os dados". Depois disso, [getOrCreate] gera uma chave nova, e o
  /// banco antigo fica ilegível para sempre (SEG-8).
  Future<Result<void, KeyStoreFailure>> destroy();
}

sealed class KeyStoreFailure {
  const KeyStoreFailure();
}

/// O Keystore/hardware recusou a operação — aparelho sem suporte, ou o SO
/// negou o acesso.
final class KeystoreUnavailable extends KeyStoreFailure {
  const KeystoreUnavailable();
}

/// O valor lido do storage não é um hex de 64 caracteres válido. Nunca
/// sobrescreve o valor existente: gerar uma chave nova por cima de um valor
/// ilegível transformaria um erro de leitura na destruição permanente do banco.
final class KeyCorrupted extends KeyStoreFailure {
  const KeyCorrupted();
}
