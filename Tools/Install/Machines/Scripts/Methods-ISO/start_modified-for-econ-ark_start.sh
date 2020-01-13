#!/bin/bash
# This is the start of a script will be in the /var/local directory and should be executed by root at the first boot 

finishPath=https://raw.githubusercontent.com/ccarrollATjhuecon/Methods/master/Tools/Install/Machines/Scripts/Methods-ISO/finish.sh

# set defaults
default_hostname="$(hostname)"
default_domain=""

# define download function
# courtesy of http://fitnr.com/showing-file-download-progress-using-wget.html
download()
{
    local url=$1
#    echo -n "    "
    wget --progress=dot $url 2>&1 | grep --line-buffered "%" | \
        sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
#    echo -ne "\b\b\b\b"
#    echo " DONE"
}

tmp="/tmp"

datetime="$(date +%Y%m%d%H%S)"
sed -i "s/ubuntu/Xub-$datetime/g" /etc/hostname
sed -i "s/ubuntu/Xub-$datetime/g" /etc/hosts

bashrcadd=/home/$myuser/.bashrc_aliases
touch "$bashrcadd"
echo 'x0vncserver -display :0 >/dev/null 2>&1 &' >> "$bashrcadd"
echo 'parse_git_branch() {' >> "$bashrcadd"
echo "	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/" >> "$bashrcadd"
echo '}' >> "$bashrcadd"
echo 'export PS1="\u@\h:\W\[\033[32m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "' >>"$bashrcadd"

mkdir /home/$myuser/.emacs.d
chmod a+rw /home/$myuser/.emacs.d