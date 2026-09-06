#!/usr/bin/env bash
# T-50, T-51 — higiene de log e do material da chave (SEG-6, RNF-16).
#
# Roda sobre lib/**.dart, excluindo código gerado (*.g.dart) — geradores não
# são nosso código e não são revisados linha a linha.
set -euo pipefail

cd "$(dirname "$0")/../.."

fail=0

dart_files() {
  find lib -name '*.dart' ! -name '*.g.dart'
}

# --- T-50: nenhum print/debugPrint com valor monetário ou segredo ---
# `avoid_print` (T-05) já barra `print()` em lib/ inteiro. Esta trava é a
# segunda camada, independente do lint: mesmo debugPrint (que vira no-op em
# release pela T-38) não pode carregar esses identificadores no código-fonte
# — defesa em profundidade, não confiar só no comportamento em runtime.
sensitive_log_pattern='(Cents|amount|valor|saldo|balance|password|senha)'

log_violations="$(
  dart_files | xargs grep -nE "(debugPrint|print)\\(.*${sensitive_log_pattern}" \
    2>/dev/null || true
)"

if [[ -n "$log_violations" ]]; then
  echo "REPROVADO (T-50, SEG-6): log com valor monetário ou segredo" >&2
  echo "$log_violations" | sed 's/^/  /' >&2
  fail=1
fi

# --- T-51: toHex() da chave só nos dois arquivos autorizados ---
allowed_files='lib/core/security/database_key.dart|lib/core/security/keystore_database_key_store.dart'

hex_violations="$(
  dart_files | xargs grep -nE '\.toHex\(\)' 2>/dev/null \
    | grep -vE "^(${allowed_files}):" || true
)"

if [[ -n "$hex_violations" ]]; then
  echo "REPROVADO (T-51, RNF-16): toHex() da chave fora dos arquivos" \
    "autorizados" >&2
  echo "$hex_violations" | sed 's/^/  /' >&2
  fail=1
fi

if [[ "$fail" -eq 0 ]]; then
  echo "OK: nenhum log sensível, toHex() só nos arquivos autorizados."
fi

exit "$fail"
