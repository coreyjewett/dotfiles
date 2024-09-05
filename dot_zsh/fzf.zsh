if [ -z "${BREW_OPT:-}" -o ! -e ${BREW_OPT} ]; then
  # Darwin brew path
  BREW_OPT=/usr/local/opt;
fi

# Setup fzf
# ---------
if [[ ! "$PATH" == *$BREW_OPT/fzf/bin* ]]; then
  export PATH="$PATH:$BREW_OPT/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$BREW_OPT/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$BREW_OPT/fzf/shell/key-bindings.zsh"

# fasd & fzf change directory - jump using `fasd` if given argument, filter output of `fasd` using `fzf` else
unalias z #removing fasd's alias for z first

z() {
  [ $# -gt 0 ] && fasd_cd -d "$*" && return
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
