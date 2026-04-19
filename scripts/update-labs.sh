#!/bin/bash
echo "Updating all community labs..."
cd labs/community
for dir in */; do
  if [ -d "$dir/.git" ]; then
    echo "→ Updating $dir"
    (cd "$dir" && git pull)
  fi
done
echo "✅ All labs updated!"