#!/bin/sh

# default rule file extension
INMATE="/usr/local/inmate"
RULE="rule"
USER_INMATE="$HOME/.inmate"

INMATE_DEFAULT_CONTROLLER="$INMATE/directory.rule"
INMATE_DEFAULT_RULE="$INMATE/default.rule"

# By default, no output coloring.
green=""
bold=""
plain=""

if [ -n "$TERM" -a "$TERM" != "dumb" ] && tty <&2 >/dev/null 2>&1; then
	green="$(printf '\033[32m')"
	red="$(printf '\033[31m')"
	cyan="$(printf '\033[36m')"
	bold="$(printf '\033[1m')"
	plain="$(printf '\033[m')"
fi

_dirsplit()
{
	file=$1
	base=${1##*/}
	dir=${1%/$base}
}

_abspath() 
{
    if [[ -d "$1" ]]
    then
        pushd "$1" >/dev/null
        pwd
        popd >/dev/null
    elif [[ -e $1 ]]
    then
        pushd "$(dirname "$1")" >/dev/null
        echo "$(pwd)/$(basename "$1")"
        popd >/dev/null
    else
        # echo $red"$1" does not exist!$plain >&2
        return 127
    fi
}
