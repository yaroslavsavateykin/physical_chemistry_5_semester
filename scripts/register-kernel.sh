#!/usr/bin/env bash
# Регистрирует ядро Jupyter `physchem-uv` для .venv текущего проекта.
# Запускать после `uv sync`:
#   ./scripts/register-kernel.sh
# или
#   uv run bash scripts/register-kernel.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PY="$ROOT/.venv/bin/python3"
KERNEL_DIR="$ROOT/.venv/share/jupyter/kernels/physchem-uv"

if [ ! -x "$PY" ]; then
  echo "Ошибка: не найден $PY. Сначала выполните 'uv sync'." >&2
  exit 1
fi

mkdir -p "$KERNEL_DIR"
cat > "$KERNEL_DIR/kernel.json" <<EOF
{
 "argv": [
  "$PY",
  "-Xfrozen_modules=off",
  "-m",
  "ipykernel_launcher",
  "-f",
  "{connection_file}"
 ],
 "display_name": "Python 3 (physchem-uv)",
 "language": "python",
 "metadata": {
  "debugger": true
 }
}
EOF

echo "Ядро 'physchem-uv' зарегистрировано: $KERNEL_DIR"
"$PY" -m jupyter kernelspec list 2>/dev/null | grep -E "physchem-uv|Available" || true
