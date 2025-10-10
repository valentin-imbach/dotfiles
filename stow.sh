#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"
mkdir -p ~/.config

echo "Stowing all directories in $(pwd) to ~/.config ..."
stow -t ~/.config .
echo "✅ All stowed successfully into ~/.config"

