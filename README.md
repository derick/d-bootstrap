# d-bootstrap

Minimal public bootstrap seed for a Derick Mac.

This repo is intentionally tiny. It only:

- installs/verifies Homebrew
- installs/verifies Dropbox
- tells the user to sign into Dropbox
- hands off to private `~/Dropbox/d-scripts`

All private config, Brewfiles, dotfiles, and setup logic live in Dropbox.

## Fresh Mac flow

```zsh
# 1. Run the public seed on a bare Mac
/bin/bash -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/derick/d-bootstrap/main/bootstrap-seed-v1.zsh)"

# 2. Open Dropbox, sign in, wait for ~/Dropbox/d-scripts to sync

# 3. Run the private bootstrap
~/Dropbox/d-scripts/bin/d-bootstrap-v1

# 4. Install the Brewfile baseline
d-brew-apply-v1

# 5. Verify the machine is ready
d-fresh-mac-verify-v1
```

For the full human checklist: `d-fresh-mac-checklist-v1`

## Contents

- `README.md` — this file
- `bootstrap-seed-v1.zsh` — the public seed script

## Security model

The public seed should stay tiny.

It may:

- check that the Mac is Apple Silicon
- install Homebrew if missing
- install Dropbox if missing
- instruct the user to sign into Dropbox
- instruct the user to wait for ~/Dropbox/d-scripts to sync
- instruct the user to run the private Dropbox-side bootstrap command

It should not contain:

- personal Brewfiles
- dotfiles
- manifests
- app lists
- LaunchAgents
- ignore files
- machine-specific config
- private setup logic
- secrets or tokens

## Private Dropbox-side bootstrap flow

After Dropbox has synced `~/Dropbox/d-scripts`, run:

```
~/Dropbox/d-scripts/bin/d-bootstrap-v1
```

The private bootstrap verifies the synced d-scripts structure, runs onboarding and safe structural repair, checks core tools, and runs status checks. It does not install the full Brewfile baseline — that is a separate explicit step (`d-brew-apply-v1`).
