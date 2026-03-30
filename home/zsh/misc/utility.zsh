_exists() {
    command -v $1 > /dev/null 2>&1
}

_file_exists() {
    [ -e $1 ]
}

e_header()  { echo -e "\n\033[1m$@\033[0m"; }
e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }
e_missing()   { e_error "\"brew install $1\" when you get a minute" }

OS=$(uname)

_macos() { [[ $OS = Darwin ]] }
_linux() { [[ $OS = Linux ]] }
