#!/bin/bash
set -euo pipefail

echo "=== Trackpad verify ($(date)) ==="
echo

# Captura uma unica vez (ioreg -l e lento) e evita pipe produtor -> grep -q,
# que mata o produtor com SIGPIPE e dispara falso FAIL via pipefail.
KEXTSTAT=$(kextstat 2>/dev/null)
IOREG=$(ioreg -l 2>/dev/null)

echo "--- kextstat (Voodoo / I2C / PS2) ---"
grep -iE 'Voodoo|I2C|PS2' <<< "$KEXTSTAT" || true
echo
echo "--- I2C device (expect ELAN050A + PrecisionTouchpad) ---"
grep -E 'ELAN050A|VoodooI2CPrecisionTouchpad|VoodooI2CHIDDevice' <<< "$IOREG" | grep -v 'IOKitDiagnostics' | head -20 || true
echo
echo "--- PS2 Mouse (expect empty / not loaded) ---"
if grep -q 'PS2Mouse' <<< "$KEXTSTAT"; then
  echo "FAIL: VoodooPS2Mouse ainda carregado"
  exit 1
else
  echo "OK: VoodooPS2Mouse nao carregado"
fi
echo
if grep -q 'ELAN050A' <<< "$IOREG"; then
  echo "OK: ELAN050A presente"
else
  echo "FAIL: ELAN050A ausente"
  exit 1
fi
if grep -q 'VoodooI2CPrecisionTouchpad' <<< "$IOREG"; then
  echo "OK: VoodooI2CPrecisionTouchpad ativo"
else
  echo "FAIL: PrecisionTouchpad ausente"
  exit 1
fi
echo
echo "=== verify passed ==="
