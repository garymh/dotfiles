# stuff oh-my-zsh tries to overwrite...

if [[ ! -f ~/.dircolors ]]; then
  # curl -o ~/.dircolors https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS
  curl -o ~/.dircolors https://raw.githubusercontent.com/arcticicestudio/nord-dircolors/master/src/dir_colors
fi

if _macos; then
  eval $(gdircolors -b $HOME/.dircolors)
else
  eval $(dircolors -b $HOME/.dircolors)
fi

if (( $+commands[exa] )) ; then
  alias ll="exa -l"
  alias lh="exa -d .*"
  alias la="exa -aF"
  alias ls="exa"
fi

if (( $+commands[brew] )) ; then
  HAS_BREW=1
  path=(
    $(brew --prefix)/sbin
    $(brew --prefix)/share/npm/bin
    $(brew --cellar)/coreutils
    $path
  )
fi

if zplug check 'ytet5uy4/fzf-widgets'; then
  bindkey '^w'  fzf-select-widget
  bindkey '^ws' fzf-exec-ssh

  bindkey '^gs' fzf-github-show-issue
  bindkey '^gx' fzf-github-close-issue
  bindkey '^ge' fzf-github-edit-issue
  bindkey '^gc' fzf-github-comment-issue
  bindkey '^go' fzf-github-open-issue
  bindkey '^gb' fzf-git-checkout-branch
  bindkey '^g^g' fzf-git-checkout-branch
fi
