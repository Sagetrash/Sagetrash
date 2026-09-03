#!/usr/bin/env bash
# ==============================================================================
# export_pdf.sh
# Generates a pixel-perfect A4 PDF resume from index.html using headless browser
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT_FILE="$SCRIPT_DIR/index.html"
OUTPUT_FILE="$SCRIPT_DIR/Ayush_Sharma_Resume.pdf"

# Find available browser binary
CHROME_BIN=""
for bin in google-chrome google-chrome-stable chromium-browser chromium brave-browser brave microsoft-edge; do
  if command -v "$bin" >/dev/null 2>&1; then
    CHROME_BIN="$bin"
    break
  fi
done

if [ -z "$CHROME_BIN" ]; then
  echo "Error: No compatible Chromium-based browser found (google-chrome, chromium, or brave)." >&2
  exit 1
fi

echo "--> Using browser: $CHROME_BIN"
echo "--> Compiling: $INPUT_FILE to A4 PDF..."

"$CHROME_BIN" \
  --headless=new \
  --disable-gpu \
  --allow-file-access-from-files \
  --no-pdf-header-footer \
  --print-to-pdf="$OUTPUT_FILE" \
  "file://$INPUT_FILE"

echo "--> Success! Exported to: $OUTPUT_FILE"
