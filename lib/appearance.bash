#!/usr/bin/env bash

# colored grep
alias grep='grep --color=auto'
export GREP_COLOR='1;33'

# colored ls
# export LSCOLORS='Gxfxcxdxdxegedabagacad'

# here's LS_COLORS
# github.com/trapd00r/LS_COLORS
command -v gdircolors >/dev/null 2>&1 || alias gdircolors="dircolors"
eval "$(gdircolors -b ~/.dircolors)"
