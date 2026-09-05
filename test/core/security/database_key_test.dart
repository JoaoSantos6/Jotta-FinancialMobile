import 'dart:typed_data';

import 'package:financial/core/security/database_key.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DatabaseKey.generate', () {
    test('produz 32 bytes', () {
      expect(DatabaseKey.generate().toHex().length, 64);
    });

    test('produz hex válido', () {
      final hex = DatabaseKey.generate().toHex();
      expect(RegExp(r'^[0-9a-f]{64}$').hasMatch(hex), isTrue);
    });

    test('duas gerações consecutivas produzem chaves diferentes', () {
      final a = DatabaseKey.generate();
      final b = DatabaseKey.generate();
      expect(a.toHex(), isNot(b.toHex()));
    });
  });

  group('DatabaseKey.pragmaLiteral', () {
    test("tem a forma x'<64 hex>'", () {
      final key = DatabaseKey.generate();
      expect(key.pragmaLiteral, "x'${key.toHex()}'");
      expect(RegExp(r"^x'[0-9a-f]{64}'$").hasMatch(key.pragmaLiteral), isTrue);
    });
  });

  group('DatabaseKey.toString', () {
    test('nunca contém o material da chave', () {
      final key = DatabaseKey.generate();
      final interpolated = 'chave gerada: $key';
      expect(interpolated.contains(key.toHex()), isFalse);
      expect(key.toString(), 'DatabaseKey(<redigida>)');
    });
  });

  group('DatabaseKey.fromBytes', () {
    test('aceita exatamente 32 bytes', () {
      final bytes = Uint8List(32);
      expect(() => DatabaseKey.fromBytes(bytes), returnsNormally);
    });

    test('rejeita 31 bytes', () {
      expect(() => DatabaseKey.fromBytes(Uint8List(31)), throwsArgumentError);
    });

    test('rejeita 33 bytes', () {
      expect(() => DatabaseKey.fromBytes(Uint8List(33)), throwsArgumentError);
    });
  });

  group('DatabaseKey.fromHex', () {
    test('faz round-trip com toHex()', () {
      final original = DatabaseKey.generate();
      final roundTripped = DatabaseKey.fromHex(original.toHex());
      expect(roundTripped.toHex(), original.toHex());
    });

    test('rejeita string com caractere não-hex', () {
      final invalid = 'g${'0' * 63}';
      expect(() => DatabaseKey.fromHex(invalid), throwsFormatException);
    });

    test('rejeita comprimento errado', () {
      expect(() => DatabaseKey.fromHex('abcd'), throwsFormatException);
    });
  });
}
