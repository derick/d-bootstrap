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
    red "Install Dropbox manually, sign in, then continue after Dropbox syncs."
    exit 1
  fi
fi

blue "== Opening Dropbox =="

/usr/bin/open -a Dropbox || true

blue "== Checking ChatGPT =="

if [ -d "/Applications/ChatGPT.app" ]; then
  green "ChatGPT.app found."
else
  yellow "ChatGPT.app not found."
  yellow "Installing ChatGPT with Homebrew cask."

  "$BREW_BIN" install --cask chatgpt

  if [ -d "/Applications/ChatGPT.app" ]; then
    green "ChatGPT.app installed."
  else
    yellow "ChatGPT install command finished, but /Applications/ChatGPT.app was not found."
    yellow "You can install ChatGPT manually later if needed."
  fi
fi

blue "== Opening ChatGPT =="

/usr/bin/open -a ChatGPT || true

blue "== Next steps =="

/usr/bin/printf "\n"
green "1. Sign into Dropbox."
green "2. Wait for Dropbox to show your d-scripts and d-bootstrap folders."
green "3. In Finder, right-click these folders and choose Make Available Offline:"
/usr/bin/printf "\n"
printf "   /Users/derick/Dropbox/d-scripts\n"
printf "   /Users/derick/Dropbox/d-bootstrap\n"
/usr/bin/printf "\n"
green "4. Sign into ChatGPT on this Mac."
green "5. Continue from ChatGPT on this Mac, not from another device."
green "6. Then run this fresh-Mac finish block:"
/usr/bin/printf "\n"
printf "   cd /Users/derick/Dropbox/d-scripts || exit 1\n"
printf "   /bin/chmod +x bin/d-*\n"
printf "   bin/d-fresh-mac-finish\n"
/usr/bin/printf "\n"
yellow "Do not run private d-scripts commands until Dropbox folders are available offline."
yellow "Dropbox online-only placeholders can appear as zero-byte files."
yellow "If d-scripts files look empty or scripts print nothing, check Finder and choose Make Available Offline."
/usr/bin/printf "\n"
green "Public bootstrap complete."