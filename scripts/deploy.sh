#!/bin/bash
set -euo pipefail

PHP="/opt/cpanel/ea-php84/root/usr/bin/php"
REPO="/home/crointhe/repositories/wiki"
SRC="$REPO/mediawiki"
DEST="/home/crointhe/public_html/w"

echo "=== Deploy MediaWiki: start ==="

echo "=== Step 0: sync repository ==="
cd "$REPO"
rm -f error_log
git reset --hard
git clean -fd
git pull --ff-only origin main || git pull origin main

if [ ! -d "$SRC" ]; then
  echo "[ERROR] Source path not found: $SRC"
  exit 1
fi

if [ ! -d "$DEST" ]; then
  echo "[ERROR] Destination path not found: $DEST"
  exit 1
fi

echo "=== Step 1: deploy code (exclude runtime data) ==="
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

# Keep runtime data out of deploy payload (images, LocalSettings, transient caches).
tar -C "$SRC" -cf "$TMP_DIR/deploy.tar" \
  --exclude='./images' \
  --exclude='./LocalSettings.php' \
  --exclude='./cache' \
  --exclude='./tmp' \
  .

tar -C "$DEST" -xf "$TMP_DIR/deploy.tar"

echo "=== Step 2: post-deploy checks ==="
if [ ! -f "$DEST/LocalSettings.php" ]; then
  echo "[ERROR] LocalSettings.php missing in destination after deploy"
  exit 1
fi

if [ -x "$PHP" ] && [ -f "$DEST/maintenance/run.php" ]; then
  "$PHP" "$DEST/maintenance/run.php" update --quick
else
  echo "[WARN] PHP binary or maintenance script not found, skipping update.php"
fi

echo "=== Deploy MediaWiki: completed ==="
