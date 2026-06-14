#!/usr/local/bin/bash

function update-better-discord() {
  bdcli install --channel stable
}

function update-spotify() {
  spicetify update && spicetify apply
}

function update-neovim() {
  bob install nightly
}

alias update-nvim="update-neovim"
