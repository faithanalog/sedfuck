#!/bin/sh
set -e

if command -v m4 2>&1 1>/dev/null && [ -f brainfuck.sed.m4 ]; then
    cat brainfuck.sed.m4 | sed '
        s/\[\]/\\([^<>]*<>\\)/g
        s/<>/<>/g
    ' | tee temp.m4 | m4 | grep '[^ ]' > brainfuck.sed
fi

if [ $# -eq 0 ]; then
    echo "Usage; $0 <brainfuck file>"
    exit 1
fi

awk 'BEGIN { print "$$$ENDSCRIPT$$$" }' | cat "$1" - | sed -n -f brainfuck.sed
