# Background items audit — 2026-10-09

Everything allowed to run in the background on this Mac, as of 2026-10-09 ~14:05 PDT.
Uptime 20 d 22 h (booted 2026-09-18 15:33 PDT), so "running" means "still alive since login or launched since".

## Sources read

| Source | Result |
|---|---|
| `sfltool dumpbtm` (authoritative BTM list; worked without admin) | 3 UID sections: -2 (system daemons), 0, 501 (kev) |
| `~/Library/LaunchAgents`, `/Library/LaunchAgents`, `/Library/LaunchDaemons` | 13 + 3 + 3 plists |
| `launchctl list` (gui/501), `launchctl print system` | loaded jobs and PIDs |
| System Events login items | Parallels Toolbox, Tailscale, Vivi, Dropbox |
| `systemextensionsctl list` | 2 (3Dconnexion driver, Tailscale network ext.) |
| `pluginkit -mA` (third-party app extensions) | folded below |
| `/Library/PrivilegedHelperTools`, `/Library/Audio/Plug-Ins/HAL`, `/Library/Extensions`, `/Library/StartupItems` | Zoom helper; Vivi + Parrot audio drivers; HighPoint kexts; empty |
| `mdls kMDItemLastUsedDate` per app; `ps` | last use and running state |

Last-used times are Spotlight's `kMDItemLastUsedDate`, converted to PDT. A launch at login counts as a "use"
(e.g. Parallels Toolbox 09-18 15:44 is 11 min after boot).

## Items (pre-marked)

Rec: **keep** / **cut** (what "cut" does is in the Action column; every action is reversible).

| # | Item (BTM section) | Owner / team ID | Installed (mtime, ver) | Plist mtime | Running? | Last used | What it does | Rec | Reason / evidence | Action if cut |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Parallels Toolbox (Open at Login) | Parallels 4C6364ACXT | yes, 2025-05-08, v7.1.0 | — | **no** | 09-18 15:44 (login) | Utility grab-bag (screenshots, downloads) | **cut** | unused: launched at login 3 wk ago, not running, never opened since; app 17 months old | Remove from Open at Login |
| 2 | Vivi (Open at Login) | VIVI AUSTRALIA 3NRCUJ8TJC | yes, 2026-09-02, v3.12.0 | — | **no** (its ViviAudio HAL driver is loaded in coreaudiod) | 10-04 18:55 | Classroom screen-mirroring client | **cut** | on-demand: launched at login, not running now, last opened 5 days ago, so it is quit after login | Remove from Open at Login (app + audio driver stay) |
| 3 | ExpressVPN daemon `com.express.vpn.daemon` (Allow in Background: Expressco Services) | TC292Y5427 | yes, 2026-07-03, v14.2.0 | 2026-07-03 | **yes**, root, KeepAlive, PID 5991 since 09-18 16:35 | 09-18 16:35 | Privileged helper for the ExpressVPN app | keep (was cut) | used occasionally for foreign-country VPN (Kevin, 10-09). Needed only while connecting, but costs 232 MB RSS of 128 GB and 21 CPU-min over 20.9 days; turning it off means re-enabling before every use | — |
| 4 | Dropbox (Open at Login) | G7HH3F8CAK | yes, 2026-10-07, v274.4.4841 | — | **no — quit 10-09 12:54** (see note) | 10-07 20:27 | File sync | keep | in use | — |
| 5 | Tailscale (Open at Login) | W5364U7YZB | yes, 2026-10-09, v1.104.1 | — | yes | 10-09 12:52 | Two-house tailnet | keep | required (installed today) | — |
| 6 | Tailscale Network Extension (system ext.) | W5364U7YZB | yes | — | yes, root | — | Tailscale's tunnel | keep | required | — |
| 7 | WireGuard login-item helper | L82V4Y2P3C | **app deleted by Kevin 10-09 ~14:05** | — | no; launchd job gone; no VPN configs in `scutil --nc list` | 10-09 14:01 | Started WireGuard at login | gone | 2 BTM records (`2.com.wireguard.macos`, `4.com.wireguard.macos.login-item-helper`) still point at the missing app | see Changes applied |
| 8 | 1Password Browser Helper (login item) | 2BUA8C4S2C | yes, 2026-10-02, v8.12.40 | — | yes | 10-09 13:33 | Browser-extension bridge | keep | required for autofill | — |
| 9 | 1Password Launcher (login item) | 2BUA8C4S2C | yes | — | no (on demand) | — | Starts 1Password at login | keep | in use | — |
| 10 | `com.3dconnexion.helper` (LaunchAgents, /Library) | Unknown dev (no team ID in BTM) | yes, 2026-02-17, v1.4.3 | 2026-02-18 | yes (+3DxNLServer, RadialMenu, VirtualNumpad since login) | 09-18 (login) | SpaceMouse helper | keep | CAD device | — |
| 11 | `com.3dconnexion.nlserverIPalias` (LaunchDaemons) | Unknown dev | yes | 2025-10-13 | ran at boot; alias 127.51.68.120 on lo0 is up | — | Loopback alias for 3DxNLServer (browser CAD, e.g. Onshape) | keep | CAD device | — |
| 12 | 3Dconnexion driver dext (system ext.) | 9D93Y2RD6L | yes | — | yes | — | SpaceMouse driver | keep | CAD device | — |
| 13 | `com.dropbox.DropboxUpdater.wake` (LaunchAgents, ~) | G7HH3F8CAK | updater 2026-09-18 | 2026-06-09 | hourly, exits | — | Dropbox auto-update | keep | security updates | — |
| 14 | `com.google.GoogleUpdater.wake` (LaunchAgents, ~) | EQHXZ8M8AV | updater 2026-09-27, v156 | 2026-06-09 | hourly, exits | — | Chrome auto-update | keep | Chrome in daily use (395 uses) | — |
| 15 | `com.valvesoftware.steamclean` (LaunchAgents, ~) | MXGJJ98X76 | yes, binary 2026-08-03; Steam.app 2026-03-02 | 2026-09-27 | runs at login, exits | Steam 09-27 21:38 | Clears Steam download cache | keep | inert (one run per login); Steam used 12 days ago | — |
| 16 | `us.zoom.updater` (LaunchAgents, /Library) | BJ4HAAB9B3 | yes, 2026-09-24, v7.1.9 | 2026-09-24 | hourly, exits | no Spotlight record | Zoom auto-update | keep | security updates | — |
| 17 | `us.zoom.updater.login.check` (LaunchAgents, /Library) | BJ4HAAB9B3 | yes | 2026-09-24 | at login, exits | — | Zoom update check | keep | security updates | — |
| 18 | `us.zoom.ZoomDaemon` (LaunchDaemons) | BJ4HAAB9B3 | yes, helper 2026-09-24 | 2026-09-24 | no (Mach service, on demand) | — | Zoom privileged helper | keep | inert until Zoom asks | — |
| 19 | Parallels Desktop `com.parallels.desktop.launchdaemon` (system domain; not in BTM) | 4C6364ACXT | yes, 2026-09-19, v27.0.2 | (inside the app bundle) | yes, since 09-28 15:25 (prl_disp_service, prl_naptd) | 09-22 10:36 | VM service | keep | HAOS VM (suspended), Windows 11 (suspended), Ubuntu (stopped) | — |
| 20 | `com.asmvik.yabai` (LaunchAgents, ~) | Homebrew, unsigned | yes, 2026-06-09 | 2026-05-04 | yes, PID 87830 | — | Tiling WM | keep | current WM | — |
| 21 | `com.koekeishiya.skhd` (LaunchAgents, ~) | Homebrew, unsigned | yes, 2026-05-04 | 2026-05-04 | yes, PID 971 | — | Hotkeys for yabai | keep | current WM | — |
| 22 | `org.kevinclark.focus-web` | Kevin | ~/code/focus | 2026-10-09 | yes | — | Focus page on :8770 | keep | documented live in focus/CLAUDE.md | — |
| 23 | `org.kevinclark.focus-watchdog` | Kevin | ~/code/focus | 2026-10-08 | every 30 min | — | Morning-check watchdog | keep | documented live | — |
| 24 | `org.kevinclark.focus-backup` | Kevin | ~/code/focus | 2026-10-09 | 03:15 daily | — | Off-machine B2 backup | keep | documented live | — |
| 25 | `org.kevinclark.focus-corpus-gmail` | Kevin | ~/code/focus | 2026-10-09 | yes, KeepAlive | — | Gmail corpus daemon | keep | documented live | — |
| 26 | **Orphan:** `com.express.vpn.client` (gui/501, held in launchd memory only) | Expressco | plist **gone** (`~/Library/LaunchAgents/com.express.vpn.client.plist` missing) | — | not running; ran once at login (`open /Applications/ExpressVPN.app`) | — | Old ExpressVPN autostart | none | clears itself at next logout; nothing on disk to remove | — |
| 27 | Updater tombstones ×4: `com.google.keystone.{agent,xpcservice}`, `com.dropbox.dropboxmacupdate.{agent,xpcservice}` (LaunchAgents, ~) | Google / Dropbox | — | 2026-06-09 | not loaded (empty `<dict/>`, 181 B) | — | Empty plists the new updaters leave in place of the legacy Keystone-style agents | keep | inert; removing them could let the legacy agent reinstall (inferred, not tested) | — |

**Dropbox note (not a background-item issue):** Dropbox.app is set to Open at Login but no Dropbox process is running.
`~/.dropbox/QuitReports` was touched 10-09 12:54 and is empty (a clean quit, not a crash). The last database write was
12:18. 12:54 is the minute 1Password relaunched, during today's Tailscale install. Reopening Dropbox.app fixes it.

## Folded (Apple-shipped or inert extensions — keep)

- Apple: GarageBand Quick Look/thumbnail extensions and Spotlight importers (GarageBand, Logic); `org.cups.cupsd`, `com.vix.cron`;
  HighPointIOP/HighPointRR kexts in /Library/Extensions and ParrotAudioPlugin.driver (shipped with macOS, dated to the 08-12 OS install).
- App extensions that run only when invoked: Orion dock tile + share extension; Parallels ExeQL Quick Look, OpenInIE, ParallelsMail;
  Parallels Toolbox Safari extensions ×2; 1Password Safari extension; Dropbox File Provider + garcon (Finder); Tailscale share and widgets;
  WireGuard network extension (app-scoped); Flow widget.
- BTM "developer" rows (Unknown Developer, Expressco, Zoom, Steam): grouping headers in the Settings pane, not items.

## Running but not in Login Items (for context only)

- Caffeine.app (PID 85551, since 09-21): opened by hand; not set to launch at login.
- Steam `ipcserver` (`com.valvesoftware.steam.ipctool`, since 09-27 21:38): left behind after Steam closed; goes away at logout.

## What this can't tell

- Whether the SpaceMouse is still used: no USB device is attached now (laptop undocked), so its 4 idle processes are kept on the CAD-use assumption.
- Zoom has no Spotlight last-used record, so how often it's used is unknown. The updaters are kept either way.
- Why Dropbox quit at 12:54: no log was found for it.

## Changes applied

Kevin's go, 10-09: cut items 1 and 2; keep item 3 (ExpressVPN); WireGuard removed (he deleted the app).

1. Parallels Toolbox and Vivi removed from Open at Login (`osascript … delete login item`). Read-back: login items are now
   `Tailscale, Dropbox`. In `sfltool dumpbtm`, item identifiers went from 49 to 47; the only two missing are
   `2.com.parallels.toolbox` and `2.au.com.viviaustralia.mac`, and nothing else changed. Both apps stay installed. To undo,
   add them back in System Settings → Login Items.
2. Dropbox: Kevin reopened it; PID 87899 confirmed running at ~14:10.
3. WireGuard: the app is gone and nothing is loaded or running. What's left:
   - Two BTM records pointing at the deleted app. There's no per-item BTM delete, and `sfltool resetbtm` would wipe every
     approval (Tailscale included), so these were left for macOS to prune. That macOS prunes them is inferred, not seen.
   - Data folders, not touched (deleting needs a named go): `~/Library/Containers/com.wireguard.macos{,.login-item-helper,.network-extension}`,
     `~/Library/Group Containers/L82V4Y2P3C.group.com.wireguard.macos`, and 4 matching `~/Library/Application Scripts/` folders.
     They may hold the old tunnel configs and keys.
4. WireGuard data folders (Kevin's go, 10-09 ~14:31), moved to `~/Backups/2026-10-09-wireguard/`, nothing deleted:
   - Moved: `Group Containers/L82V4Y2P3C.group.com.wireguard.macos` (1.0 MB, mostly `tunnel-log.bin`), plus the 4
     `Application Scripts/*wireguard*` folders (empty).
   - Refused with `Operation not permitted` (macOS protects sandboxed app containers from a non-Finder process):
     `Containers/com.wireguard.macos{,.login-item-helper,.network-extension}`. Kevin dragged these in Finder into
     `~/Backups/2026-10-09-wireguard/Containers/` (between 14:31 and 14:34), and also moved a `com.wireguard.macos.plist` there
     (mtime 14:01, the minute of WireGuard's last use).
   - Read-back: no `*wireguard*` left under `~/Library/{Containers,Group Containers,Application Scripts,Preferences,LaunchAgents}`;
     backup is 1.1 MB. Only the 2 BTM records remain (see 3).
