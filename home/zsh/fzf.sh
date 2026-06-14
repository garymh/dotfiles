if _file_exists ~/.fzf.zsh; then

    _fzf_git_branches_checkout() {
        _fzf_git_check || return

        local default_branch
        default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
        if [[ -z $default_branch ]]; then
            if git show-ref --verify --quiet refs/heads/main; then
                default_branch="main"
            elif git show-ref --verify --quiet refs/heads/master; then
                default_branch="master"
            else
                default_branch="main" # Final fallback
            fi
        fi

        local worktree_count
        worktree_count=$(git worktree list --porcelain 2>/dev/null | grep -c "^worktree")
        if [[ "$worktree_count" -gt 1 ]]; then
            zle -I
            wt switch </dev/tty
            zle reset-prompt
        else
            local branch
            branch=$(
                bash "$__fzf_git" --list branches |
                FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS" fzf --ansi \
                    --border-label '🌲 Branches (checkout on enter)' \
                    --header $'CTRL-G (checkout '$default_branch') ╱ CTRL-O (browser) ╱ ALT-A (all branches)' \
                    --header-lines 2 \
                    --tiebreak begin \
                    --preview-window down,border-top,40% \
                    --color hl:underline,hl+:underline \
                    --no-hscroll \
                    --bind 'ctrl-/:change-preview-window(down,70%|hidden|)' \
                    --bind "ctrl-g:execute(git checkout $default_branch)+abort" \
                    --bind "ctrl-o:execute-silent:bash \"$__fzf_git\" --list branch {}" \
                    --bind "alt-a:change-border-label(🌳 All branches)+reload:bash \"$__fzf_git\" --list all-branches" \
                    --preview "git log --oneline --graph --date=short --color=always --pretty='format:%C(auto)%cd %h%d %s' \$(cut -c3- <<< {} | cut -d' ' -f1) --" |
                sed 's/^\* //' | awk '{print $1}'
            )

            if [[ -n $branch ]]; then
                git checkout "$branch"
            fi
        fi


    }

    # Create widget
    fzf-git-branches-checkout-widget() {
        _fzf_git_branches_checkout
        zle reset-prompt
    }
    zle -N fzf-git-branches-checkout-widget

    bindkey -M emacs '^g^g' fzf-git-branches-checkout-widget
    bindkey -M vicmd '^g^g' fzf-git-branches-checkout-widget
    bindkey -M viins '^g^g' fzf-git-branches-checkout-widget

    zle -N fzf-file-widget

    export FZF_DEFAULT_OPTS="--multi
  --ansi
  --bind 'ctrl-a:select-all+accept'
  --bind 'ctrl-o:execute[open {}]'
  --bind 'ctrl-f:page-down'
  --bind 'ctrl-d:change-prompt(Directories> )+reload(find * -type d)'
  --bind 'ctrl-g:change-prompt(Files> )+reload(find * -type f)'
  --bind 'ctrl-y:execute-silent(echo {} | pbcopy)+abort'"

    export FZF_CTRL_T_OPTS="
  $FZF_CTRL_T_OPTS
  --bind 'enter:execute(${EDITOR:-nvim} {} < /dev/tty > /dev/tty)+abort'
  "

    # Use ~~ as the trigger sequence instead of the default **
    export FZF_COMPLETION_TRIGGER='~~'

    # Options to fzf command
    export FZF_COMPLETION_OPTS='--border --info=inline'

    # Options for path completion (e.g. vim **<TAB>)
    export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

    # Options for directory completion (e.g. cd **<TAB>)
    export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

    #   # --color header:italic
    #   # --header '? preview / <C-d> dirs / <C-g> files / <C-o> open / <C-y> copy'
    #   # --header-border=sharp
    #   # --info=inline

    ikill() {
        (
            date
            ps -ef
        ) |
        fzf --bind='ctrl-r:reload(date; ps -ef)' \
            --header=$'Press CTRL-R to reload\n\n' --header-lines=2 \
            --preview='echo {}' --preview-window=down,3,wrap \
            --layout=reverse --height=80% | awk '{print $2}' | xargs kill -9
    }

    rfv() {
        rg --color=always --line-number --no-heading --smart-case "${*:-}" |
        fzf --ansi \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --delimiter : \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
            --bind 'enter:become($EDITOR {1} +{2})'
    }

    rfv2() {
        RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
        INITIAL_QUERY="${*:-}"
        fzf --ansi --disabled --query "$INITIAL_QUERY" \
            --bind "start:reload:$RG_PREFIX {q}" \
            --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
            --delimiter : \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
            --bind 'enter:become($EDITOR {1} +{2})'
    }

    rfv3() {
        # Switch between Ripgrep mode and fzf filtering mode (CTRL-T)
        rm -f /tmp/rg-fzf-{r,f}
        RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
        INITIAL_QUERY="${*:-}"
        fzf --ansi --disabled --query "$INITIAL_QUERY" \
            --bind "start:reload:$RG_PREFIX {q}" \
            --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --bind 'ctrl-t:transform:[[ ! $FZF_PROMPT =~ ripgrep ]] &&
      echo "rebind(change)+change-prompt(1. ripgrep> )+disable-search+transform-query:echo \{q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r" ||
      echo "unbind(change)+change-prompt(2. fzf> )+enable-search+transform-query:echo \{q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"' \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --prompt '1. ripgrep> ' \
            --delimiter : \
            --header 'CTRL-T: Switch between ripgrep/fzf' \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
            --bind 'enter:become($EDITOR {1} +{2})'
    }

fi
