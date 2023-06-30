#!/usr/local/bin/bash

alias debug_vim="/usr/local/bin/vim -u ~/.vimrc_min"
alias debug_vimrc="/usr/local/bin/vim -u ~/.vimrc_min ~/.vimrc_min"

alias debug_nvim="NVIM_APPNAME=rawnvim nvim"
alias debug_nvimrc="NVIM_APPNAME=rawnvim nvim $HOME/code/dotfiles/home/vim/min_init.lua"

alias youtube-dl="yt-dlp"
alias ezshenv='$VISUAL $HOME_DIR/zshenv'
alias ekar='$VISUAL $HOME_DIR/karabiner.json'
alias ealias='$VISUAL $HOME_DIR/zsh/commands.sh'
alias efunction='$VISUAL $HOME_DIR/zsh/commands.sh'
alias egems='$VISUAL $DOTFILES/new_machine/gems'
alias eprivate='$VISUAL $DOTFILES/home/zsh/private/private.zsh'
alias etmux='$VISUAL $DOTFILES/home/tmux.conf'
alias evim='$VISUAL $HOME_DIR/vim/init.lua'
alias egit='$VISUAL $HOME_DIR/gitconfig'
alias zshrc='$VISUAL $HOME_DIR/zshrc'
alias ekitty='$VISUAL $HOME_DIR/kitty/kitty.conf'
alias ealacritty='$VISUAL $DOTFILES/home/alacritty/alacritty.yml'
alias egoku='$VISUAL $HOME/.config/karabiner.edn'

# alias grbn="git rebase -i HEAD~$1"
alias folder-sizes="du -sh * | sort -hr | head"
alias branch="git branch --show-current"
alias bu="bundle update"
alias gac="git add -A && git commit -avm"
alias gm="git add -A && git commit -av"
alias gam='git commit --amend -C HEAD' # Commit current staged files and amend it to the previous commit message without changing the commit or being prompted
alias gc="git add -A && git commit -av"
alias gcaa="git add --all && git commit --amend --no-edit"
alias gcb="git create-branch -r"
alias gd="git difftool"
alias gdb="git branch --merged | egrep -v \"(^\*|master|main)\" | xargs git branch -d" # Delete all local branches that have been merged into HEAD
alias gfo="git remote update"
alias gfs="git remote update"
alias gin="gem install"
alias gli="gem list"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gnope="git checkout . "
alias gpm="git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='backend'" # Push the current branch and create a merge request for it
alias gpn="git push -o ci.skip"

alias rg="kitty +kitten hyperlinked_grep"

function gitpush() {
	if git push "$@"; then
	else
		terminal-notifier -title "Git Push Failed" -message "Get back to your terminal" -sound default
	fi
}

alias gp=gitpush

alias grb="git rebase"
alias grbi="git rebase -i"
alias gun="gem uninstall"
alias gundo="git reset --soft HEAD^ "
alias gco='git checkout'
alias gs="git status -sb"

alias file_size="du -sh"

# File Download (from Prezto)
if _exists curl; then
	alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif _exists wget; then
	alias get='wget --continue --progress=bar --timestamping'
fi

# more verbose fileutils
alias cp='cp -v'
alias chmod='chmod -v'
alias chown='chown -v'
alias rename='rename -v'

if _exists trash; then
	alias rm=trash
else
	e_missing trash
	alias rm="rm -i"
fi

alias oo='open .'
alias plistbuddy="/usr/libexec/PlistBuddy"
alias cask="brew install --cask"
alias bin="brew install"

if _exists btop; then
	alias cpu="btop"
	alias htop="btop"
	alias top="btop"
	alias rm=trash
else
	e_missing btop
fi

alias eivm="evim"
alias evimrc="evim"
alias ezshrc="zshrc"
alias eenv="ezshenv"
alias zshenv="ezshenv"
alias rdm="rails db:migrate"
alias rdc="rails db:create"
alias rdd="rails db:drop"
alias rr="rails routes"
alias ..="cd .."
alias branches='git branches'
alias co='branch'
alias console="rails console test -s"
alias killruby='killall -9 ruby'
alias please='sudo $SHELL -c "$(fc -ln -1)"'
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | e_success '=> Public key copied to pasteboard.'"
alias ref="exec zsh"
alias path="sed 's/:/\n/g' <<< \"$PATH\""

if _exists bat; then
	export BAT_CONFIG_PATH="$DOTFILES/home/batconfig"
	alias cat='bat'
fi

if _exists prettyping; then
	alias ping='prettyping --nolegend'
fi

if _exists lsd; then
	alias ls='lsd'
	alias ll='lsd -al'
	alias lsl='lsd *(@)' # only symlinks
	alias lsx='lsd *(*)' # only executables
fi

# typos
alias gca="gac"
alias vim='$VISUAL'
alias rials="rails"
alias :e='$VISUAL'
alias v='$VISUAL'
alias x+="+x"
alias :q="exit"

# zsh global aliases for piping
alias -g .....='../../../..'
alias -g ....='../../..'
alias -g ...='../..'
alias -g C='| tr -d "\n" | pbcopy'
alias -g CA="2>&1 | cat -A"
alias -g G='| grep'
alias -g H='| head'
alias -g L="| less"
alias -g LL="2>&1 | less"
alias -g NUL="> /dev/null 2>&1"
alias -g S='| sort'
alias -g T='| tail'
alias -g F='| fzf'
alias -g HL="--help"
alias -g V="--version"
alias -g btail="| bat --paging=never -l log"

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'
alias -g RES='RAILS_ENV=staging'

# work!
alias be="bundle exec"
alias grho="git back-to-origin"
alias harness="scripts/security-harness"
alias gpf="git push --force"
alias gpfs="git push security --force"
alias amend="git commit --amend"
alias ammend="amend"
alias cont="git rebase --continue"
alias zg="cd $GITLAB_HOME"
alias zc="cd $HOME/code/work/cli/"
alias zd="fasd_cd -d dotfiles"
alias zk="fasd_cd -d devkit"
alias lg="lazygit"
alias gdks="gdk start"
alias bundle-id="mdls -name kMDItemCFBundleIdentifier -r"

alias glab="$HOME/code/work/cli/bin/glab"

alias kd="kitty +kitten diff"


alias gdkdev='$HOME/code/work/devkit/gem/bin/gdk'

function fix_key_permissions() { # after reinstalling macos
	sudo chmod 600 ~/.ssh/id_ed25519
	sudo chmod 600 ~/.ssh/id_ed25519.pub
}

function diverged_commit() { git log "$GITLAB_MAIN_BRANCH"..$(git abbrev-ref) --oneline | tail -1 | awk '{ print $1 }'; }
function diverged_ref() { git rev-parse $(diverged_commit)^; }
function gch() { git checkout "$(git branch --list --sort=committerdate | fzf | tr -d '[:space:]')"; }
function rubocop_current_commit() { git diff-tree --no-commit-id --name-only -r HEAD --diff-filter AMT | xargs bundle exec rubocop; }
function rubocop_current_tree() { git diff --name-only --diff-filter AMT | xargs bundle exec rubocop; }
function rubocop_current_branch() { git diff --name-only "$GITLAB_MAIN_BRANCH" --diff-filter AMT | xargs bundle exec rubocop; }

test-changes() {
	bundle exec rspec $(git diff --name-only "$@" | grep -e '_spec.rb$')
}

glverify() {
	urlToMR=$1
	cd $GITLAB_HOME && pwd && curl $urlToMR.diff | git apply
}

cop() {
	bundle exec rubocop $(git diff --name-only "$@" | grep -e '.rb$')
}

function peek() { tmux split-window -p 33 "$VISUAL" "$@" || exit; }
function unquarantine() { xattr -d com.apple.quarantine "$@"; }
function unquarantine_app() { unquarantine "/Applications/$*"; }
function git_mr_changes() { git diff $(diverged_ref) HEAD; }
function git_mr_kchanges() { git ksdiff $(diverged_ref) HEAD; }
function rebase_mr() { git rebase -i $(diverged_ref); }
function kindlize() {
	local png="$HOME/code/kindle/kindle.png"
	convert -density 300 $1 -flatten -fuzz 1% -trim +repage $png
	convert $png -resize 800x600 -rotate 90 -colorspace Gray $png
	dropbox put $png new.png
}

function video_to_gif() {
	# https://gist.github.com/mcmoe/c76895ee86bd5293d58aca7a75afb6b2
	src=""        # required
	target=""     # optional (defaults to source file name)
	resolution="" # optional (defaults to source video resolution)
	fps=10        # optional (defaults to 10 fps -- helps drop frames)

	while [ $# -gt 0 ]; do
		if [[ $1 == *"--"* ]]; then
			param="${1/--/}"
			declare $param="$2"
		fi
		shift
	done

	if [[ -z $src ]]; then
		echo -e "\nPlease call 'v2g --src <source video file>' to run this command\n"
		return 1
	fi

	if [[ -z $target ]]; then
		target=$src
	fi

	basename=${target%.*}
	[[ ${#basename} = 0 ]] && basename=$target
	target="$basename.gif"

	if [[ -n $fps ]]; then
		fps="-r $fps"
	fi

	if [[ -n $resolution ]]; then
		resolution="-s $resolution"
	fi

	runcommand="ffmpeg -i \"$src\" -pix_fmt rgb8 $fps $resolution \"$target\" && gifsicle -O3 \"$target\" -o \"$target\""

	eval " $runcommand" && e_success "$target successfully converted and saved"
}
alias mov_to_gif='video_to_gif'

alias gdkthin="gdk stop rails-web && GITLAB_RAILS_RACK_TIMEOUT_ENABLE_LOGGING=false PUMA_SINGLE_MODE=true gdk rails s"
function okimdone() {
	branch=$(git branch --show-current)
	git clean -fd
	git checkout .
	git checkout $(git-origin-head)
	git delete-local-branch "$branch"
}

function glreview() {
	url="$(get_git_url "$1")"
	branch="$(get_branch "$1")"
	project="$(get_project "$1")"
	git fetch "$url" "$branch"
	git checkout -b "$project-$branch" FETCH_HEAD
	git reset --mixed "$(git merge-base "${2:-origin/$(git-origin-head)}" HEAD)"
}

function gdkreview() {
	cd "$GDK_DEV_HOME" || exit
	git fetch origin
	local branch
	branch="$(get_branch "$1")"
	new_branch "$branch" "${2:-origin}/$branch"
	git reset --mixed "$(git merge-base "${2:-origin/main}" HEAD)"
}

function new_mr() {
	cd "$GITLAB_HOME" || exit
	gldb-update
	git fetch origin
	local branch
	branch="$(get_branch "$1")"
	new_branch "$branch" "${2:-origin}/$branch"
}

function new_branch() {
	git branch "$1"
	git checkout "$1"
}

function grbm() {
	git fetch origin
	git rebase origin/$(git origin-head)
}

function zsh_stats() {
	fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

function gotest() {
	go test -json -v "${1:-./...}" 2>&1 | tee /tmp/gotest.log | gotestfmt
}

function h() { cd ~/"$1" || exit; }
function c() { cd ~/code/"$1" || exit; }
function cw() { cd ~/code/work/"$1" || exit; }

function search() {
	e_header "find . -iname \"*$1*\""
	sudo find . -iname "*$1*"
}

function yank-to-clipboard {
	zle vi-yank-whole-line
	echo "$CUTBUFFER" | tr -d '\n' | pbcopy
}

zle -N yank-to-clipboard
bindkey '^y' yank-to-clipboard
