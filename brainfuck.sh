#!/bin/sh
set -e

if command -v m4 2>&1 1>/dev/null && [ -f brainfuck.sed.m4 ]; then
    cat brainfuck.sed.m4 | sed '
        s/\[\]/\\([^<>]*<>\\)/g
    ' | tee temp.m4 | m4 | grep '[^ ]' > brainfuck.sed
fi

if [ $# -eq 0 ]; then
    echo "Usage; $0 <minimized brainfuck file>"
    echo "    Note: only works for brainfuck files that are on a single line."
    exit 1
fi

cat "$1" | sed -n -f brainfuck.sed
