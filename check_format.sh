set -euo pipefail

files=$(git diff --cached --name-only --diff-filter=ACM -- '*.txt' || true)
[ -z "$files" ] && exit 0

fail=0
for f in $files; do
  echo "Проверка файла: $f"
  if git show ":$f" | grep -nE '[[:blank:]]+$' >/dev/null; then
    echo "$f: trailing whitespace"
    fail=1
  fi
done

[ $fail -eq 0 ] || exit 1
