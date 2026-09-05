/// Resultado de uma operação que pode falhar de forma esperada.
///
/// Falha esperada (Keystore indisponível, chave corrompida, senha errada) vira
/// [Result]; bug de programação continua sendo exceção. Deliberadamente mínimo:
/// sem `map`, `flatMap` ou outros combinadores que este ADR não usa.
sealed class Result<T, F> {
  const Result();

  /// Chama [ok] se este for um [Ok], [err] se for um [Err]. Nunca os dois.
  R fold<R>({
    required R Function(T value) ok,
    required R Function(F failure) err,
  });
}

final class Ok<T, F> extends Result<T, F> {
  const Ok(this.value);

  final T value;

  @override
  R fold<R>({
    required R Function(T value) ok,
    required R Function(F failure) err,
  }) => ok(value);
}

final class Err<T, F> extends Result<T, F> {
  const Err(this.failure);

  final F failure;

  @override
  R fold<R>({
    required R Function(T value) ok,
    required R Function(F failure) err,
  }) => err(failure);
}
