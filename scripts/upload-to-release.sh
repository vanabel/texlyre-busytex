#!/bin/bash

VERSION=$(node -p "require('./package.json').version")
REMOTE_URL=$(git remote get-url origin)
REPO=$(echo "$REMOTE_URL" | sed -E 's#(git@github.com:|https://github.com/)##; s#\.git$##')
RELEASE_TAG="assets-v$VERSION"
ARCHIVE_NAME="busytex-assets.tar.gz"

echo "Creating archive from public/core/busytex..."
echo "Version: v$VERSION"
cd public/core
tar -czf ../../$ARCHIVE_NAME busytex/
cd ../..

echo "Creating release $RELEASE_TAG..."
gh release create "$RELEASE_TAG" \
  --repo "$REPO" \
  --title "BusyTeX Assets v$VERSION" \
  --notes "Complete BusyTeX WASM assets archive" \
  $ARCHIVE_NAME

rm $ARCHIVE_NAME
echo "✓ Assets uploaded to GitHub Releases"
echo "Download URL: https://github.com/$REPO/releases/download/$RELEASE_TAG/$ARCHIVE_NAME"