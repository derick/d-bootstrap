# d-scripts public bootstrap

This directory contains the minimal public-safe bootstrap seed for Derick's Mac setup.

## Current seed

bootstrap-seed-v1.zsh

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

## Intended future flow

Run the public seed from the eventual public repo URL.

Then run:

~/Dropbox/d-scripts/bin/d-bootstrap-v1

## Current status

This is local-only prep.

Do not publish until the seed script has been reviewed separately.

## Future public repo checklist

Potential public repo purpose:

- provide one minimal bootstrap seed for a new Derick Mac
- install or verify Homebrew
- install or verify Dropbox
- direct the user back to the private Dropbox-side bootstrap flow

Recommended public repo contents:

- README.md
- bootstrap-seed-v1.zsh

Do not include:

- Brewfile
- config files
- dotfiles
- LaunchAgents
- app inventory
- machine inventory
- ignore files
- logs
- state files
- screenshots
- secrets
- tokens
- private setup notes

Pre-publish review:

- run `d-review-public-bootstrap-v1`
- inspect every file planned for the public repo
- confirm the public repo contains only the seed and public README
- confirm the seed does not reference private repo URLs
- confirm the seed does not contain secrets, tokens, keys, or personal machine config
