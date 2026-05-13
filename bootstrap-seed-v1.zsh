#!/bin/zsh
set -u

BOLD="\033[1m"
RESET="\033[0m"
CYAN="\033[36m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
DIM="\033[2m"

section() {
  echo
  echo "${CYAN}${BOLD}== $1 ==${RESET}"
}

keep() {
  echo "${GREEN}${BOLD}KEEP${RESET}   $1"
}

review() {
  echo "${YELLOW}${BOLD}REVIEW${RESET} $1"
}

fail() {
  echo "${RED}${BOLD}FAIL${RESET}   $1"
}

stop_now() {
  echo
  echo "${RED}${BOLD}STOP${RESET}   $1"
  exit 1
}

echo "${BOLD}d-scripts public bootstrap seed v1${RESET}"
echo "${DIM}Minimal public-safe setup seed. Private setup lives in Dropbox.${RESET}"

section "Platform"

arch_name="$(/usr/bin/arch 2>/dev/null || echo unknown)"
echo "Architecture: $arch_name"

if [ "$arch_name" = "arm64" ]; then
  keep "Apple Silicon detected"
else
  review "This script is designed around Apple Silicon Macs."
fi

section "Homebrew"

if [ -x /opt/homebrew/bin/brew ]; then
  keep "Homebrew already installed at /opt/homebrew/bin/brew"
else
  review "Homebrew missing. Installing Homebrew now."
  /bin/bash -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ ! -x /opt/homebrew/bin/brew ]; then
  fail "Homebrew still missing after install attempt"
  stop_now "Install Homebrew manually, then rerun this script."
fi

keep "Homebrew ready"

section "Dropbox"

if [ -d "/Applications/Dropbox.app" ]; then
  keep "Dropbox.app already exists"
else
  review "Dropbox.app missing. Installing Dropbox cask."
  /opt/homebrew/bin/brew install --cask dropbox
fi

if [ -d "/Applications/Dropbox.app" ]; then
  keep "Dropbox.app ready"
else
  fail "Dropbox.app still missing after install attempt"
  stop_now "Install Dropbox manually, then continue."
fi

section "Next steps"

echo "1. Open Dropbox:"
echo "   open -a Dropbox"
echo
echo "2. Sign into Dropbox."
echo
echo "3. Wait for this folder to sync:"
echo "   ~/Dropbox/d-scripts"
echo
echo "4. Then run:"
echo "   ~/Dropbox/d-scripts/bin/d-bootstrap-v1"
echo
echo "${YELLOW}${BOLD}REVIEW${RESET} This public seed intentionally does not contain private manifests, Brewfiles, dotfiles, app lists, LaunchAgents, or ignore rules."

echo
echo "${GREEN}${BOLD}DONE${RESET}   Public bootstrap seed finished."
