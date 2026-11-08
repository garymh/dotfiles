function update-better-discord() {
    "$HOME/go/bin/cli" install --channel stable
}

function update-spotify() {
    spicetify update && spicetify apply
}

function update-neovim() {
    bob use nightly
}
# chmod u+w ~/.local/share/bob/nvim-bin/nvim && bob use nightly
# run this if bob breaks

function update-karabiner() {
    (cd "$DOTFILES/home/karabiner" && npm run build)
}

alias update-nvim="update-neovim"
