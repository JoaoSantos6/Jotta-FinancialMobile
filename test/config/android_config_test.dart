// T-01 — identidade definitiva do app.
//
// `applicationId` não pode mudar depois da primeira instalação com dado real: o
// banco (SEG-1) é irrecuperável, e trocar o id obriga a desinstalar. Este teste
// trava o valor lendo o arquivo de build real, não uma cópia dele.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('android/app/build.gradle.kts', () {
    late String gradle;

    setUpAll(() {
      gradle = File('android/app/build.gradle.kts').readAsStringSync();
    });

    String valueOf(String key) {
      final match = RegExp('$key\\s*=\\s*"([^"]+)"').firstMatch(gradle);
      expect(
        match,
        isNotNull,
        reason: 'esperava encontrar `$key = "..."` em build.gradle.kts',
      );
      return match!.group(1)!;
    }

    test('applicationId é com.jotta.financial', () {
      expect(valueOf('applicationId'), 'com.jotta.financial');
    });

    test('namespace é coerente com o applicationId', () {
      expect(valueOf('namespace'), 'com.jotta.financial');
    });

    test('minSdk é 26 (RNF-1), não o padrão do Flutter', () {
      final match = RegExp(r'minSdk\s*=\s*(\d+)').firstMatch(gradle);
      expect(
        match,
        isNotNull,
        reason:
            'minSdk deve ser um literal inteiro, não flutter.minSdkVersion — '
            'RNF-1 exige o valor 26 fixo, independente do padrão do Flutter',
      );
      expect(int.parse(match!.group(1)!), 26);
    });
  });
}
