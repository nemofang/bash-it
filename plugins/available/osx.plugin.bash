cite about-plugin
about-plugin 'osx-specific functions'

# OS X: Open new tabs in same directory
if [ $(uname) = "Darwin" ]; then
  if type update_terminal_cwd > /dev/null 2>&1 ; then
    if ! [[ $PROMPT_COMMAND =~ (^|;)update_terminal_cwd($|;) ]] ; then
      export PROMPT_COMMAND="update_terminal_cwd;$PROMPT_COMMAND"
    fi
  fi
fi

# cd into whatever is the forefront Finder window.
function cdf () {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# this one switches your os x dock between 2d and 3d
# thanks to savier.zwetschge.org
function dock-switch() {
    about 'switch dock between 2d and 3d'
    param '1: "2d" or "3d"'
    example '$ dock-switch 2d'
    group 'osx'

    if [ $(uname) = "Darwin" ]; then

        if [ $1 = 3d ] ; then
            defaults write com.apple.dock no-glass -boolean NO
            killall Dock

        elif [ $1 = 2d ] ; then
            defaults write com.apple.dock no-glass -boolean YES
            killall Dock

        else
            echo "usage:"
            echo "dock-switch 2d"
            echo "dock-switch 3d."
        fi
    else
        echo "Sorry, this only works on Mac OS X"
    fi
}

# `shellswitch [bash | zsh]`
#  Must be in /etc/shells
function shellswitch () {
  chsh -s $(brew --prefix)/bin/$1
}
