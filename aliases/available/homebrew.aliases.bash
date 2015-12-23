# Some aliases for Homebrew

cite 'about-alias'
about-alias 'homebrew abbreviations'

# Update installed Ruby gems, Homebrew, and their installed packages
alias brew_update="brew -v update; brew -v upgrade --all; brew cleanup; brew cask cleanup; brew prune; brew doctor"
alias bup='brew update && brew upgrade --all'
alias bupc='brew update && brew upgrade --all && brew cleanup'
alias bout='brew outdated'
alias bin='brew install'
alias brm='brew uninstall'
alias bcl='brew cleanup'
alias bls='brew list'
alias bsr='brew search'
alias binf='brew info'
alias bdr='brew doctor'
alias bed='brew edit'
