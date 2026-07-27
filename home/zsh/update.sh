function update-better-discord() {
  "$HOME/go/bin/cli" install --channel stable
}

function update-spotify() {
  spicetify update && spicetify apply
}

function update-neovim() {
  bob use nightly
}

alias update-nvim="update-neovim"
