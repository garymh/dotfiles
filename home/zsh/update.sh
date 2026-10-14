function update-better-discord() {
    "$HOME/go/bin/cli" install --channel stable
}

function update-spotify() {
    spicetify update && spicetify apply
}

function update-neovim() {
    bob use nightly
}

function update-karabiner() {
    (cd "$DOTFILES/home/karabiner" && npm run build)
}

alias update-nvim="update-neovim"
