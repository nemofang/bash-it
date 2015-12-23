cite about-plugin
about-plugin 'miscellaneous tools'

function ips ()
{
    about 'display all ip addresses for this host'
    group 'base'
    if command -v ifconfig &>/dev/null
    then
        ifconfig | awk '/inet /{ print $2 }'
    elif command -v ip &>/dev/null
    then
        ip addr | grep -oP 'inet \K[\d.]+'
    else
        echo "You don't have ifconfig or ip command installed!"
    fi
}

function down4me ()
{
    about 'checks whether a website is down for you, or everybody'
    param '1: website url'
    example '$ down4me http://www.google.com'
    group 'base'
    curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

function myip ()
{
    about 'displays your ip address, as seen by the Internet'
    group 'base'
    res=$(curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+')
    echo -e "Your public IP is: ${echo_bold_green} $res ${echo_normal}"
}

function pickfrom ()
{
    about 'picks random line from file'
    param '1: filename'
    example '$ pickfrom /usr/share/dict/words'
    group 'base'
    local file=$1
    [ -z "$file" ] && reference $FUNCNAME && return
    length=$(cat $file | wc -l)
    n=$(expr $RANDOM \* $length \/ 32768 + 1)
    head -n $n $file | tail -1
}

function passgen ()
{
    about 'generates random password from dictionary words'
    param 'optional integer length'
    param 'if unset, defaults to 4'
    example '$ passgen'
    example '$ passgen 6'
    group 'base'
    local i pass length=${1:-4}
    pass=$(echo $(for i in $(eval echo "{1..$length}"); do pickfrom /usr/share/dict/words; done))
    echo "With spaces (easier to memorize): $pass"
    echo "Without (use this as the password): $(echo $pass | tr -d ' ')"
}

function pmdown ()
{
    about 'preview markdown file in a browser'
    param '1: markdown file'
    example '$ pmdown README.md'
    group 'base'
    if command -v markdown &>/dev/null
    then
      markdown $1 | browser
    else
      echo "You don't have a markdown command installed!"
    fi
}

function md ()
{
    about 'make a directory and cd into it'
    param 'path to create'
    example '$ mkcd foo'
    example '$ mkcd /tmp/img/photos/large'
    group 'base'
    mkdir -p -- "$*"
    cd -- "$*"
}

# find shorthand
function f () {
  find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

# List all files, long format, colorized, permissions in octal
function la () {
  ls -l  "$@" | awk '
    {
      k=0;
      for (i=0;i<=8;i++)
        k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i));
      if (k)
        printf("%0o ",k);
      printf(" %9s  %3s %2s %5s  %6s  %s %s %s\n", $3, $6, $7, $8, $5, $9,$10, $11);
    }'
}

function lsgrep ()
{
    about 'search through directory contents with grep'
    group 'base'
    ls | grep "$*"
}

# cd into whatever is the forefront Finder window.
function cdf () {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# Start an HTTP server from a directory, optionally specifying the port
function server () {
  local port="${1:-8000}"
  open "http://localhost:${port}/"
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Copy w/ progress
function cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

# get gzipped size
function gz () {
  echo "orig size    (bytes): "
  cat "$1" | wc -c
  echo "gzipped size (bytes): "
  gzip -c "$1" | wc -c
}

# whois a domain or a URL
function whois() {
  local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
  if [ -z $domain ] ; then
    domain=$1
  fi
  echo "Getting whois record for: $domain …"

  # avoid recursion
  # this is the best whois server
  # strip extra fluff
  /usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'
}

function usage ()
{
    about 'disk usage per directory, in Mac OS X and Linux'
    param '1: directory name'
    group 'base'
    if [ $(uname) = "Darwin" ]; then
        if [ -n $1 ]; then
            du -hd $1
        else
            du -hd 1
        fi

    elif [ $(uname) = "Linux" ]; then
        if [ -n $1 ]; then
            du -h --max-depth=1 $1
        else
            du -h --max-depth=1
        fi
    fi
}

function command_exists ()
{
    about 'checks for existence of a command'
    param '1: command to check'
    example '$ command_exists ls && echo exists'
    group 'base'
    type "$1" &> /dev/null ;
}

mkiso ()
{
    about 'creates iso from current dir in the parent dir (unless defined)'
    param '1: ISO name'
    param '2: dest/path'
    param '3: src/path'
    example 'mkiso'
    example 'mkiso ISO-Name dest/path src/path'
    group 'base'

    if type "mkisofs" > /dev/null; then
        [ -z ${1+x} ] && local isoname=${PWD##*/} || local isoname=$1
        [ -z ${2+x} ] && local destpath=../ || local destpath=$2
        [ -z ${3+x} ] && local srcpath=${PWD} || local srcpath=$3

        if [ ! -f "${destpath}${isoname}.iso" ]; then
            echo "writing ${isoname}.iso to ${destpath} from ${srcpath}"
            mkisofs -V ${isoname} -iso-level 3 -r -o "${destpath}${isoname}.iso" "${srcpath}"
        else
            echo "${destpath}${isoname}.iso already exists"
        fi
    else
        echo "mkisofs cmd does not exist, please install cdrtools"
    fi
}

# useful for administrators and configs
function buf ()
{
    about 'back up file with timestamp'
    param 'filename'
    group 'base'
    local filename=$1
    local filetime=$(date +%Y%m%d_%H%M%S)
    cp -a "${filename}" "${filename}_${filetime}"
}

function del() {
    about 'move files to hidden folder in tmp, that gets cleared on each reboot'
    param 'file or folder to be deleted'
    example 'del ./file.txt'
    group 'base'
    mkdir -p /tmp/.trash && mv "$@" /tmp/.trash;
}
