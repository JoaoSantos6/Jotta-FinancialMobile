import 'dart:math';
import 'dart:typed_data';

/// Chave de 256 bits do SQLCipher (SEG-1).
///
/// Existe para que a chave nunca vire uma `String` solta: `String` cru aparece em
/// log, em mensagem de exceção e no `toString()` de qualquer objeto que a
/// contenha. Ver [toString] — redigido, não a representação padrão.
final class DatabaseKey {
  DatabaseKey._(this._bytes);

  /// Gera 32 bytes com CSPRNG (`Random.secure`) — nunca `Random()` comum, que
  /// não é seguro para material criptográfico.
  factory DatabaseKey.generate() {
    final random = Random.secure();
    final bytes = Uint8List(_keyLengthBytes);
    for (var i = 0; i < _keyLengthBytes; i++) {
      bytes[i] = random.nextInt(256);
    }
    return DatabaseKey._(bytes);
  }

  factory DatabaseKey.fromBytes(Uint8List bytes) {
    if (bytes.length != _keyLengthBytes) {
      throw ArgumentError(
        'DatabaseKey precisa de exatamente $_keyLengthBytes bytes, '
        'recebeu ${bytes.length}',
      );
    }
    return DatabaseKey._(Uint8List.fromList(bytes));
  }

  factory DatabaseKey.fromHex(String hex) {
    if (hex.length != _keyLengthBytes * 2 || !_hexPattern.hasMatch(hex)) {
      throw FormatException(
        'DatabaseKey.fromHex espera ${_keyLengthBytes * 2} caracteres hex, '
        'recebeu: "$hex"',
      );
    }
    final bytes = Uint8List(_keyLengthBytes);
    for (var i = 0; i < _keyLengthBytes; i++) {
      bytes[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    }
    return DatabaseKey._(bytes);
  }

  static const _keyLengthBytes = 32;
  static final _hexPattern = RegExp(r'^[0-9a-fA-F]+$');

  final Uint8List _bytes;

  /// Forma aceita pelo SQLCipher como raw key: `x'<64 hex>'`. Sem KDF por
  /// cima — a chave já tem 256 bits de entropia de CSPRNG (docs/DECISIONS.md).
  String get pragmaLiteral => "x'${toHex()}'";

  /// Só deve ser chamado por [pragmaLiteral] e por quem persiste a chave no
  /// Keystore ([KeystoreDatabaseKeyStore]). `tool/ci/check_logs.sh` reprova o
  /// build se `toHex()` aparecer em qualquer outro arquivo (RNF-16).
  String toHex() =>
      _bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
