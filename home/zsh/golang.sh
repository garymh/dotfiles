function gotest() {
    go test -json -v "${1:-./...}" 2>&1 | tee /tmp/gotest.log | gotestfmt
}

function race() { go run -race "$@" }
(( ${+functions[compdef]} )) && compdef _files race
