#!/usr/bin/env sh
genpwd() {
    local length=$1
    [ "$length" == "" ] && length=12
    tr -dc [:graph:] < /dev/urandom | head -c ${length}; echo
}

