#!/usr/bin/env bash

# Bash History Handling

shopt -s histappend              # append to bash_history if Terminal.app quits
export HISTCONTROL=erasedups     # erase duplicates; alternative option: export HISTCONTROL=ignoredups
export HISTSIZE=5000             # resize history size
export AUTOFEATURE=true autotest

function rh {
  history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}


# # timestamps for later analysis. www.debian-administration.org/users/rossen/weblog/1
# export HISTTIMEFORMAT='%F %T '

# # keep history up to date, across sessions, in realtime
# #  http://unix.stackexchange.com/a/48113
# export HISTCONTROL=ignoredups:erasedups         # no duplicate entries
# export HISTSIZE=5000                          # big big history (default is 500)
# export HISTFILESIZE=$HISTSIZE                   # big big history
# which shopt > /dev/null && shopt -s histappend  # append to history, don't overwrite it

# # Save and reload the history after each command finishes
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# # ^ the only downside with this is [up] on the readline will go over all history not just this bash session.