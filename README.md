# d-bootstrap

Minimal public bootstrap for Derick's Macs.

This repo only gets a fresh Mac far enough to install or verify:

- Homebrew
- Dropbox

After Dropbox syncs, the real setup continues from:

    ~/Dropbox/d-scripts

## Fresh Mac install

Open Terminal and run this one command:

    /usr/bin/curl -fsSL https://raw.githubusercontent.com/derick/d-bootstrap/main/bootstrap-seed.zsh -o /tmp/d-bootstrap-seed.zsh && /bin/zsh /tmp/d-bootstrap-seed.zsh

Do not copy/paste the raw script contents into Terminal.

Run the one command above instead.

## What this does

The bootstrap seed should:

1. Check whether Homebrew is installed.
2. Install Homebrew if needed.
3. Check whether Dropbox is installed.
4. Install Dropbox if needed.
5. Tell you to sign into Dropbox.
6. Tell you to wait for ~/Dropbox/d-scripts to sync.
7. Hand off to the private Dropbox-backed setup flow.

## After Dropbox syncs

Run the fresh-Mac verification block first:

    cd /Users/derick/Dropbox/d-scripts || exit 1
    /bin/chmod +x bin/d-*
    bin/d-fresh-mac-checklist
    bin/d-fresh-mac-verify
    bin/d-verify

If those pass, apply synced macOS settings:

    bin/d-macos-settings-apply --apply

## Design notes

- Keep this public repo intentionally tiny.
- Do not put private setup logic here.
- The real setup lives in ~/Dropbox/d-scripts.
- The public repo exists only so a fresh Mac has a simple, reachable starting point.
