# ruby.sh
# git.sh
# golang.sh
# update.sh

# overload.sh

alias debug_nvim="NVIM_APPNAME=rawnvim nvim"
alias debug_nvimrc='NVIM_APPNAME=rawnvim nvim $HOME/code/dotfiles/home/vim/min_init.lua'

alias ezshenv='v $DOTFILES/home/zprofile'
alias ekar='v $DOTFILES/home/karabiner.js'
alias ealias='v $DOTFILES/home/zsh/commands.sh'
alias efunction='v $DOTFILES/home/zsh/commands.sh'
alias eprivate='v $DOTFILES/home/zsh/private/private.zsh'
alias evimrc='v $DOTFILES/home/vim/init.lua'
alias egit='v $DOTFILES/home/gitconfig'
alias zshrc='v $DOTFILES/home/zshrc'
alias evimari="v ~/Library/Containers/net.televator.Vimari.SafariExtension/Data/Library/Application\ Support/userSettings.json"

alias eghost='v $HOME/.config/ghostty/config'
alias ealacritty='v $DOTFILES/home/alacritty.toml'

alias eopen='v $HOME/.config/opencode/opencode.jsonc'

alias oc="opencode"

alias folder-sizes="du -sh * | sort -hr | head"
alias file_size="du -sh"

# File Download (from Prezto)
if _exists curl; then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif _exists wget; then
  alias get='wget --continue --progress=bar --timestamping'
fi

alias oo='open .'
alias plistbuddy="/usr/libexec/PlistBuddy"

alias ezshrc="zshrc"
alias ezpro="ezshenv"
alias eenv="ezshenv"
alias zshenv="ezshenv"
alias please='sudo $SHELL -c "$(fc -ln -1)"'
alias ref="exec zsh"
alias path='sed "s/:/\n/g" <<< \"$PATH\"'

alias clip='yt-dlp -f "bestaudio[ext=m4a]"'

vob() {
  local file
  file=$(fd -L -e md . ~/Vaults | fzf --scheme=path --preview 'bat --color=always --style=plain {}') && $VISUAL "$file"
}

# typos
alias v='$VISUAL'
alias :e='v'
alias :q="exit"
alias cfd="cdf"
alias clea='clear'
alias cleaer='clear'
alias cleare='clear'
alias clera='clear'
alias gca="gac"
alias got="git"
alias ivm='v'
alias lls='ls'
alias lss='ls'
alias vim='v'
alias vimf='v'
alias x+="+x"

# zsh global aliases for piping
# alias -g .....='../../../..'
# alias -g ....='../../..'
# alias -g ...='../..'
alias -g CA="2>&1 | cat -A"
alias -g G='| grep'
alias -g L="| less"
alias -g LL="2>&1 | less"
alias -g NUL="> /dev/null 2>&1"
alias -g NE="2> /dev/null"
alias -g S='| sort'
alias -g T='| tail'
alias -g F='| fzf'
alias -g H="--help"
alias -g V="--version"
alias -g btail="| bat --paging=never -l log"

alias zdl='cd "$HOME/Downloads/"'
alias zd="z dotfiles"
alias relink="cd ~/code/dotfiles && ./install --only link"
alias zh="cd ~"

alias bundle-id="mdls -name kMDItemCFBundleIdentifier -r" # macOS bundle ID, not Ruby

function fix_key_permissions() { # after reinstalling macOS
  chmod 600 ~/.ssh/id_ed25519
  chmod 600 ~/.ssh/id_ed25519.pub
}

function unquarantine() { xattr -d com.apple.quarantine "$@"; }
function unquarantine_app() { unquarantine "/Applications/$*"; }

function h() { cd ~/"$1" || exit; }
function c() { cd ~/code/"$1" || exit; }
function cw() { cd ~/code/work/"$1" || exit; }

function search() {
  e_header "find . -iname \"*$1*\""
  sudo find . -iname "*$1*"
}

alias cask="brew install --cask"
alias bin="brew install"
alias brm='brew uninstall'
alias bs='brew search'
alias bi='brew info'
alias bh='brew home'
alias bup='brew update && brew upgrade'
alias bclean='brew cleanup'
alias bout='brew outdated'
alias bleaves='brew leaves'

alias -g C='| tr -d "\n" | pbcopy'

alias cpwd='pwd | tr -d "\n" | pbcopy'
alias copy-msg='git log --format=%B -n 1 | pbcopy'
alias copy-branch='git rev-parse --abbrev-ref HEAD | pbcopy'
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | e_success 'Public key copied to pasteboard.'"

mkp() { mkdir -p "$@"; }

mkwarn() { sed "s/.*'\(.*\)'.*/\1/" | xargs -I{} mkdir -p "{}"; }
