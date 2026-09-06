#!/usr/bin/env bash
# T-47, T-48, T-49 — travas de manifest sobre o APK CONSTRUÍDO, não o
# arquivo-fonte: uma dependência transitiva pode reintroduzir
# `allowBackup="true"` ou uma permissão sem que uma linha do nosso código
# mude (risco A4, docs/adr-1/PRD.md).
#
# Uso: tool/ci/check_manifest.sh <caminho-do-apk>
#
# Falha (exit != 0) se:
#   1. Houver qualquer <uses-permission> fora de tool/ci/permissions.baseline
#      (T-49) — o que cobre a INTERNET (T-47) como caso particular: o
#      baseline está vazio, então QUALQUER permissão é uma novidade.
#   2. android:allowBackup não for "false" (T-48).
#   3. As regras de extração de dados não estiverem declaradas (T-48).
set -euo pipefail

apk_path="${1:?uso: check_manifest.sh <caminho-do-apk>}"
baseline_path="$(dirname "$0")/permissions.baseline"

if [[ ! -f "$apk_path" ]]; then
  echo "ERRO: APK não encontrado em $apk_path" >&2
  exit 1
fi

# Resolve aapt2: no PATH, ou sob $ANDROID_HOME/build-tools/<versão>/aapt2 —
# os runners hospedados do GitHub têm o SDK do Android pré-instalado.
resolve_aapt2() {
  if command -v aapt2 >/dev/null 2>&1; then
    command -v aapt2
    return
  fi
  local candidate
  candidate="$(find "${ANDROID_HOME:-$ANDROID_SDK_ROOT}/build-tools" \
    -maxdepth 1 -mindepth 1 -type d 2>/dev/null | sort -V | tail -1)"
  if [[ -n "$candidate" && -x "$candidate/aapt2" ]]; then
    echo "$candidate/aapt2"
    return
  fi
  echo "ERRO: aapt2 não encontrado (nem no PATH, nem em \$ANDROID_HOME/build-tools)" >&2
  exit 1
}

aapt2="$(resolve_aapt2)"

dump="$("$aapt2" dump badging "$apk_path")"

echo "=== Permissões declaradas no APK ==="
permissions="$(echo "$dump" | grep "^uses-permission:" | sed -E "s/.*name='([^']+)'.*/\1/" | sort -u || true)"
echo "$permissions"

# --- 1 e 3: baseline de permissões (T-49), cobre INTERNET (T-47) ---
baseline="$(sort -u "$baseline_path" 2>/dev/null || true)"
extra_permissions="$(comm -23 <(echo "$permissions") <(echo "$baseline") | sed '/^$/d')"

if [[ -n "$extra_permissions" ]]; then
  echo "" >&2
  echo "REPROVADO: permissão(ões) fora do baseline versionado" \
    "(tool/ci/permissions.baseline):" >&2
  echo "$extra_permissions" | sed 's/^/  - /' >&2
  echo "" >&2
  echo "Se a permissão é intencional, adicione-a a permissions.baseline" \
    "num PR dedicado — permissão nova é sempre decisão explícita" \
    "(guarda-chuva §6.6)." >&2
  exit 1
fi

# --- 2 e 3: allowBackup e regras de extração (T-48) ---
if echo "$dump" | grep -q "allowBackup='true'"; then
  echo "REPROVADO: android:allowBackup='true' no manifest merged" \
    "(SEG-4)." >&2
  exit 1
fi

if ! "$aapt2" dump xmltree "$apk_path" --file AndroidManifest.xml \
    | grep -q "dataExtractionRules"; then
  echo "REPROVADO: dataExtractionRules ausente do manifest merged" \
    "(SEG-4) — o merge de alguma dependência pode ter removido o" \
    "atributo." >&2
  exit 1
fi

echo ""
echo "OK: manifest sem permissão fora do baseline, allowBackup não é" \
  "'true', dataExtractionRules presente."
