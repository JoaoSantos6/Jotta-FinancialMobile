import 'package:flutter/foundation.dart';

/// Instala o comportamento de log do processo. Chamada uma vez, no início
/// de `main()`.
///
/// Em release, substitui `debugPrint` por uma função vazia: nenhum log do
/// app chega ao logcat, nem por engano, nem por dependência que use
/// `debugPrint` (SEG-6).
///
/// [isRelease] existe por testabilidade: `kReleaseMode` é `const` e não pode
/// ser alternado dentro da suíte. `main()` passa `kReleaseMode`; o teste
/// passa os dois valores.
void installLogging({required bool isRelease}) {
  if (isRelease) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
}
