test -s ~/.alias && . ~/.alias || true

shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

alias fdupes='fdupes . -dNqnr'
alias date='LC_TIME=C date "+%a, %d/%m/%y, %I:%M %p"'
alias du='du -ah -d 1'
alias df='df -h'
alias bc='bc -ql'
alias ls='ls -ahF1 --color=auto --group-directories-first'
alias sudo='sudo '

mpv(){ /usr/bin/mpv "$@" & disown; }
imv(){ /usr/bin/imv-wayland "$@" & disown; }

export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/go/bin:$PATH
