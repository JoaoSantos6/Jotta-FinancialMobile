import 'package:financial/core/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('Ok.fold chama o ramo ok, nunca o err', () {
      const Result<int, String> result = Ok(42);
      var okCalled = false;
      var errCalled = false;

      final value = result.fold(
        ok: (v) {
          okCalled = true;
          return v;
        },
        err: (f) {
          errCalled = true;
          return -1;
        },
      );

      expect(value, 42);
      expect(okCalled, isTrue);
      expect(errCalled, isFalse);
    });

    test('Err.fold chama o ramo err, nunca o ok', () {
      const Result<int, String> result = Err('deu ruim');
      var okCalled = false;
      var errCalled = false;

      final value = result.fold(
        ok: (v) {
          okCalled = true;
          return v;
        },
        err: (f) {
          errCalled = true;
          return -1;
        },
      );

      expect(value, -1);
      expect(okCalled, isFalse);
      expect(errCalled, isTrue);
    });
  });
}
