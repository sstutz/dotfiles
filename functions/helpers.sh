#!/usr/bin/env sh
nc="$(tput sgr0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"


##
# warn: Print a message to stderr.
# Usage: warn "message"
#
warn() {
  printf " [${red}Warn${nc}] %s\n" "$1" >&2
}


##
# success: Print a message to stdout.
# Usage: success "message"
#
success () {
  printf " [${green} OK ${nc}] %s\n" "$1"
}


##
# success: Print a info message to stdout.
# Usage: info "message"
#
info() {
    printf " [${blue} .. ${nc}] %s\n" "$1"
}


##
# success: Print a info message to stdout.
# Usage: info "message"
#
user() {
    printf " [${yellow} ?? ${nc}] %s\n" "$1"
}


##
# die (simple version): Print a message to stderr
# and exit with the exit status of the most recent
# command.
# Usage: some_command || die "message"
#
die() {
  local st="$?"
  warn "$1"
  exit "$st"
}

##
# verbose output for cp and rm
#
for c in mv cp rm rmdir; do
    alias $c="$c -v"
done
