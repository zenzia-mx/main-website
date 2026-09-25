#!/usr/bin/env bash
# Promote one of the designs in options/ to the site root, which is what the
# Azure Static Web Apps workflow deploys.
#
#   ./use-option.sh 03            # by number
#   ./use-option.sh 03-ondas      # by folder name
#
set -euo pipefail

root="$(cd "$(dirname "$0")" && pwd)"
choice="${1-}"

list() {
  echo "Available options:"
  for d in "$root"/options/*/; do
    printf '  %s\n' "$(basename "$d")"
  done
}

if [ -z "$choice" ]; then
  echo "Usage: ./use-option.sh <option>" >&2
  list >&2
  exit 1
fi

src=""
for d in "$root"/options/*/; do
  name="$(basename "$d")"
  if [ "$name" = "$choice" ] || [ "${name%%-*}" = "$choice" ]; then
    src="$d"
    break
  fi
done

if [ -z "$src" ]; then
  echo "No option matches '$choice'." >&2
  list >&2
  exit 1
fi

# Rewrite the option-relative asset paths (../../assets/) to root-relative ones.
sed 's#\.\./\.\./assets/#./assets/#g' "$src/index.html"  > "$root/index.html"
sed 's#\.\./\.\./assets/#./assets/#g' "$src/styles.css"  > "$root/styles.css"

echo "Deployed option: $(basename "$src")"
echo "Root index.html and styles.css updated. Commit and push to publish."
