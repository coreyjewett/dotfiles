# The intent here is to:
# 1) get SSH Agent forwarding to be stable with tmux.
# 2) use a custom agent (1pass) rather than keep keys on the file system.

# 1pass on a Mac
_1pass="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password";
_1pass_sock="${_1pass}/t/agent.sock";

# 1pass installed?
if [ -e "${_1pass}" ]; then
  # is 1pass ssh agent enabled?
  if [ -e "${_1pass_sock}" ]; then
    SSH_AUTH_SOCK="${_1pass_sock}";
  else
    echo "WARN: 1Password found, but SSH Agent isn't enabled." >&2;
  fi
fi

# make a cursory check for this customization in the ssh config
if ! grep -q .auth_sock ${HOME}/.ssh/config; then
  echo "WARN: Didn't find .auth_sock reference in ${HOME}/.ssh/config" >&2;
fi


# https://gist.github.com/martijnvermaat/8070533?permalink_comment_id=4621458#gistcomment-4621458

# if $SSH_AUTH_SOCK is a socket, replace .ssh/.auth_sock with a new symlink pointing to it
[ -S "$SSH_AUTH_SOCK" ] && ln -snf "$SSH_AUTH_SOCK" ${HOME}/.ssh/.auth_sock

# if running in screen or tmux, set $SSH_AUTH_SOCK to the shared .auth_sock location, regardless if there is an existing auth sock.
case "$TERM" in
    screen*|tmux*)
        export SSH_AUTH_SOCK=${HOME}/.ssh/.auth_sock
        ;;
esac

unset _1pass _1pass_sock
