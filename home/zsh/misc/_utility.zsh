_exists() {
  command -v $1 > /dev/null 2>&1
}

e_header()  { echo -e "\n\033[1m$@\033[0m"; }
e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }

OS=$($(which uname))

_macos() {
  if [[ $OS = 'Darwin' ]]; then
    return 0
  else
    return 1
  fi
}

_linux() {
  if [[ $OS = 'Linux' ]]; then
    return 0
  else
    return 1
  fi
}
