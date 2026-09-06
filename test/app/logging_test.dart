import 'package:financial/app/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final originalDebugPrint = debugPrint;

  tearDown(() {
    debugPrint = originalDebugPrint;
  });

  test('isRelease: true — debugPrint vira uma função vazia', () {
    installLogging(isRelease: true);

    // A referência global mudou para uma função que não faz nada — não há
    // caminho de código que produza saída, então chamar não pode lançar.
    expect(debugPrint, isNot(same(originalDebugPrint)));
    expect(() => debugPrint('segredo'), returnsNormally);
  });

  test('isRelease: false — debugPrint continua o original (produz saída)', () {
    installLogging(isRelease: false);
    expect(debugPrint, same(originalDebugPrint));
  });
}
