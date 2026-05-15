# d-bootstrap

Minimal public bootstrap for Derick's Macs.

This repo only gets a fresh Mac far enough to install or verify:

- Homebrew
- Dropbox
- ChatGPT Desktop

After Dropbox is signed in and key folders are made available offline, the real setup continues from:

    /Users/derick/Dropbox/d-scripts

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
5. Open Dropbox.
6. Check whether ChatGPT Desktop is installed.
7. Install ChatGPT Desktop if needed.
8. Open ChatGPT.
9. Tell you to sign into Dropbox.
10. Tell you to make key Dropbox folders available offline.
11. Tell you to sign into ChatGPT on the new Mac.
12. Hand off to the private Dropbox-backed setup flow.

## After Dropbox installs

1. Sign into Dropbox.
2. Wait for Dropbox to show your d-scripts and d-bootstrap folders.
3. In Finder, right-click these folders and choose **Make Available Offline**:

        /Users/derick/Dropbox/d-scripts
        /Users/derick/Dropbox/d-bootstrap

4. Sign into ChatGPT on this Mac.
5. Continue from ChatGPT on this Mac, not from another device.
6. Then run:

        cd /Users/derick/Dropbox/d-scripts || exit 1
        /bin/chmod +x bin/d-*
        bin/d-fresh-mac-finish

Do not run private `d-scripts` commands until the Dropbox folders are available offline.

Dropbox online-only placeholders can appear as zero-byte files, which can make scripts fail even though the filenames appear to exist.

If `d-scripts` files look empty or scripts print nothing, check Finder and choose **Make Available Offline** for the folders above.

## Design notes

- Keep this public repo intentionally tiny.
- Do not put private setup logic here.
- The real setup lives in `/Users/derick/Dropbox/d-scripts`.
- The public repo exists only so a fresh Mac has a simple, reachable starting point.
- Dropbox is useful for sync, but executable scripts must be available offline before running private setup commands.