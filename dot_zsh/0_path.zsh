# path, the 0 in the filename causes this to load first

# Try to load linuxbrew if it exists
if [ -d /home/linuxbrew/.linuxbrew ]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/linuxbrew/.linuxbrew/lib/
fi

# If you have duplicate entries on your PATH, run this command to fix it:
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')

pathAppend() {
  # Only adds to the path if it's not already there
  if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
    PATH=$PATH:$1
  fi
}

pathAppend "$HOME/.bin"
pathAppend "$HOME/.emacs.d/bin"
