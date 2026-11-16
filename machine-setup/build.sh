#!user/bin/env bash 

set -euo pipefail 
cd "$(dirname "$0")"

if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "Finish the CLT installer, then re-run this script."; exit 1
fi

if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle --file=Brewfile
