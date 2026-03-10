#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="${1:-.}"
OUTPUT_CSV="${2:-pdf_inventory.csv}"

# CSV header
echo "file_name,file_path,file_size_mb,page_count" >"$OUTPUT_CSV"

# Use find with null separator for safety
find "$ROOT_DIR" -type f -iname "*.pdf" -print0 |
  while IFS= read -r -d '' file; do
    # File name
    file_name="$(basename "$file")"

    # Absolute path
    file_path="$(realpath "$file")"

    # File size in bytes
    file_size_bytes="$(stat -c%s "$file" 2>/dev/null || echo 0)"
    file_size="$(awk -v s="$file_size_bytes" 'BEGIN { printf "%.2f", s/1024/1024 }')"

    # Page count (fallback to 0 if pdfinfo fails)
    page_count="$(pdfinfo "$file" 2>/dev/null | awk -F': *' '/^Pages/ {print $2}' || true)"
    page_count="${page_count:-0}"

    # Escape quotes for CSV safety
    esc_name="${file_name//\"/\"\"}"
    esc_path="${file_path//\"/\"\"}"

    echo "\"$esc_name\",\"$esc_path\",$file_size,$page_count" >>"$OUTPUT_CSV"
  done

echo "✅ CSV generated at: $OUTPUT_CSV"
