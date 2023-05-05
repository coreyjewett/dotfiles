#!/bin/bash

# https://github.com/nativefier/nativefier/blob/master/API.md#url-handling-options

TARGET=~/Applications/nativefier-apps

nativefier() {
	local uri="$1";
	local name="$2";
	shift 2;

	# TODO this doesn't work because there is an intermediate directory created.
	if [ -e "$TARGET/$name" ]; then
		echo "TODO upgrade";
	else
		npx nativefier "$uri" "$TARGET" --name "$name" "$@";
	fi
}

# Google Calendar
nativefier 'https://calendar.google.com/' "Google Calendar" \
	--internal-urls '.*?calendar.google.*?' \
	--single-instance
