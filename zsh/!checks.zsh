if [[ $(uname) = 'Linux' ]]; then
    IS_LINUX=1
fi

if [[ $(uname) = 'Darwin' ]]; then
    IS_MAC=1
fi

if (( $+commands[brew] )) ; then
    HAS_BREW=1
fi

if (( $+commands[apt-get] )) ; then
    HAS_APT=1
fi

if (( $+commands[yum] )) ; then
    HAS_YUM=1
fi
