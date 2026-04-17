#!/bin/zsh

set -e

REPO="$HOME/Developer/Rust/helix"
RUNTIME_DIR="$HOME/.config/helix/runtime"

echo "==> Building helix-term..."
cd "$REPO"
cargo install --path helix-term --locked

echo "==> Copying runtime..."
mkdir -p "$RUNTIME_DIR"

rsync -a --delete "$REPO/runtime/" "$RUNTIME_DIR/"

echo "==> Setting HELIX_RUNTIME (if not already set)..."
if ! grep -q "HELIX_RUNTIME" "$HOME/.zshrc"; then
  echo 'export HELIX_RUNTIME="$HOME/.config/helix/runtime"' >> "$HOME/.zshrc"
  echo "Added HELIX_RUNTIME to ~/.zshrc"
else
  echo "HELIX_RUNTIME already set, skipping"
fi

echo "==> Done."
echo "Run: source ~/.zshrc"
echo "Then: hx --health"
