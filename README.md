Borrowing the choicest bits of:
* [lfilho's fork of YADR](https://github.com/lfilho/dotfiles.git)

And managing them with [chezmoi](https://www.chezmoi.io/).

== Usage:

  + Install Chezmoi:
    `sh -c "export BINDIR=~/.bin/; $(curl -fsLS git.io/chezmoi)" -- init --apply coreyjewett >> /tmp/chezmoi.log`
  + Bootstrap:
    `~/.local/share/chezmoi/bootstrap`

This often goes sideways if run unattended. There are some user-interactive bits that are chaos monkies. Doom, I'm looking at you. :(
Bootstrap should be re-entrant, so just run it again.

== Upgrading:

Just: `chezmoi upgrade`

== Investigate/Configure:

* [yabai/skhd](https://github.com/koekeishiya)
* [vimac](https://github.com/dexterleng/vimac/blob/master/docs/manual.md)

* "Expired Apps"
  + xScope:
    - alternative: QuickLens
