cite 'about-alias'
about-alias 'osx-specific aliases'

# Desktop Programs
alias safari="open -a safari"
alias firefox="open -a firefox"
alias chrome="open -a google\ chrome"
alias f='open -a Finder .'
alias notes='open -a notes'
alias skype='open -a Skype'
alias mou='open -a Mou'
alias sublime="open -a 'Sublime Text' ."
alias zoom='open -a zoom.us'
alias music='open -a neteasemusic'

if [ -s /usr/bin/firefox ] ; then
  unalias firefox
fi

# Get rid of those pesky .DS_Store files recursively
alias dsclean='find . -type f -name .DS_Store -delete'

# Flush your dns cache
alias flush='dscacheutil -flushcache'

# Show/hide hidden files (for Mac OS X Mavericks)
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles FALSE"

# Networking. IP address, dig, DNS
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# From http://apple.stackexchange.com/questions/110343/copy-last-command-in-terminal
alias copyLastCmd='fc -ln -1 | awk '\''{$1=$1}1'\'' ORS='\'''\'' | pbcopy'

# Use Finder's Quick Look on a file (^C or space to close)
alias ql='qlmanage -p 2>/dev/null'

# Mute/Unmute the system volume. Plays nice with all other volume settings.
alias mute="osascript -e 'set volume output muted true'"
alias unmute="osascript -e 'set volume output muted false'"

# Pin to the tail of long commands for an audible alert after long processes
## curl http://downloads.com/hugefile.zip; lmk
alias lmk="say 'Process complete.'"
