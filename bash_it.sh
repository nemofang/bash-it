#!/usr/bin/env bash
# Initialize Bash It

# Reload Library
case $OSTYPE in
  darwin*)
    alias reload='source ~/.bash_profile'
    ;;
  *)
    alias reload='source ~/.bashrc'
    ;;
esac

# Only set $BASH_IT if it's not already set
if [ -z "$BASH_IT" ];
then
    # Setting $BASH to maintain backwards compatibility
    # TODO: warn users that they should upgrade their .bash_profile
    export BASH_IT=$BASH
    export BASH=`bash -c 'echo $BASH'`
fi

# Load composure first, so we support function metadata
source "${BASH_IT}/lib/composure.bash"

# support 'plumbing' metadata
cite _about _param _example _group _author _version

# library
LIB="${BASH_IT}/lib/*.bash"
for config_file in $LIB
do
  source $config_file
done

# Load enabled aliases, completion, plugins
for file_type in "aliases" "completion" "plugins"
do
  _load_bash_it_files $file_type
done
