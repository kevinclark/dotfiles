# 2026-10-09 — Background items audit

Kevin asked for an audit of everything allowed to run in the background on this Mac, with every item pre-marked
keep/cut. Full table and change log: [../background-items-2026-10-09.md](../background-items-2026-10-09.md).

## Outcome

- **27 items, 1 orphan, 2 cuts.** Parallels Toolbox and Vivi were removed from Open at Login; both apps are still
  installed. The login-item list now has only Tailscale and Dropbox.
- **ExpressVPN's root daemon stays**: it's used occasionally for foreign-country VPN and costs 232 MB of 128 GB.
- **WireGuard** (Kevin deleted the app): 8 data folders plus `com.wireguard.macos.plist` were moved to
  `~/Backups/2026-10-09-wireguard/`. Two of its background-item records remain; there's no per-item delete.
- **Live fault found mid-audit:** Dropbox had quit cleanly at 12:54 during the Tailscale install. Kevin reopened it.

## Learned

Technique, promoted as global skill `macos-background-items-audit` (claude-skills 0.60.17):

- `sfltool dumpbtm` runs without admin on macOS 26.6.
- launchd keeps a job whose plist was deleted until logout.
- The Bash tool can't move `~/Library/Containers/*`; Finder drag can.

## Left open

- Whether macOS prunes WireGuard's 2 stale records. They're harmless, so this wasn't scheduled. Check with
  `sfltool dumpbtm | grep -i wireguard`.
- Kevin's own uncommitted edits in the main checkout (`Brewfile`, `dotfiles/gitconfig`, `dotfiles/zshrc`) were not touched.
