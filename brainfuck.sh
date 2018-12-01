set -e


cat brainfuck.sed.m4 | sed '
    s/\[\]/\\([^<>]*<>\\)/g
    s/<>/<>/g
' | tee temp.m4 | m4 | grep '[^ ]' > brainfuck.sed
cat helloworld.bf | sed -n -f brainfuck.sed 
