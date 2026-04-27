#!/bin/bash
# sync-vault.sh — Syncs the local Harmonia vault into Quartz content/
# Run this before committing to publish updates.
set -e

VAULT="/Users/mitch/Harmonia/"
CONTENT="$(cd "$(dirname "$0")" && pwd)/content/"

echo "Syncing vault → content/..."
rsync -av --delete \
  --exclude='.DS_Store' \
  --exclude='.obsidian/' \
  --exclude='CLAUDE.md' \
  --exclude='08-Stakeholders/' \
  --exclude='Templates/' \
  --exclude='_assets/' \
  "$VAULT" "$CONTENT"

# Quartz serves index.md at / — copy Home.md so the root URL gets an index.html
cp "${CONTENT}Home.md" "${CONTENT}index.md"

echo ""
echo "✓ Sync complete."
echo ""
echo "Review changes, then publish:"
echo "  git add -A && git commit -m 'update vault content' && git push origin main"
