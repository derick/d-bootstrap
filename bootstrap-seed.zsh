#!/bin/zsh

set -e

blue() { /usr/bin/printf "\033[36m%s\033[0m\n" "$1"; }
green() { /usr/bin/printf "\033[32m%s\033[0m\n" "$1"; }
yellow() { /usr/bin/printf "\033[33m%s\033[0m\n" "$1"; }
red() { /usr/bin/printf "\033[31m%s\033[0m\n" "$1"; }

blue "== d-bootstrap seed =="

ARCH="$(/usr/bin/uname -m)"

if [ "$ARCH" = "arm64" ]; then
  BREW_BIN="/opt/homebrew/bin/brew"
else
  BREW_BIN="/usr/local/bin/brew"
fi

blue "== Checking Homebrew =="

if [ -x "$BREW_BIN" ]; then
  green "Homebrew found at $BREW_BIN"
else
  yellow "Homebrew not found at $BREW_BIN"
  yellow "Installing Homebrew now."

  /bin/bash -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ ! -x "$BREW_BIN" ]; then
    red "Homebrew install finished, but brew was not found at expected path: $BREW_BIN"
    red "Open a new Terminal window and re-run the bootstrap command."
    exit 1
  fi

  green "Homebrew installed at $BREW_BIN"
fi

blue "== Checking Dropbox =="

if [ -d "/Applications/Dropbox.app" ]; then
  green "Dropbox.app found."
else
  yellow "Dropbox.app not found."
  yellow "Installing Dropbox with Homebrew cask."

  "$BREW_BIN" install --cask dropbox

  if [ -d "/Applications/Dropbox.app" ]; then
    green "Dropbox.app installed."
  else
    red "Dropbox install command finished, but /Applications/Dropbox.app was not found."
    red "Install Dropbox manually, sign in, then continue with ~/Dropbox/d-scripts."
    exit 1
  fi
fi

blue "== Opening Dropbox =="

/usr/bin/open -a Dropbox || true

blue "== Next steps =="

/usr/bin/printf "\n"
green "1. Sign into Dropbox."
green "2. Wait for ~/Dropbox/d-scripts to sync."
green "3. Then run:"
/usr/bin/printf "\n"
printf "   ~/Dropbox/d-scripts/bin/d-bootstrap-v1\n"
printf "   ~/Dropbox/d-scripts/bin/d-brew-apply\n"
printf "   ~/Dropbox/d-scripts/bin/d-fresh-mac-checklist\n"
printf "   ~/Dropbox/d-scripts/bin/d-fresh-mac-verify\n"
printf "   ~/Dropbox/d-scripts/bin/d-verify-v1\n"
/usr/bin/printf "\n"
green "Public bootstrap complete."
