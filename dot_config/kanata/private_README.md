# Kanata Keyboard Configuration

## Overview

This kanata configuration for Framework 13 laptop implements a comprehensive keyboard remapping system focused on:
- **Homerow mods** - All modifiers accessible from home row (no need to move hands)
- **Modal window management** - Vim/tmux-like modal system for Hyprland WM control
- **Multi-keyboard portability** - Design principles transferable to Atreus, CharaChorder, steno
- **Forced learning** - Physical modifier keys blocked with audible beep to enforce homerow mod habits

## Design Philosophy

### Why Homerow Mods?

The configuration deliberately blocks all physical modifier keys (Shift, Ctrl, Alt/Meta) and forces their use through homerow positions. This serves multiple purposes:

1. **Muscle memory consistency** - Same modifier positions work across laptop, Atreus, CharaChorder, and steno keyboards
2. **Reduced finger travel** - No reaching for modifier keys; everything accessible from home position
3. **Preparation for split keyboards** - Atreus (40-key split) has limited keys, requiring efficient use of layers
4. **Vim-style efficiency** - Aligns with existing vim workflow preferences (modal editing, minimal hand movement)

### Keyboard Progression Goals

This configuration is the first step in a multi-keyboard workflow:

1. **Framework laptop** (current) - Learn homerow mods with familiar layout
2. **Atreus** - Apply homerow mod muscle memory to 40-key columnar split
3. **CharaChorder** - Chorded input with similar modifier concepts
4. **Steno** - Ultimate speed with phonetic input

## Quick Reference

### Modifier Keys (Homerow Mods)

**Left hand** (only triggers with right-hand keys):
- `A` (tap) / `Super/Meta` (hold)
- `S` (tap) / `Alt` (hold)
- `D` (tap) / `Shift` (hold)
- `F` (tap) / `Ctrl` (hold)

**Right hand** (only triggers with left-hand keys):
- `J` (tap) / `Ctrl` (hold)
- `K` (tap) / `Shift` (hold)
- `L` (tap) / `Alt` (hold)
- `;` (tap) / `Super/Meta` (hold)

**Special tap-holds**:
- `Caps Lock`: tap = `Esc`, hold = `Ctrl`
- `Enter`: tap = `Enter`, hold = `Ctrl`
- `Space`: tap = `Space`, hold = activate **Numbers layer**

### Numbers Layer

Hold `Space` to activate:
- `Q W E R T` → `1 2 3 4 5`
- `Y U I O P [ ]` → `6 7 8 9 0 - =`
- Home row letters remain plain (no mods active in this layer)

### Left Shift Layer

The physical left Shift position is repurposed as a tap-hold:
- **Tap**: `(`
- **Hold**: Activates left-shift layer
  - Left-hand keys: unshifted (1-5, qwert, asdfg, zxcvb) - blocks shift behavior
  - Right-hand keys: shifted (produces capital letters, symbols)
  - This creates asymmetric shift behavior for one-handed shifted typing

### Window Management (WM Mode)

**Trigger**: Press either `Alt` key (remapped to F19) to enter WM mode

This creates a vim/tmux-like modal system for window management:

**Navigation** (hjkl vim-style):
- `H` - Focus window left
- `J` - Focus window down
- `K` - Focus window up
- `L` - Focus window right

**Workspace switching**:
- `1-9, 0` - Switch to workspace 1-10

**Move window** (Shift + nav):
- `Shift+H/J/K/L` - Swap window in direction
- `Shift+1-9,0` - Move window to workspace 1-10

**Move window silently** (Alt + number):
- `Alt+1-9,0` - Move window to workspace without switching focus

**Exit WM mode**: Press `Esc` or any action auto-exits

### Blocked Keys

These keys are blocked (produce no output) to train away from using them:
- Physical `Left Shift`
- Physical `Right Shift`
- Physical `Left Ctrl`
- Physical `Right Ctrl`
- Physical `Left Meta/Super`
- Physical `Right Meta/Super`

Use homerow mods instead!

## Technical Details

### Bilateral Homerow Mods

The configuration uses `tap-hold-release-keys` with bilateral exclusion lists:
- **Left-hand mods** only trigger when pressing right-hand keys
- **Right-hand mods** only trigger when pressing left-hand keys

This prevents accidental modifier activation when typing common bigrams like "as", "ask", "sad", etc.

**Timing**: 200ms tap timeout, 200ms hold timeout

**Example**:
- Typing "ask" rapidly → produces "ask" (not Meta+k)
- Holding `A` while pressing right-hand `8` → `Super+8` (Meta+8)

### Layer System

**Three layers**:
1. **base** - Default typing with homerow mods active
2. **lshift** - Activated by holding left Shift position (asymmetric shifting)
3. **numbers** - Activated by holding Space (number row alternative)

### Integration with Hyprland

The configuration remaps both Alt keys to F19, which Hyprland uses as the trigger for its submap-based modal window management system. This creates:

- **Stateless prefix key behavior** - Similar to tmux Ctrl+A prefix
- **Auto-exit after action** - Each WM command returns to normal mode
- **Ambidextrous trigger** - Either Alt key works (important for split keyboards)

### Device Filtering

Only captures laptop built-in keyboards:
- "AT Translated Set 2 keyboard" (main keyboard)
- "FRMW0001:00 32AC:0006" (Framework embedded controller)

External USB keyboards pass through unchanged, allowing testing and fallback.

## Architecture Decisions

### Why F19 for WM Mode?

- F19 is rarely used, avoiding conflicts
- Hyprland submaps can't use arbitrary key combinations as triggers
- Using Alt keys (which aren't needed for homerow mods) provides ergonomic access
- Ambidextrous trigger works on split keyboards where each half may be far apart

### Why Block Physical Modifiers?

Original intent was to force homerow mod adoption by making physical modifiers unavailable. The beep provides immediate negative feedback when muscle memory tries to reach for old modifier positions.

### Why `tap-hold-release-keys` Instead of `tap-hold-except-keys`?

**Problem with `tap-hold-except-keys`**: When rolling bigrams like "ask", the exclusion list for `s` didn't include `a`, so Meta would trigger if `a` was held slightly too long.

**Solution with `tap-hold-release-keys`**: Only activates hold behavior if key is still held when released. This better handles fast typing and rolling motions common in touch typing.

### Why Asymmetric Shift Layer?

The left-shift layer concept allows one-handed shifted character input on the right hand while left hand maintains unshifted access. This was an experimental feature that may or may not be useful in practice.

## Common Issues & Solutions

### Issue: Accidentally triggering homerow mods when typing fast

**Solution**: The bilateral exclusion lists should prevent this. If it still occurs:
- Check if you're holding keys too long (200ms threshold)
- Consider increasing tap-hold timeouts
- Verify bilateral exclusion lists include the opposite-hand keys you're pressing

### Issue: Can't trigger multiple mods simultaneously (e.g., Super+Shift+8)

**Solution**: Use homerow mods from opposite hands:
- Left `A` (Super) + right `K` (Shift) + `8` → Super+Shift+8
- The bilateral design requires using both hands for multi-mod combos

### Issue: Want audible beep for blocked keys

**Current state**: Physical modifiers are silently blocked because the installed kanata binary doesn't support cmd execution.

**Solution**: To enable audible beep feedback:
1. Install `kanata_cmd_allowed` binary from GitHub releases, or
2. Compile kanata with `cmd` feature: `cargo build --release --features cmd`
3. Update the `blk` alias in kanata.kbd to: `blk (cmd-output-keys "paplay /usr/share/sounds/freedesktop/stereo/bell.oga")`
4. Set `danger-enable-cmd yes` in defcfg

### Issue: WM mode not triggering

**Symptoms**: Pressing Alt key doesn't enter WM mode in Hyprland

**Checks**:
1. Verify kanata is running: `systemctl --user status kanata`
2. Check Hyprland config has submap defined for F19 trigger
3. Test F19 reaches Hyprland: use `wev` or `xev` to see keypress events
4. Ensure no other application is capturing F19

## Files

- `kanata.kbd` - Main configuration file
- `~/.config/systemd/user/kanata.service` - Systemd service for auto-start
- `~/.config/hypr/bindings.conf` - Hyprland WM submap definitions
- `/usr/share/sounds/freedesktop/stereo/bell.oga` - Beep sound for blocked keys

## Future Adaptations

### For Atreus (QMK)

When creating QMK config for Atreus, key concepts to port:

1. **Homerow mods with bilateral triggering** - QMK has `BILATERAL_COMBINATIONS` feature
2. **F19 for WM trigger** - Map thumb key or layer toggle to F19
3. **Number layer** - Similar layer on thumb hold
4. **Same modifier positions** - Keep ASDF/JKL; as mod positions for muscle memory

### For CharaChorder

- Chord definitions should output same modifiers
- F19 chord for WM mode entry
- Consider if bilateral concepts apply to chorded input

### For Steno

- Steno theory will dictate most behavior
- F19 for WM mode may still be useful as a chord
- Modifier concepts may not directly translate

## Learning Curve

**Expected timeline** (based on homerow mod adoption):

- **Week 1**: Frustrating. Lots of beeps. Slow typing.
- **Week 2**: Fewer beeps. Start remembering homerow positions.
- **Week 3**: Muscle memory forming. Speed returning to normal.
- **Week 4**: Natural feel. Rarely think about modifiers.

**Tips**:
- Don't fight the beep - it's teaching you
- Practice modifier combos deliberately (not just in flow)
- Use WM mode frequently to build Alt→F19→hjkl muscle memory
- Consider typing practice focused on modifier+key combos

## References

- [Kanata documentation](https://github.com/jtroo/kanata)
- [Hyprland submaps](https://wiki.hyprland.org/Configuring/Binds/#submaps)
- [Bilateral combinations in QMK](https://docs.qmk.fm/#/feature_combo)
- Previous session context: Evolved from broken homerow mods → tried F19 prefix → discovered Hyprland submaps → modal WM control

## Changelog

### 2026-01-05
- Remapped both Alt keys to F19 for ambidextrous WM mode triggering
- Attempted to add beeping for blocked modifiers, but kanata binary lacks cmd support
- Physical modifiers remain blocked (using @blk alias that maps to XX)
- Documented full configuration with context for future QMK/CharaChorder/steno adaptations
- Updated README with instructions for enabling beep if cmd-enabled kanata is installed

### Earlier (Previous Session)
- Implemented bilateral homerow mods with `tap-hold-release-keys`
- Created Hyprland submap-based modal window management
- Blocked physical modifier keys to force homerow mod adoption
- Added numbers layer on Space hold
- Added asymmetric left-shift layer
