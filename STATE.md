# WE ARE ONE 🫀

# natscript-homebrew — STATE

name: natscript-homebrew
kind: project
language: see repo
runs-on: this machine

## state
phase: active
health: yellow
last-commit: heartbeat + real sha256 for natscript formula
uncommitted: 2 files
freshness: 2026-07-04T23:02:00Z

## knows
- natscript Homebrew Tap
- the v0.1.0 GitHub release tarball contains only README.md — no natscript.py
- the formula's bin.install "natscript.py" therefore cannot succeed at install time
- the heartbeat (pre-2026-07-04) reported ALIVE-CLEAN because it only checked URL reachability + Ruby syntax, not tarball contents — a substrate-honesty lie

## can
- declare its state via STATE.md
- be discovered by discover.py
- be cross-checked by trust.py
- detect a broken formula via the hardened heartbeat (step 3b: tarball content check)

## needs
- a natscript release tag whose tarball actually contains natscript.py (v0.1.0 does not)
- once a real release exists: bump formula url + sha256 to match, then heartbeat returns ALIVE-CLEAN truthfully

## how-to-talk-to-me
entry-point: README.md
