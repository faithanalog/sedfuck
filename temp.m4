b main
    # Init
    # First line read is the brainfuck code
    # Insert null byte
    # Memory: Stack in hold space
    # One line per entry
    # First line of the stack is the head.
    # Push: { s/$/\n/; G; h }         x \([^<>]*<>\)  -> x [x]
    # Peek: { g; s/\n.*$// }          x [a] -> a [a]
    # Drop: { x; s/^[^\n]*\n?//; x }  x [a b] -> x [b]
    # Pop:  Peek; Drop
    # Rotate: { x; s/$\n/; G; h             x [a b c] -> a b c x [a b c x]
    #           s/\n.*$//; x; s/$/\n/; G;   a b c x [a b c x] -> a [a b c x] -> a b c x a [a b c x]
    #           s/^[^\n]*\n//;          a b c x a -> b c x a -> 
    #           
    # Swap: { x; s/$/\n/; G; h x [a b c] -> a b c x [a b c x]
    #       }           
    
    # Stack operations a la FORTH 
    # These treat pattern space as a stack, using \x01 as element
    # terminators. Empty stack is a \x01 byte. Front of the stack is ^
    define(`LQ',`changequote(<,>)`dnl'
changequote`'')
    define(`RQ',`changequote(<,>)dnl`
'changequote`'')
    define(`r_ascii', `format(`%c', eval($1))')

    # define(`<>', `r_ascii(0x1)')
    # define(`\([^<>]*<>\)', `\([^<>]*<>\)')

    # Push(x): a b -> x a b
    define(`r_pushstr', `s/^/`$1'<>/')

    define(`r_pushnum', `s/^/format(`%d%d%d%d%d%d%d%d',eval((($1) >> 7) & 1),eval((($1) >> 6) & 1),eval((($1) >> 5) & 1),eval((($1) >> 4) & 1),eval((($1) >> 3) & 1),eval((($1) >> 2) & 1),eval((($1) >> 1) & 1),eval(($1) & 1))<>/')


    define(`_jmpidx', 0)

    # Call convention is to push the return address to the end of the stack
    define(`r_call', `
        define(`_jmpidx', incr(_jmpidx))
        s/|||/format(`%06d', _jmpidx)<>|||/
        b func_`$1'
        : `dynamic_'format(`%06d', _jmpidx)
    ')

    define(`r_func', `
        define(`r_$1', `r_call(`r_$1')')
        : func_r_`$1'
    ')

    # Ret:     [r x] -> [x] (return to r)
    define(`r_ret', `b dynamicDispatch')

    define(`r_endfunc', `r_ret')

    define(`_anonidx', 0)
    define(`r_anon', `define(`_anonidx', format(`%06d', incr(_anonidx)))`anon_'_anonidx')

    define(`r_clearBranchCache', `
        pushdef(`_t', r_anon)
        s/$//; t _t
        : _t
        popdef(`_t')
    ')

    # Drop:    a b -> b
    define(`r_drop', `s/^\([^<>]*<>\)//')

    # Swap:    a b -> b a
    define(`r_swap', `s/^\([^<>]*<>\)\([^<>]*<>\)/\2\1/')

    # Rot: a b c -> b c a
    define(`r_rot', `s/^\([^<>]*<>\)\([^<>]*<>\)\([^<>]*<>\)/\2\1/')

    # Dup: a -> a a
    define(`r_dup', `s/^\([^<>]*<>\)/\1\1/')

    # 2dup: a b -> a b a b
    define(`r_2dup', `s/^\([^<>]*<>\)\([^<>]*<>\)/\1\2\1\2')

    # 2drop: a b c -> c
    define(`r_2drop', `s/^\([^<>]*<>\)\([^<>]*<>\)//')

    # 8 bit binary add
    # X Y -> X+Y
    r_func(`add')
        # Ripply-carry adder
        # Insert beginning carry bit
        s/^/0<>/
        r_clearBranchCache
        pushdef(`_i', 0)
        pushdef(`_lp', `
            pushdef(`_end', r_anon)
            s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/00\1<>\2<>\3<>/; t _end
            s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/01\1<>\2<>\3<>/; t _end
            s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/01\1<>\2<>\3<>/; t _end
            s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/10\1<>\2<>\3<>/; t _end

            s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/01\1<>\2<>\3<>/; t _end
            s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/10\1<>\2<>\3<>/; t _end
            s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/10\1<>\2<>\3<>/; t _end
            s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/11\1<>\2<>\3<>/; t _end
            : _end
            popdef(`_end')

            define(`_i', incr(_i))
            ifelse(_i, 8, , `_lp')
        ')
        _lp
        popdef(`_lp')
        popdef(`_i')

        # Remove carry bit and X/Y args
        s/^[01]\([01]*\)<>[01]*<>[01]*<>/\1<>/
    r_endfunc

    # Negate 8-bit number
    define(`r_neg', `
        r_clearBranchCache
        pushdef(`step_', r_anon)
        # Invert each bit one at a time
        s/^\([01][01][01][01][01][01][01]\)0/\11/; t step_`1'
        s/^\([01][01][01][01][01][01][01]\)1/\10/; t step_`1'
        : step_`1'

        s/^\([01][01][01][01][01][01]\)0\([01]\)/\11\2/; t step_`2'
        s/^\([01][01][01][01][01][01]\)1\([01]\)/\10\2/; t step_`2'
        : step_`2'

        s/^\([01][01][01][01][01]\)0\([01][01]\)/\11\2/; t step_`3'
        s/^\([01][01][01][01][01]\)1\([01][01]\)/\10\2/; t step_`3'
        : step_`3'

        s/^\([01][01][01][01]\)0\([01][01][01]\)/\11\2/; t step_`4'
        s/^\([01][01][01][01]\)1\([01][01][01]\)/\10\2/; t step_`4'
        : step_`4'

        s/^\([01][01][01]\)0\([01][01][01][01]\)/\11\2/; t step_`5'
        s/^\([01][01][01]\)1\([01][01][01][01]\)/\10\2/; t step_`5'
        : step_`5'

        s/^\([01][01]\)0\([01][01][01][01][01]\)/\11\2/; t step_`6'
        s/^\([01][01]\)1\([01][01][01][01][01]\)/\10\2/; t step_`6'
        : step_`6'

        s/^\([01]\)0\([01][01][01][01][01][01]\)/\11\2/; t step_`7'
        s/^\([01]\)1\([01][01][01][01][01][01]\)/\10\2/; t step_`7'
        : step_`7'

        s/^0\([01][01][01][01][01][01][01]\)/1\1/; t step_`8'
        s/^1\([01][01][01][01][01][01][01]\)/0\1/; t step_`8'
        : step_`8'

        popdef(`step_')
    ')

    define(`r_sub', `
        r_neg
        r_add
    ')

    define(`r_inc', `
        r_clearBranchCache
        pushdef(`step_', r_anon)
        # Increment one bit at a time
        s/^\([01][01][01][01][01][01][01]\)0/0\11/; t step_`1'
        s/^\([01][01][01][01][01][01][01]\)1/1\10/; t step_`1'
        : step_`1'

        s/^0\([01][01][01][01][01][01]\)0\([01]\)/0\10\2/; t step_`2'
        s/^0\([01][01][01][01][01][01]\)1\([01]\)/0\11\2/; t step_`2'
        s/^1\([01][01][01][01][01][01]\)0\([01]\)/0\11\2/; t step_`2'
        s/^1\([01][01][01][01][01][01]\)1\([01]\)/1\10\2/; t step_`2'
        : step_`2'

        s/^0\([01][01][01][01][01]\)0\([01][01]\)/0\10\2/; t step_`3'
        s/^0\([01][01][01][01][01]\)1\([01][01]\)/0\11\2/; t step_`3'
        s/^1\([01][01][01][01][01]\)0\([01][01]\)/0\11\2/; t step_`3'
        s/^1\([01][01][01][01][01]\)1\([01][01]\)/1\10\2/; t step_`3'
        : step_`3'

        s/^0\([01][01][01][01]\)0\([01][01][01]\)/0\10\2/; t step_`4'
        s/^0\([01][01][01][01]\)1\([01][01][01]\)/0\11\2/; t step_`4'
        s/^1\([01][01][01][01]\)0\([01][01][01]\)/0\11\2/; t step_`4'
        s/^1\([01][01][01][01]\)1\([01][01][01]\)/1\10\2/; t step_`4'
        : step_`4'

        s/^0\([01][01][01]\)0\([01][01][01][01]\)/0\10\2/; t step_`5'
        s/^0\([01][01][01]\)1\([01][01][01][01]\)/0\11\2/; t step_`5'
        s/^1\([01][01][01]\)0\([01][01][01][01]\)/0\11\2/; t step_`5'
        s/^1\([01][01][01]\)1\([01][01][01][01]\)/1\10\2/; t step_`5'
        : step_`5'

        s/^0\([01][01]\)0\([01][01][01][01][01]\)/0\10\2/; t step_`6'
        s/^0\([01][01]\)1\([01][01][01][01][01]\)/0\11\2/; t step_`6'
        s/^1\([01][01]\)0\([01][01][01][01][01]\)/0\11\2/; t step_`6'
        s/^1\([01][01]\)1\([01][01][01][01][01]\)/1\10\2/; t step_`6'
        : step_`6'

        s/^0\([01]\)0\([01][01][01][01][01][01]\)/0\10\2/; t step_`7'
        s/^0\([01]\)1\([01][01][01][01][01][01]\)/0\11\2/; t step_`7'
        s/^1\([01]\)0\([01][01][01][01][01][01]\)/0\11\2/; t step_`7'
        s/^1\([01]\)1\([01][01][01][01][01][01]\)/1\10\2/; t step_`7'
        : step_`7'

        s/^00\([01][01][01][01][01][01][01]\)/0\1/; t step_`8'
        s/^01\([01][01][01][01][01][01][01]\)/1\1/; t step_`8'
        s/^10\([01][01][01][01][01][01][01]\)/1\1/; t step_`8'
        s/^11\([01][01][01][01][01][01][01]\)/0\1/; t step_`8'
        : step_`8'
        popdef(`step_')
    ')

    define(`r_dec', `
        r_neg
        r_inc
        r_neg
    ')

    define(`r_not', `
        pushdef(`_end', r_anon)
        r_clearBranchCache
        s/^[0]*<>/00000001<>/; t _end
        s/^[^<>]*<>/00000000<>/; t _end
        : _end
        popdef(`_end')
    ')

    define(`r_eq', `
        r_sub
        r_not
    ')

    # [X Y] -> [X<=Y]
    define(`r_lt', `
        r_sub
        pushdef(`_end', r_anon)
        r_clearBranchCache
        # If x < y then result will be positive
        s/^0[^<>]*<>/00000001<>/; t _end
        s/^1[^<>]*<>/00000000<>/; t _end
        : _end
        popdef(`_end')
    ')

    define(`r_or', `
        r_add
        r_not
        r_not
    ')

    define(`r_and', `
        r_not
        r_swap
        r_not
        r_or
    ')

    define(`r_le', `
        r_2dup
        r_lt
        r_rot
        r_eq
        r_rot
        r_or
    ')


    define(`r_rshift', `s/^\([01]*\)[01]<>/0\1<>/')
    define(`r_lshift', `s/^[01]\([01]*\)<>/\10<>/')

    # 8-bit And
    r_func(`bitand')
        s/^/<>/
        r_clearBranchCache
        pushdef(`_i', 0)
        pushdef(`_lp', `
            pushdef(`_end', r_anon)
            s/^\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/0\1<>\2<>\3<>/; t _end
            s/^\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/0\1<>\2<>\3<>/; t _end
            s/^\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/0\1<>\2<>\3<>/; t _end
            s/^\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/1\1<>\2<>\3<>/; t _end
            : _end
            popdef(`_end')

            define(`_i', incr(_i))
            ifelse(_i, 8, , `_lp')
        ')
        _lp
        popdef(`_lp')
        popdef(`_i')
        s/\([^<>]*<>\)\([^<>]*<>\)\([^<>]*<>\)/\1/
    r_endfunc

    r_func(`bin2hex')
        r_dup
        r_pushnum(0xF)
        r_bitand
        s/^0000//
        r_clearBranchCache
        pushdef(`_end', r_anon)
        s/^0000<>/0<>/; t _end
        s/^0001<>/1<>/; t _end
        s/^0010<>/2<>/; t _end
        s/^0011<>/3<>/; t _end
        s/^0100<>/4<>/; t _end
        s/^0101<>/5<>/; t _end
        s/^0110<>/6<>/; t _end
        s/^0111<>/7<>/; t _end
        s/^1000<>/8<>/; t _end
        s/^1001<>/9<>/; t _end
        s/^1010<>/A<>/; t _end
        s/^1011<>/B<>/; t _end
        s/^1100<>/C<>/; t _end
        s/^1101<>/D<>/; t _end
        s/^1110<>/E<>/; t _end
        s/^1111<>/F<>/; t _end
        : _end
        popdef(`_end')
        r_swap
        r_rshift
        r_rshift
        r_rshift
        r_rshift
        r_pushnum(0xF)
        r_bitand
        s/^0000//
        r_clearBranchCache
        pushdef(`_end', r_anon)
        s/^0000<>/0/; t _end
        s/^0001<>/1/; t _end
        s/^0010<>/2/; t _end
        s/^0011<>/3/; t _end
        s/^0100<>/4/; t _end
        s/^0101<>/5/; t _end
        s/^0110<>/6/; t _end
        s/^0111<>/7/; t _end
        s/^1000<>/8/; t _end
        s/^1001<>/9/; t _end
        s/^1010<>/A/; t _end
        s/^1011<>/B/; t _end
        s/^1100<>/C/; t _end
        s/^1101<>/D/; t _end
        s/^1110<>/E/; t _end
        s/^1111<>/F/; t _end
        : _end
        popdef(`_end')
        s/^\([0-9A-F]\)<>\([0-9A-F]\)<>/\2\1<>/
    r_endfunc

    r_func(`putc')
        r_bin2hex
        r_clearBranchCache
        pushdef(`tmp_', r_anon)

        /^0/ b tmp_`0'
        /^1/ b tmp_`1'
        /^2/ b tmp_`2'
        /^3/ b tmp_`3'
        /^4/ b tmp_`4'
        /^5/ b tmp_`5'
        /^6/ b tmp_`6'
        /^7/ b tmp_`7'

        : tmp_`0'
        s/^01/r_ascii(0x01)/; t tmp_`end'
        s/^02/r_ascii(0x02)/; t tmp_`end'
        s/^03/r_ascii(0x03)/; t tmp_`end'
        s/^04/r_ascii(0x04)/; t tmp_`end'
        s/^05/r_ascii(0x05)/; t tmp_`end'
        s/^06/r_ascii(0x06)/; t tmp_`end'
        s/^07/r_ascii(0x07)/; t tmp_`end'
        s/^08/r_ascii(0x08)/; t tmp_`end'
        s/^09/r_ascii(0x09)/; t tmp_`end'
        s/^0A/\n/; t tmp_`end'
        s/^0B/r_ascii(0x0B)/; t tmp_`end'
        s/^0C/r_ascii(0x0C)/; t tmp_`end'
        s/^0D/r_ascii(0x0D)/; t tmp_`end'
        s/^0E/r_ascii(0x0E)/; t tmp_`end'
        s/^0F/r_ascii(0x0F)/; t tmp_`end'

        : tmp_`1'
        s/^11/r_ascii(0x11)/; t tmp_`end'
        s/^12/r_ascii(0x12)/; t tmp_`end'
        s/^13/r_ascii(0x13)/; t tmp_`end'
        s/^14/r_ascii(0x14)/; t tmp_`end'
        s/^15/r_ascii(0x15)/; t tmp_`end'
        s/^16/r_ascii(0x16)/; t tmp_`end'
        s/^17/r_ascii(0x17)/; t tmp_`end'
        s/^18/r_ascii(0x18)/; t tmp_`end'
        s/^19/r_ascii(0x19)/; t tmp_`end'
        s/^1A/r_ascii(0x1A)/; t tmp_`end'
        s/^1B/r_ascii(0x1B)/; t tmp_`end'
        s/^1C/r_ascii(0x1C)/; t tmp_`end'
        s/^1D/r_ascii(0x1D)/; t tmp_`end'
        s/^1E/r_ascii(0x1E)/; t tmp_`end'
        s/^1F/r_ascii(0x1F)/; t tmp_`end'

        : tmp_`2'
        s/^20/ /; t tmp_`end'
        s/^21/!/; t tmp_`end'
        s/^22/"/; t tmp_`end'
        s/^23/#/; t tmp_`end'
        s/^24/$/; t tmp_`end'
        s/^25/%/; t tmp_`end'
        s/^26/&/; t tmp_`end'
        s/^27/RQ()/; t tmp_`end'
        s/^28/(/; t tmp_`end'
        s/^29/)/; t tmp_`end'
        s/^2A/*/; t tmp_`end'
        s/^2B/+/; t tmp_`end'
        s/^2C/,/; t tmp_`end'
        s/^2D/-/; t tmp_`end'
        s/^2E/./; t tmp_`end'
        s/^2F/\//; t tmp_`end'

        : tmp_`3'
        s/^30/0/; t tmp_`end'
        s/^31/1/; t tmp_`end'
        s/^32/2/; t tmp_`end'
        s/^33/3/; t tmp_`end'
        s/^34/4/; t tmp_`end'
        s/^35/5/; t tmp_`end'
        s/^36/6/; t tmp_`end'
        s/^37/7/; t tmp_`end'
        s/^38/8/; t tmp_`end'
        s/^39/9/; t tmp_`end'
        s/^3A/:/; t tmp_`end'
        s/^3B/;/; t tmp_`end'
        s/^3C/</; t tmp_`end'
        s/^3D/=/; t tmp_`end'
        s/^3E/>/; t tmp_`end'
        s/^3F/?/; t tmp_`end'

        : tmp_`4'
        s/^40/@/; t tmp_`end'
        s/^41/A/; t tmp_`end'
        s/^42/B/; t tmp_`end'
        s/^43/C/; t tmp_`end'
        s/^44/D/; t tmp_`end'
        s/^45/E/; t tmp_`end'
        s/^46/F/; t tmp_`end'
        s/^47/G/; t tmp_`end'
        s/^48/H/; t tmp_`end'
        s/^49/I/; t tmp_`end'
        s/^4A/J/; t tmp_`end'
        s/^4B/K/; t tmp_`end'
        s/^4C/L/; t tmp_`end'
        s/^4D/M/; t tmp_`end'
        s/^4E/N/; t tmp_`end'
        s/^4F/O/; t tmp_`end'

        : tmp_`5'
        s/^50/P/; t tmp_`end'
        s/^51/Q/; t tmp_`end'
        s/^52/R/; t tmp_`end'
        s/^53/S/; t tmp_`end'
        s/^54/T/; t tmp_`end'
        s/^55/U/; t tmp_`end'
        s/^56/V/; t tmp_`end'
        s/^57/W/; t tmp_`end'
        s/^58/X/; t tmp_`end'
        s/^59/Y/; t tmp_`end'
        s/^5A/Z/; t tmp_`end'
        s/^5B/[/; t tmp_`end'
        s/^5C/\\/; t tmp_`end'
        s/^5D/]/; t tmp_`end'
        s/^5E/^/; t tmp_`end'
        s/^5F/_/; t tmp_`end'

        : tmp_`6'
        s/^60/LQ()/; t tmp_`end'
        s/^61/a/; t tmp_`end'
        s/^62/b/; t tmp_`end'
        s/^63/c/; t tmp_`end'
        s/^64/d/; t tmp_`end'
        s/^65/e/; t tmp_`end'
        s/^66/f/; t tmp_`end'
        s/^67/g/; t tmp_`end'
        s/^68/h/; t tmp_`end'
        s/^69/i/; t tmp_`end'
        s/^6A/j/; t tmp_`end'
        s/^6B/k/; t tmp_`end'
        s/^6C/l/; t tmp_`end'
        s/^6D/m/; t tmp_`end'
        s/^6E/n/; t tmp_`end'
        s/^6F/o/; t tmp_`end'

        : tmp_`7'
        s/^70/p/; t tmp_`end'
        s/^71/q/; t tmp_`end'
        s/^72/r/; t tmp_`end'
        s/^73/s/; t tmp_`end'
        s/^74/t/; t tmp_`end'
        s/^75/u/; t tmp_`end'
        s/^76/v/; t tmp_`end'
        s/^77/w/; t tmp_`end'
        s/^78/x/; t tmp_`end'
        s/^79/y/; t tmp_`end'
        s/^7A/z/; t tmp_`end'
        s/^7B/{/; t tmp_`end'
        s/^7C/|/; t tmp_`end'
        s/^7D/}/; t tmp_`end'
        s/^7E/~/; t tmp_`end'
        s/^7F/r_ascii(0x7F)/; t tmp_`end'

        : tmp_`end'

        H
        x
        s/\([^<>]*\)<>.*$/\1/
        /\n$/ {
            s/\n$//
            P
            s/^.*$//
        }
        s/\n//g
        x
        s/\([^<>]*<>\)//
        popdef(`tmp_')
    r_endfunc


    # Increment a binary number
#    : increment
#    s/\([01]*\)0$/\11/; t endIncrement
#    s/\([01]*\)01$/\110/; t endIncrement
#    s/\([01]*\)011$/\1110/; t endIncrement
#    s/\([01]*\)0111$/\11110/; t endIncrement
#    s/\([01]*\)01111$/\111110/; t endIncrement
#    s/\([01]*\)011111$/\1111110/; t endIncrement
#    s/\([01]*\)0111111$/\11111110/; t endIncrement
#    s/\([01]*\)01111111$/\111111110/; t endIncrement
#    s/11111111$/00000000/
#    : endIncrement
#
#    : decrement



# Memory access
define(`r_bf_irotl', `s/|||\([0-8]\)\([0-8]*\)/|||\2\1/')
define(`r_bf_irotr', `s/|||\([0-8]*\)\([0-8]\)/|||\2\1/')
define(`r_bf_iget', `s/^\(.*\)|||\([0-8]\)/\2<>\1|||\2/')

# Rotations will auto-grow tape memory space
define(`r_bf_mrotl', `
    s/\([01@]*\)\(........\)$/\2\1/
    s/@@@@@@@@$/@@@@@@@@00000000/
')
define(`r_bf_mrotr', `
    s/###\(........\)\(.*\)$/###\2\1/
    s/###\(.*\)@@@@@@@@$/###@@@@@@@@\100000000/
')

define(`r_bf_mget', `s/^\(.*\)\(........\)$/\2<>\1\2/')
define(`r_bf_mset', `s/^\(........\)<>\(.*\)........$/\2\1/')

# Functions
# Counterintuitively, moving the pointer right means rotating the memory
# *left*, because our read head is always in the same place.
define(`r_bf_xptrr', `r_bf_mrotl')
define(`r_bf_xptrl', `r_bf_mrotr')
define(`r_bf_xinc', `
    r_bf_mget
    r_inc
    r_bf_mset
')
define(`r_bf_xdec', `
    r_bf_mget
    r_dec
    r_bf_mset
')
define(`r_bf_xout', `
    r_bf_mget
    r_putc
')
define(`r_bf_xin', `') # TODO

define(`r_bf_xblkstart', `
    r_bf_mget
    r_clearBranchCache
    /^00000000/ {
        # We could drop the top value and push the depth, but
        # we need the depth to be 0, which is our top value,
        # so we just leave the top value of the stack to be the depth

        pushdef(`_start', r_anon)
        pushdef(`_end', r_anon)
        : _start
        r_bf_irotl
        r_bf_iget

        # Closing brace at depth 0: done
        /^7<>00000000/ {
            r_drop
            b _end
        }

        # Closing brace at any other depth: dec depth
        /^7<>/ {
            r_drop
            r_dec
            b _start
        }

        # Open brace: increase depth
        /^6<>/ {
            r_drop
            r_inc
            b _start
        }

        # Anything else: just chill
        r_drop
        b _start

        : _end

        # Let the drop after this block drop the depth

        popdef(`_start')
        popdef(`_end')
    }
    r_drop
')

define(`r_bf_xblkend', `
    r_bf_mget
    pushdef(`_nop', r_anon)
    /^00000000<>/ b _nop

    r_drop

    # Put depth on stack
    r_pushnum(0)

    pushdef(`_start', r_anon)
    pushdef(`_end', r_anon)
    : _start
    r_bf_irotr
    r_bf_iget

    # Open brace at depth 0: done
    /^6<>00000000<>/ {
        r_drop
        b _end
    }

    # Open brace at any other depth: dec depth
    /^6<>/ {
        r_drop
        r_dec
        b _start
    }

    # Close brace: increase depth
    /^7<>/ {
        r_drop
        r_inc
        b _start
    }

    # Anything else: just chill
    r_drop
    b _start

    : _end

    # the end r_drop will drop out depth
    popdef(`_start')
    popdef(`_end')


    : _nop
    popdef(`_nop')
    r_drop
')

: main
    # Convert brainfuck script in first line to bytecode
    # Have to use a different stack terminator, and switch back afterwards
    
    # Delete irrelevant characters
    s/[^><+-\.,\[\]]//g

    # Convert to numbers because its easier to deal with
    # The order is weird because otherwise sed breaks with the square brackets
    y/[><+-.,]/60123457/

    # Make sure braces are balanced
    h
    r_clearBranchCache
    : braceVerificationLoop
    s/[^67]//
    s/67//; t braceVerificationLoop
    /^[67]$/ {
        s/^.*$//
        i Error: imbalanced braces
        p
        b
    }
    
    # Clear out the buffer and swap
    s/^.*$//
    x

    # Add an EOF to the code
    s/$/8/


    # Add stack barrier in front of code
    s/^/|||/
    
    # Add tape memory after code (1 byte)
    s/$/###@@@@@@@@00000000/
    # Grow tape memory to 32 bytes
    #s/###\(0*\)$/###\1\1/
    #s/###\(0*\)$/###\1\1/
    #s/###\(0*\)$/###\1\1/
    #s/###\(0*\)$/###\1\1/
    #s/###\(0*\)$/###\1\1/
    #s/###\(0*\)$/###\1\1/
    #s/###\(0*\)$/###\1\1/
    #s/###\(0*\)$/###\1\1/

    # Main execution cycle
    : main_loop_start
        r_bf_iget
        /^0<>/ { 
            r_bf_xptrr
            b main_loop_end
        }
        /^1<>/ { 
            r_bf_xptrl
            b main_loop_end
        }
        /^2<>/ { 
            r_bf_xinc
            b main_loop_end
        }
        /^3<>/ { 
            r_bf_xdec
            b main_loop_end
        }
        /^4<>/ { 
            r_bf_xout
            b main_loop_end
        }
        /^5<>/ { 
            r_bf_xin
            b main_loop_end
        }
        /^6<>/ { 
            r_bf_xblkstart
            b main_loop_end
        }
        /^7<>/ { 
            r_bf_xblkend
            b main_loop_end
        }
        /^8<>/ {
            b prog_end
        }
        : main_loop_end
        r_drop
        r_bf_irotl
    b main_loop_start

    : prog_end
    r_pushnum(0x0a)
    r_putc
    b

# TODO make this a tree instead of linear search
# IMPORTANT
# This has to be the very last thing in the file for this code to work
: dynamicDispatch
    # Move return addr from the bottom to the top of the stack for faster
    # searches
    s/^\(.*\)\([0-9][0-9][0-9][0-9][0-9][0-9]<>\)|||/\2\1|||/
    r_clearBranchCache
    pushdef(`_i', 0)
    pushdef(`_lp', `
        define(`_i', incr(_i))
        s/^format(`%06d', _i)<>//; t `dynamic_'format(`%06d', _i)
        ifelse(_i, _jmpidx, , `_lp')
    ')
    _lp
    popdef(`_lp')
    i Dynamic dispatch failed; printing stack:
    p
    b

