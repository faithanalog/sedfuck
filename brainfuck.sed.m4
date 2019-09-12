# Branch to the entry point
# Main is at the end of the file so it can make use of the m4 macros.
b main


define(`LQ',`changequote(<,>)`dnl'
changequote`'')
define(`RQ',`changequote(<,>)dnl`
'changequote`'')
define(`r_ascii', `format(`%c', eval($1))')

# Push a string constant to the stack
# In practice this rarely gets used
define(`r_pushstr', `s/^/`$1'<>/')

# Push a numeric constant to the stack as an 8-bit integer
define(`s_binary', `format(`%d%d%d%d%d%d%d%d',eval((($1) >> 7) & 1),eval((($1) >> 6) & 1),eval((($1) >> 5) & 1),eval((($1) >> 4) & 1),eval((($1) >> 3) & 1),eval((($1) >> 2) & 1),eval((($1) >> 1) & 1),eval(($1) & 1))')
define(`r_pushnum', `s/^/s_binary(`$1')<>/')


# This index is used for generating sequential labels for function returns
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
define(`r_drop', `s/^[]//')

# Swap:    a b -> b a
define(`r_swap', `s/^[][]/\2\1/')

# Rot: a b c -> b c a
define(`r_rot', `s/^[][][]/\2\1\3/')

# Dup: a -> a a
define(`r_dup', `s/^[]/\1\1/')

# Negate 8-bit number
define(`r_neg', `
    r_clearBranchCache
    pushdef(`step_', r_anon)
    # Invert each bit one at a time
    s/^\(.......\)0/\11/; t step_`1'
    s/^\(.......\)1/\10/; t step_`1'
    : step_`1'

    s/^\(......\)0\(.\)/\11\2/; t step_`2'
    s/^\(......\)1\(.\)/\10\2/; t step_`2'
    : step_`2'

    s/^\(.....\)0\(..\)/\11\2/; t step_`3'
    s/^\(.....\)1\(..\)/\10\2/; t step_`3'
    : step_`3'

    s/^\(....\)0\(...\)/\11\2/; t step_`4'
    s/^\(....\)1\(...\)/\10\2/; t step_`4'
    : step_`4'

    s/^\(...\)0\(....\)/\11\2/; t step_`5'
    s/^\(...\)1\(....\)/\10\2/; t step_`5'
    : step_`5'

    s/^\(..\)0\(.....\)/\11\2/; t step_`6'
    s/^\(..\)1\(.....\)/\10\2/; t step_`6'
    : step_`6'

    s/^\(.\)0\(......\)/\11\2/; t step_`7'
    s/^\(.\)1\(......\)/\10\2/; t step_`7'
    : step_`7'

    s/^0\(.......\)/1\1/; t step_`8'
    s/^1\(.......\)/0\1/; t step_`8'
    : step_`8'

    popdef(`step_')
')

define(`r_hex_inc', `
    # TODO
    # So the purpose of this is to use y// power to increment a hex digit
    # We use the hold buffer for this, but the thing is the hold buffer 
    # has the stdout buffer too. So! What we do is rotate the hold buffer
    # chars backwards first, then add our char, and rotate it forward again
    x
    y/0123456789ABCDEF/F0123456789ABCDE/
    H
    x
    y/0123456789ABCDEF/123456789ABCDEF0/
    

')

define(`r_inc', `
    r_clearBranchCache
    pushdef(`step_', r_anon)
    # Increment one bit at a time
    s/^\(.......\)0/0\11/; t step_`1'
    s/^\(.......\)1/1\10/; t step_`1'
    : step_`1'

    s/^0\(......\)0\(.\)/0\10\2/; t step_`2'
    s/^0\(......\)1\(.\)/0\11\2/; t step_`2'
    s/^1\(......\)0\(.\)/0\11\2/; t step_`2'
    s/^1\(......\)1\(.\)/1\10\2/; t step_`2'
    : step_`2'

    s/^0\(.....\)0\(..\)/0\10\2/; t step_`3'
    s/^0\(.....\)1\(..\)/0\11\2/; t step_`3'
    s/^1\(.....\)0\(..\)/0\11\2/; t step_`3'
    s/^1\(.....\)1\(..\)/1\10\2/; t step_`3'
    : step_`3'

    s/^0\(....\)0\(...\)/0\10\2/; t step_`4'
    s/^0\(....\)1\(...\)/0\11\2/; t step_`4'
    s/^1\(....\)0\(...\)/0\11\2/; t step_`4'
    s/^1\(....\)1\(...\)/1\10\2/; t step_`4'
    : step_`4'

    s/^0\(...\)0\(....\)/0\10\2/; t step_`5'
    s/^0\(...\)1\(....\)/0\11\2/; t step_`5'
    s/^1\(...\)0\(....\)/0\11\2/; t step_`5'
    s/^1\(...\)1\(....\)/1\10\2/; t step_`5'
    : step_`5'

    s/^0\(..\)0\(.....\)/0\10\2/; t step_`6'
    s/^0\(..\)1\(.....\)/0\11\2/; t step_`6'
    s/^1\(..\)0\(.....\)/0\11\2/; t step_`6'
    s/^1\(..\)1\(.....\)/1\10\2/; t step_`6'
    : step_`6'

    s/^0\(.\)0\(......\)/0\10\2/; t step_`7'
    s/^0\(.\)1\(......\)/0\11\2/; t step_`7'
    s/^1\(.\)0\(......\)/0\11\2/; t step_`7'
    s/^1\(.\)1\(......\)/1\10\2/; t step_`7'
    : step_`7'

    s/^00\(.......\)/0\1/; t step_`8'
    s/^01\(.......\)/1\1/; t step_`8'
    s/^10\(.......\)/1\1/; t step_`8'
    s/^11\(.......\)/0\1/; t step_`8'
    : step_`8'
    popdef(`step_')
')

define(`r_dec', `
    r_neg
    r_inc
    r_neg
')

define(`r_rshift', `s/^\([01]*\)[01]<>/0\1<>/')
define(`r_lshift', `s/^[01]\([01]*\)<>/\10<>/')

# 8-bit And
define(`r_bitand', `
    s/^/<>/
    r_clearBranchCache
    pushdef(`_i', 0)
    pushdef(`_lp', `
        pushdef(`_end', r_anon)
        # If the last two bits are both 1, prepend 1, else prepend 0
        s/^\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/1\1<>\2<>\3<>/;       t _end
        s/^\([01]*\)<>\([01]*\)[01]<>\([01]*\)[01]<>/0\1<>\2<>\3<>/; t _end
        : _end
        popdef(`_end')

        define(`_i', incr(_i))
        ifelse(_i, 8, , `_lp')
    ')
    _lp
    popdef(`_lp')
    popdef(`_i')
    s/[][][]/\1/
')

define(`r_bin2hex', `
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
')

define(`r_putc', `
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
    /^8/ b tmp_`8'
    /^9/ b tmp_`9'
    /^A/ b tmp_`A'
    /^B/ b tmp_`B'
    /^C/ b tmp_`C'
    /^D/ b tmp_`D'
    /^E/ b tmp_`E'
    /^F/ b tmp_`F'

    : tmp_`0'
    s/^00/?/; t tmp_`end'
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
    # Some versions of m4 take the next # to be a comment, so I split this
    # specific character cross multiple lines for macro expansion to work
    # for the label
    s/^23/#/
    t tmp_`end'
    s/^24/$/; t tmp_`end'
    s/^25/%/; t tmp_`end'
    s/^26/\&/; t tmp_`end'
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

    : tmp_`8'
    s/^80/r_ascii(0x80)/; t tmp_`end'
    s/^81/r_ascii(0x81)/; t tmp_`end'
    s/^82/r_ascii(0x82)/; t tmp_`end'
    s/^83/r_ascii(0x83)/; t tmp_`end'
    s/^84/r_ascii(0x84)/; t tmp_`end'
    s/^85/r_ascii(0x85)/; t tmp_`end'
    s/^86/r_ascii(0x86)/; t tmp_`end'
    s/^87/r_ascii(0x87)/; t tmp_`end'
    s/^88/r_ascii(0x88)/; t tmp_`end'
    s/^89/r_ascii(0x89)/; t tmp_`end'
    s/^8A/r_ascii(0x8A)/; t tmp_`end'
    s/^8B/r_ascii(0x8B)/; t tmp_`end'
    s/^8C/r_ascii(0x8C)/; t tmp_`end'
    s/^8D/r_ascii(0x8D)/; t tmp_`end'
    s/^8E/r_ascii(0x8E)/; t tmp_`end'
    s/^8F/r_ascii(0x8F)/; t tmp_`end'

    : tmp_`9'
    s/^90/r_ascii(0x90)/; t tmp_`end'
    s/^91/r_ascii(0x91)/; t tmp_`end'
    s/^92/r_ascii(0x92)/; t tmp_`end'
    s/^93/r_ascii(0x93)/; t tmp_`end'
    s/^94/r_ascii(0x94)/; t tmp_`end'
    s/^95/r_ascii(0x95)/; t tmp_`end'
    s/^96/r_ascii(0x96)/; t tmp_`end'
    s/^97/r_ascii(0x97)/; t tmp_`end'
    s/^98/r_ascii(0x98)/; t tmp_`end'
    s/^99/r_ascii(0x99)/; t tmp_`end'
    s/^9A/r_ascii(0x9A)/; t tmp_`end'
    s/^9B/r_ascii(0x9B)/; t tmp_`end'
    s/^9C/r_ascii(0x9C)/; t tmp_`end'
    s/^9D/r_ascii(0x9D)/; t tmp_`end'
    s/^9E/r_ascii(0x9E)/; t tmp_`end'
    s/^9F/r_ascii(0x9F)/; t tmp_`end'

    : tmp_`A'
    s/^A0/r_ascii(0xA0)/; t tmp_`end'
    s/^A1/r_ascii(0xA1)/; t tmp_`end'
    s/^A2/r_ascii(0xA2)/; t tmp_`end'
    s/^A3/r_ascii(0xA3)/; t tmp_`end'
    s/^A4/r_ascii(0xA4)/; t tmp_`end'
    s/^A5/r_ascii(0xA5)/; t tmp_`end'
    s/^A6/r_ascii(0xA6)/; t tmp_`end'
    s/^A7/r_ascii(0xA7)/; t tmp_`end'
    s/^A8/r_ascii(0xA8)/; t tmp_`end'
    s/^A9/r_ascii(0xA9)/; t tmp_`end'
    s/^AA/r_ascii(0xAA)/; t tmp_`end'
    s/^AB/r_ascii(0xAB)/; t tmp_`end'
    s/^AC/r_ascii(0xAC)/; t tmp_`end'
    s/^AD/r_ascii(0xAD)/; t tmp_`end'
    s/^AE/r_ascii(0xAE)/; t tmp_`end'
    s/^AF/r_ascii(0xAF)/; t tmp_`end'

    : tmp_`B'
    s/^B0/r_ascii(0xB0)/; t tmp_`end'
    s/^B1/r_ascii(0xB1)/; t tmp_`end'
    s/^B2/r_ascii(0xB2)/; t tmp_`end'
    s/^B3/r_ascii(0xB3)/; t tmp_`end'
    s/^B4/r_ascii(0xB4)/; t tmp_`end'
    s/^B5/r_ascii(0xB5)/; t tmp_`end'
    s/^B6/r_ascii(0xB6)/; t tmp_`end'
    s/^B7/r_ascii(0xB7)/; t tmp_`end'
    s/^B8/r_ascii(0xB8)/; t tmp_`end'
    s/^B9/r_ascii(0xB9)/; t tmp_`end'
    s/^BA/r_ascii(0xBA)/; t tmp_`end'
    s/^BB/r_ascii(0xBB)/; t tmp_`end'
    s/^BC/r_ascii(0xBC)/; t tmp_`end'
    s/^BD/r_ascii(0xBD)/; t tmp_`end'
    s/^BE/r_ascii(0xBE)/; t tmp_`end'
    s/^BF/r_ascii(0xBF)/; t tmp_`end'

    : tmp_`C'
    s/^C0/r_ascii(0xC0)/; t tmp_`end'
    s/^C1/r_ascii(0xC1)/; t tmp_`end'
    s/^C2/r_ascii(0xC2)/; t tmp_`end'
    s/^C3/r_ascii(0xC3)/; t tmp_`end'
    s/^C4/r_ascii(0xC4)/; t tmp_`end'
    s/^C5/r_ascii(0xC5)/; t tmp_`end'
    s/^C6/r_ascii(0xC6)/; t tmp_`end'
    s/^C7/r_ascii(0xC7)/; t tmp_`end'
    s/^C8/r_ascii(0xC8)/; t tmp_`end'
    s/^C9/r_ascii(0xC9)/; t tmp_`end'
    s/^CA/r_ascii(0xCA)/; t tmp_`end'
    s/^CB/r_ascii(0xCB)/; t tmp_`end'
    s/^CC/r_ascii(0xCC)/; t tmp_`end'
    s/^CD/r_ascii(0xCD)/; t tmp_`end'
    s/^CE/r_ascii(0xCE)/; t tmp_`end'
    s/^CF/r_ascii(0xCF)/; t tmp_`end'

    : tmp_`D'
    s/^D0/r_ascii(0xD0)/; t tmp_`end'
    s/^D1/r_ascii(0xD1)/; t tmp_`end'
    s/^D2/r_ascii(0xD2)/; t tmp_`end'
    s/^D3/r_ascii(0xD3)/; t tmp_`end'
    s/^D4/r_ascii(0xD4)/; t tmp_`end'
    s/^D5/r_ascii(0xD5)/; t tmp_`end'
    s/^D6/r_ascii(0xD6)/; t tmp_`end'
    s/^D7/r_ascii(0xD7)/; t tmp_`end'
    s/^D8/r_ascii(0xD8)/; t tmp_`end'
    s/^D9/r_ascii(0xD9)/; t tmp_`end'
    s/^DA/r_ascii(0xDA)/; t tmp_`end'
    s/^DB/r_ascii(0xDB)/; t tmp_`end'
    s/^DC/r_ascii(0xDC)/; t tmp_`end'
    s/^DD/r_ascii(0xDD)/; t tmp_`end'
    s/^DE/r_ascii(0xDE)/; t tmp_`end'
    s/^DF/r_ascii(0xDF)/; t tmp_`end'

    : tmp_`E'
    s/^E0/r_ascii(0xE0)/; t tmp_`end'
    s/^E1/r_ascii(0xE1)/; t tmp_`end'
    s/^E2/r_ascii(0xE2)/; t tmp_`end'
    s/^E3/r_ascii(0xE3)/; t tmp_`end'
    s/^E4/r_ascii(0xE4)/; t tmp_`end'
    s/^E5/r_ascii(0xE5)/; t tmp_`end'
    s/^E6/r_ascii(0xE6)/; t tmp_`end'
    s/^E7/r_ascii(0xE7)/; t tmp_`end'
    s/^E8/r_ascii(0xE8)/; t tmp_`end'
    s/^E9/r_ascii(0xE9)/; t tmp_`end'
    s/^EA/r_ascii(0xEA)/; t tmp_`end'
    s/^EB/r_ascii(0xEB)/; t tmp_`end'
    s/^EC/r_ascii(0xEC)/; t tmp_`end'
    s/^ED/r_ascii(0xED)/; t tmp_`end'
    s/^EE/r_ascii(0xEE)/; t tmp_`end'
    s/^EF/r_ascii(0xEF)/; t tmp_`end'

    : tmp_`F'
    s/^F0/r_ascii(0xF0)/; t tmp_`end'
    s/^F1/r_ascii(0xF1)/; t tmp_`end'
    s/^F2/r_ascii(0xF2)/; t tmp_`end'
    s/^F3/r_ascii(0xF3)/; t tmp_`end'
    s/^F4/r_ascii(0xF4)/; t tmp_`end'
    s/^F5/r_ascii(0xF5)/; t tmp_`end'
    s/^F6/r_ascii(0xF6)/; t tmp_`end'
    s/^F7/r_ascii(0xF7)/; t tmp_`end'
    s/^F8/r_ascii(0xF8)/; t tmp_`end'
    s/^F9/r_ascii(0xF9)/; t tmp_`end'
    s/^FA/r_ascii(0xFA)/; t tmp_`end'
    s/^FB/r_ascii(0xFB)/; t tmp_`end'
    s/^FC/r_ascii(0xFC)/; t tmp_`end'
    s/^FD/r_ascii(0xFD)/; t tmp_`end'
    s/^FE/r_ascii(0xFE)/; t tmp_`end'
    s/^FF/r_ascii(0xFF)/; t tmp_`end'

    : tmp_`end'

    H   # Copy data buffer to stdout buffer
    x   # Switch to stdout buffer

    s/\n\(.\)<>[^\n]*$/\1/
    /\n$/ {
        s/\n$//
        P
        s/^.*$//
    }
    s/\n//g
    x
    s/.<>//
    popdef(`tmp_')
')


# TODO why does this break when we use define instead of func
r_func(`getln')
    # Insert the newline in advance so we dont have to do it later
    r_pushnum(0x0A)

    x   # Switch to stdout buffer
    N   # Read a line of input
    G   # Append data buffer
    h   # Copy over data buffer
    s/^\([^\n]*\)\n//           # Remove leading stdout buffer
                                  # Pattern space is input\ndata
    x   # Over to new stdout buffer
    s/^\([^\n]*\)\n.*$/\1/        # Remove everything after the stdout buffer
    x   # Back to data buffer

    #
    # Convert all characters up to the newline to binary
    pushdef(`_end', r_anon)
    pushdef(`tmp_', r_anon)


    # It should be possible to optimize this I think but idk
    : tmp_`loopStart'
    pushdef(`_charVal', `1')
    pushdef(`_lp', `
        ifelse(_charVal, eval(0x0a), ,                                  `# Dont match newlines, there wont be any
        ifelse(_charVal, eval(0x23), `s/`#'\n/\n00100011<>/; t _end',            `# M4 Comment character
        ifelse(_charVal, eval(0x27), `s/RQ()\n/\`n's_binary(0x27)<>/; t _end', `# Right quote
        ifelse(_charVal, eval(0x24), `s/\$\n/\`n's_binary(0x24)<>/; t _end',   `# End of line
        ifelse(_charVal, eval(0x2A), `s/\*\n/\`n's_binary(0x2A)<>/; t _end',   `# Start
        ifelse(_charVal, eval(0x2E), `s/\.\n/\`n's_binary(0x2E)<>/; t _end',   `# Dot
        ifelse(_charVal, eval(0x2F), `s/\/\n/\`n's_binary(0x2F)<>/; t _end',   `# Forward slash
        ifelse(_charVal, eval(0x3F), `s/\?\n/\`n's_binary(0x3F)<>/; t _end',   `# Question mark
        ifelse(_charVal, eval(0x5B), `s/\[\n/\`n's_binary(0x5B)<>/; t _end',   `# Capture group
        ifelse(_charVal, eval(0x5C), `s/\\\n/\`n's_binary(0x5C)<>/; t _end',   `# Backslash
        ifelse(_charVal, eval(0x5E), `s/\^\n/\`n's_binary(0x5E)<>/; t _end',   `# Regex start char
        ifelse(_charVal, eval(0x60), `s/LQ()\n/\`n's_binary(0x60)<>/; t _end', `# Left quote
            s/r_ascii(_charVal)\n/\`n's_binary(_charVal)<>/
            t _end
        ')
        ')
        ')
        ')
        ')
        ')
        ')
        ')
        ')
        ')
        ')
        ')

        define(`_charVal', incr(_charVal))
        ifelse(_charVal, 255, , `_lp')
    ')
    _lp
    : _end
    # If the first char is not \n, we have more chars to process
    /^[^\n]/ b tmp_`loopStart'
    # Otherwise, we're done
    popdef(`_lp')
    popdef(`_charVal')
    popdef(`_end')

    s/^\n//

r_endfunc

# Assuming the top of the stack is the head of the stdin buffer, read a value
# out of it, or get a new string if needed
define(`r_getc', `
    # Null byte terminating string, so need to read a new one
    /^00000000<>/ {
        r_getln
    }
    # Next char is on the stack now yay
')

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
define(`r_bf_xin', `
    # Stack state at the start of this:
    # <instr> <stdin_buffer>
    # In the future the instr maybe wont be there, but in the mean time
    # since its constant we can just drop it and then put it back
    r_drop
    r_getc
    r_bf_mset
    r_pushstr(`5')
')

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
    # All other lines are stdin
    # Delete irrelevant characters
    # Order is inconsistent because sed is weird
    s/[^][><+.,-]//g

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
    
    # Add tape memory after code (1 byte initial, dynamically grows)
    s/$/###@@@@@@@@00000000/

    # Add the stdin buffer nullbyte
    r_pushnum(0x00)

    # Main execution cycle
    : main_loop_start
        r_bf_iget
        /^0/ { 
            r_bf_xptrr
        }
        /^1/ { 
            r_bf_xptrl
        }
        /^2/ { 
            r_bf_xinc
        }
        /^3/ { 
            r_bf_xdec
        }
        /^4/ { 
            r_bf_xout
        }
        /^5/ { 
            r_bf_xin
        }
        /^6/ { 
            r_bf_xblkstart
        }
        /^7/ { 
            r_bf_xblkend
        }
        /^8/ {
            b prog_end
        }
        : main_loop_end
        r_drop
        r_bf_irotl
    b main_loop_start

    : prog_end
    q

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
    q

