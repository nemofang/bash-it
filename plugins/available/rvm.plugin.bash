# Load RVM, if you are using it

cite about-plugin
about-plugin 'load rvm, if you are using it'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Check to make sure that RVM is actually loaded before adding
# the customizations to it.
if [ "$rvm_path" ]
then
    # Load the auto-completion script if RVM was loaded.
    [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

    switch_ruby () {
      rvm $1
    }

    switch_default_ruby () {
      rvm --default $1
    }

fi
