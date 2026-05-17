#!/usr/local/bin/bash

function citest() {
    gotestsum --jsonfile test-output.log --no-summary=skipped --junitfile ./coverage.xml --format short -- -coverprofile=./coverage.txt -covermode=atomic ./pkg/... ./internal/... ./commands/... ./cmd/...
}

function gotest() {
    go test -json -v "${1:-./...}" 2>&1 | tee /tmp/gotest.log | gotestfmt
}

