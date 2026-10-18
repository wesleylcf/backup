#!/usr/bin/env bash
# Install or update obra/superpowers skills as Manus Desktop user skills.
# Re-run any time to pull the latest upstream version and re-apply the Manus overlay.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
SRC="$HERE/superpowers"
OVERLAY="$HERE/overlay"
MANIFEST="$HERE/installed-skills.txt"
DEST="${MANUS_USER_SKILLS_DIR:-$HOME/.manus/user-skills}"
REPO_URL="https://github.com/obra/superpowers.git"

if [ -d "$SRC/.git" ]; then
  git -C "$SRC" pull --ff-only --quiet
else
  git clone --depth 1 --quiet "$REPO_URL" "$SRC"
fi
COMMIT="$(git -C "$SRC" rev-parse --short HEAD)"

mkdir -p "$DEST"
new_list="$(mktemp)"
for dir in "$SRC"/skills/*/; do
  name="$(basename "$dir")"
  [ -f "$dir/SKILL.md" ] || continue
  rsync -a --delete "$dir" "$DEST/$name/"
  echo "$name" >> "$new_list"
done

# Remove skills this script installed previously that upstream has since dropped.
if [ -f "$MANIFEST" ]; then
  while IFS= read -r old; do
    [ -n "$old" ] || continue
    if ! grep -qx "$old" "$new_list" && [ -d "$DEST/$old" ]; then
      rm -rf "${DEST:?}/$old"
      echo "removed stale skill: $old"
    fi
  done < "$MANIFEST"
fi
mv "$new_list" "$MANIFEST"

# Manus adaptation overlay (tool mapping reference).
# Copy only the overlay's contents with normal permissions, so the user-skills root keeps its mode.
for item in "$OVERLAY"/*; do
  rsync -a --chmod=Du=rwx,Dgo=rx,Fu=rw,Fgo=r "$item" "$DEST"/
done

# Register Manus in the using-superpowers "Platform Adaptation" list.
python3 - "$DEST/using-superpowers/SKILL.md" <<'PY'
import re, sys
path = sys.argv[1]
text = open(path, encoding="utf-8").read()
entry = "- Manus: `references/manus-tools.md`"
if entry not in text:
    lines = text.split("\n")
    start = next(i for i, l in enumerate(lines) if l.strip() == "## Platform Adaptation")
    end = next((i for i in range(start + 1, len(lines)) if lines[i].startswith("## ")), len(lines))
    last = max(i for i in range(start, end) if re.match(r"^- .*`references/[a-z-]+-tools\.md`", lines[i]))
    lines.insert(last + 1, entry)
    open(path, "w", encoding="utf-8").write("\n".join(lines))
PY

echo "superpowers @ $COMMIT installed to $DEST: $(wc -l < "$MANIFEST" | tr -d ' ') skills"
