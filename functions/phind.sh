#!/usr/bin/env sh
# Search for a given string in php files.
phind () {
    ack-grep --php -i "$@";
}
