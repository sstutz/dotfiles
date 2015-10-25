#!/usr/bin/env sh
# remove passwords from protected pdf's
removePdfPass(){
    gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="no_pass_$1" -c .setpdfwrite -f "$1"
}
