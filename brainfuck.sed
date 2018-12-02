# Branch to the entry point
# Main is at the end of the file so it can make use of the m4 macros.
b main
# Push a string constant to the stack
# In practice this rarely gets used
# Push a numeric constant to the stack as an 8-bit integer
# This index is used for generating sequential labels for function returns
# Call convention is to push the return address to the end of the stack
# Ret:     [r x] -> [x] (return to r)
# Drop:    a b -> b
# Swap:    a b -> b a
# Rot: a b c -> b c a
# Dup: a -> a a
# 2dup: a b -> a b a b
# 2drop: a b c -> c
# 8 bit binary add
# X Y -> X+Y
    : func_r_add
    # Ripply-carry adder
    # Insert beginning carry bit
    s/^/0<>/
    s/$//; t anon_000001
    : anon_000001
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/00\1<>\2<>\3<>/; t anon_000002
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000002
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/01\1<>\2<>\3<>/; t anon_000002
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000002
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000002
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/10\1<>\2<>\3<>/; t anon_000002
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000002
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/11\1<>\2<>\3<>/; t anon_000002
        : anon_000002
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/00\1<>\2<>\3<>/; t anon_000003
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000003
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/01\1<>\2<>\3<>/; t anon_000003
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000003
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000003
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/10\1<>\2<>\3<>/; t anon_000003
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000003
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/11\1<>\2<>\3<>/; t anon_000003
        : anon_000003
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/00\1<>\2<>\3<>/; t anon_000004
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000004
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/01\1<>\2<>\3<>/; t anon_000004
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000004
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000004
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/10\1<>\2<>\3<>/; t anon_000004
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000004
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/11\1<>\2<>\3<>/; t anon_000004
        : anon_000004
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/00\1<>\2<>\3<>/; t anon_000005
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000005
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/01\1<>\2<>\3<>/; t anon_000005
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000005
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000005
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/10\1<>\2<>\3<>/; t anon_000005
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000005
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/11\1<>\2<>\3<>/; t anon_000005
        : anon_000005
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/00\1<>\2<>\3<>/; t anon_000006
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000006
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/01\1<>\2<>\3<>/; t anon_000006
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000006
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000006
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/10\1<>\2<>\3<>/; t anon_000006
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000006
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/11\1<>\2<>\3<>/; t anon_000006
        : anon_000006
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/00\1<>\2<>\3<>/; t anon_000007
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000007
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/01\1<>\2<>\3<>/; t anon_000007
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000007
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000007
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/10\1<>\2<>\3<>/; t anon_000007
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000007
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/11\1<>\2<>\3<>/; t anon_000007
        : anon_000007
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/00\1<>\2<>\3<>/; t anon_000008
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000008
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/01\1<>\2<>\3<>/; t anon_000008
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000008
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000008
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/10\1<>\2<>\3<>/; t anon_000008
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000008
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/11\1<>\2<>\3<>/; t anon_000008
        : anon_000008
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/00\1<>\2<>\3<>/; t anon_000009
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000009
        s/^0\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/01\1<>\2<>\3<>/; t anon_000009
        s/^0\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000009
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)0<>/01\1<>\2<>\3<>/; t anon_000009
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)0<>/10\1<>\2<>\3<>/; t anon_000009
        s/^1\([01]*\)<>\([01]*\)0<>\([01]*\)1<>/10\1<>\2<>\3<>/; t anon_000009
        s/^1\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/11\1<>\2<>\3<>/; t anon_000009
        : anon_000009
    # Remove carry bit and X/Y args
    s/^[01]\([01]*\)<>[01]*<>[01]*<>/\1<>/
b dynamicDispatch
# Negate 8-bit number
# [X Y] -> [X<=Y]
# 8-bit And
    : func_r_bitand
    s/^/<>/
    s/$//; t anon_000010
    : anon_000010
        # If the last two bits are both 1, prepend 1, else prepend 0
        s/^\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/1\1<>\2<>\3<>/;       t anon_000011
        s/^\([01]*\)<>\([01]*\)[01]<>\([01]*\)[01]<>/0\1<>\2<>\3<>/; t anon_000011
        : anon_000011
        # If the last two bits are both 1, prepend 1, else prepend 0
        s/^\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/1\1<>\2<>\3<>/;       t anon_000012
        s/^\([01]*\)<>\([01]*\)[01]<>\([01]*\)[01]<>/0\1<>\2<>\3<>/; t anon_000012
        : anon_000012
        # If the last two bits are both 1, prepend 1, else prepend 0
        s/^\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/1\1<>\2<>\3<>/;       t anon_000013
        s/^\([01]*\)<>\([01]*\)[01]<>\([01]*\)[01]<>/0\1<>\2<>\3<>/; t anon_000013
        : anon_000013
        # If the last two bits are both 1, prepend 1, else prepend 0
        s/^\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/1\1<>\2<>\3<>/;       t anon_000014
        s/^\([01]*\)<>\([01]*\)[01]<>\([01]*\)[01]<>/0\1<>\2<>\3<>/; t anon_000014
        : anon_000014
        # If the last two bits are both 1, prepend 1, else prepend 0
        s/^\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/1\1<>\2<>\3<>/;       t anon_000015
        s/^\([01]*\)<>\([01]*\)[01]<>\([01]*\)[01]<>/0\1<>\2<>\3<>/; t anon_000015
        : anon_000015
        # If the last two bits are both 1, prepend 1, else prepend 0
        s/^\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/1\1<>\2<>\3<>/;       t anon_000016
        s/^\([01]*\)<>\([01]*\)[01]<>\([01]*\)[01]<>/0\1<>\2<>\3<>/; t anon_000016
        : anon_000016
        # If the last two bits are both 1, prepend 1, else prepend 0
        s/^\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/1\1<>\2<>\3<>/;       t anon_000017
        s/^\([01]*\)<>\([01]*\)[01]<>\([01]*\)[01]<>/0\1<>\2<>\3<>/; t anon_000017
        : anon_000017
        # If the last two bits are both 1, prepend 1, else prepend 0
        s/^\([01]*\)<>\([01]*\)1<>\([01]*\)1<>/1\1<>\2<>\3<>/;       t anon_000018
        s/^\([01]*\)<>\([01]*\)[01]<>\([01]*\)[01]<>/0\1<>\2<>\3<>/; t anon_000018
        : anon_000018
    s/\([^<>]*<>\)\([^<>]*<>\)\([^<>]*<>\)/\1/
b dynamicDispatch
    : func_r_bin2hex
    s/^\([^<>]*<>\)/\1\1/
    s/^/00001111<>/
    s/|||/000001<>|||/
    b func_r_bitand
    : dynamic_000001
    s/^0000//
    s/$//; t anon_000019
    : anon_000019
    s/^0000<>/0<>/; t anon_000020
    s/^0001<>/1<>/; t anon_000020
    s/^0010<>/2<>/; t anon_000020
    s/^0011<>/3<>/; t anon_000020
    s/^0100<>/4<>/; t anon_000020
    s/^0101<>/5<>/; t anon_000020
    s/^0110<>/6<>/; t anon_000020
    s/^0111<>/7<>/; t anon_000020
    s/^1000<>/8<>/; t anon_000020
    s/^1001<>/9<>/; t anon_000020
    s/^1010<>/A<>/; t anon_000020
    s/^1011<>/B<>/; t anon_000020
    s/^1100<>/C<>/; t anon_000020
    s/^1101<>/D<>/; t anon_000020
    s/^1110<>/E<>/; t anon_000020
    s/^1111<>/F<>/; t anon_000020
    : anon_000020
    s/^\([^<>]*<>\)\([^<>]*<>\)/\2\1/
    s/^\([01]*\)[01]<>/0\1<>/
    s/^\([01]*\)[01]<>/0\1<>/
    s/^\([01]*\)[01]<>/0\1<>/
    s/^\([01]*\)[01]<>/0\1<>/
    s/^/00001111<>/
    s/|||/000002<>|||/
    b func_r_bitand
    : dynamic_000002
    s/^0000//
    s/$//; t anon_000021
    : anon_000021
    s/^0000<>/0/; t anon_000022
    s/^0001<>/1/; t anon_000022
    s/^0010<>/2/; t anon_000022
    s/^0011<>/3/; t anon_000022
    s/^0100<>/4/; t anon_000022
    s/^0101<>/5/; t anon_000022
    s/^0110<>/6/; t anon_000022
    s/^0111<>/7/; t anon_000022
    s/^1000<>/8/; t anon_000022
    s/^1001<>/9/; t anon_000022
    s/^1010<>/A/; t anon_000022
    s/^1011<>/B/; t anon_000022
    s/^1100<>/C/; t anon_000022
    s/^1101<>/D/; t anon_000022
    s/^1110<>/E/; t anon_000022
    s/^1111<>/F/; t anon_000022
    : anon_000022
    s/^\([0-9A-F]\)<>\([0-9A-F]\)<>/\2\1<>/
b dynamicDispatch
    : func_r_putc
    s/|||/000003<>|||/
    b func_r_bin2hex
    : dynamic_000003
    s/$//; t anon_000023
    : anon_000023
    /^0/ b anon_0000240
    /^1/ b anon_0000241
    /^2/ b anon_0000242
    /^3/ b anon_0000243
    /^4/ b anon_0000244
    /^5/ b anon_0000245
    /^6/ b anon_0000246
    /^7/ b anon_0000247
    /^8/ b anon_0000248
    /^9/ b anon_0000249
    /^A/ b anon_000024A
    /^B/ b anon_000024B
    /^C/ b anon_000024C
    /^D/ b anon_000024D
    /^E/ b anon_000024E
    /^F/ b anon_000024F
    : anon_0000240
    s/^01//; t anon_000024end
    s/^02//; t anon_000024end
    s/^03//; t anon_000024end
    s/^04//; t anon_000024end
    s/^05//; t anon_000024end
    s/^06//; t anon_000024end
    s/^07//; t anon_000024end
    s/^08//; t anon_000024end
    s/^09/	/; t anon_000024end
    s/^0A/\n/; t anon_000024end
    s/^0B//; t anon_000024end
    s/^0C//; t anon_000024end
    s/^0D//; t anon_000024end
    s/^0E//; t anon_000024end
    s/^0F//; t anon_000024end
    : anon_0000241
    s/^11//; t anon_000024end
    s/^12//; t anon_000024end
    s/^13//; t anon_000024end
    s/^14//; t anon_000024end
    s/^15//; t anon_000024end
    s/^16//; t anon_000024end
    s/^17//; t anon_000024end
    s/^18//; t anon_000024end
    s/^19//; t anon_000024end
    s/^1A//; t anon_000024end
    s/^1B//; t anon_000024end
    s/^1C//; t anon_000024end
    s/^1D//; t anon_000024end
    s/^1E//; t anon_000024end
    s/^1F//; t anon_000024end
    : anon_0000242
    s/^20/ /; t anon_000024end
    s/^21/!/; t anon_000024end
    s/^22/"/; t anon_000024end
    # Some versions of m4 take the next # to be a comment, so I split this
    # specific character cross multiple lines for macro expansion to work
    # for the label
    s/^23/#/
    t anon_000024end
    s/^24/$/; t anon_000024end
    s/^25/%/; t anon_000024end
    s/^26/\&/; t anon_000024end
    s/^27/'/; t anon_000024end
    s/^28/(/; t anon_000024end
    s/^29/)/; t anon_000024end
    s/^2A/*/; t anon_000024end
    s/^2B/+/; t anon_000024end
    s/^2C/,/; t anon_000024end
    s/^2D/-/; t anon_000024end
    s/^2E/./; t anon_000024end
    s/^2F/\//; t anon_000024end
    : anon_0000243
    s/^30/0/; t anon_000024end
    s/^31/1/; t anon_000024end
    s/^32/2/; t anon_000024end
    s/^33/3/; t anon_000024end
    s/^34/4/; t anon_000024end
    s/^35/5/; t anon_000024end
    s/^36/6/; t anon_000024end
    s/^37/7/; t anon_000024end
    s/^38/8/; t anon_000024end
    s/^39/9/; t anon_000024end
    s/^3A/:/; t anon_000024end
    s/^3B/;/; t anon_000024end
    s/^3C/</; t anon_000024end
    s/^3D/=/; t anon_000024end
    s/^3E/>/; t anon_000024end
    s/^3F/?/; t anon_000024end
    : anon_0000244
    s/^40/@/; t anon_000024end
    s/^41/A/; t anon_000024end
    s/^42/B/; t anon_000024end
    s/^43/C/; t anon_000024end
    s/^44/D/; t anon_000024end
    s/^45/E/; t anon_000024end
    s/^46/F/; t anon_000024end
    s/^47/G/; t anon_000024end
    s/^48/H/; t anon_000024end
    s/^49/I/; t anon_000024end
    s/^4A/J/; t anon_000024end
    s/^4B/K/; t anon_000024end
    s/^4C/L/; t anon_000024end
    s/^4D/M/; t anon_000024end
    s/^4E/N/; t anon_000024end
    s/^4F/O/; t anon_000024end
    : anon_0000245
    s/^50/P/; t anon_000024end
    s/^51/Q/; t anon_000024end
    s/^52/R/; t anon_000024end
    s/^53/S/; t anon_000024end
    s/^54/T/; t anon_000024end
    s/^55/U/; t anon_000024end
    s/^56/V/; t anon_000024end
    s/^57/W/; t anon_000024end
    s/^58/X/; t anon_000024end
    s/^59/Y/; t anon_000024end
    s/^5A/Z/; t anon_000024end
    s/^5B/[/; t anon_000024end
    s/^5C/\\/; t anon_000024end
    s/^5D/]/; t anon_000024end
    s/^5E/^/; t anon_000024end
    s/^5F/_/; t anon_000024end
    : anon_0000246
    s/^60/`/; t anon_000024end
    s/^61/a/; t anon_000024end
    s/^62/b/; t anon_000024end
    s/^63/c/; t anon_000024end
    s/^64/d/; t anon_000024end
    s/^65/e/; t anon_000024end
    s/^66/f/; t anon_000024end
    s/^67/g/; t anon_000024end
    s/^68/h/; t anon_000024end
    s/^69/i/; t anon_000024end
    s/^6A/j/; t anon_000024end
    s/^6B/k/; t anon_000024end
    s/^6C/l/; t anon_000024end
    s/^6D/m/; t anon_000024end
    s/^6E/n/; t anon_000024end
    s/^6F/o/; t anon_000024end
    : anon_0000247
    s/^70/p/; t anon_000024end
    s/^71/q/; t anon_000024end
    s/^72/r/; t anon_000024end
    s/^73/s/; t anon_000024end
    s/^74/t/; t anon_000024end
    s/^75/u/; t anon_000024end
    s/^76/v/; t anon_000024end
    s/^77/w/; t anon_000024end
    s/^78/x/; t anon_000024end
    s/^79/y/; t anon_000024end
    s/^7A/z/; t anon_000024end
    s/^7B/{/; t anon_000024end
    s/^7C/|/; t anon_000024end
    s/^7D/}/; t anon_000024end
    s/^7E/~/; t anon_000024end
    s/^7F//; t anon_000024end
    : anon_0000248
    s/^80/Ä/; t anon_000024end
    s/^81/Å/; t anon_000024end
    s/^82/Ç/; t anon_000024end
    s/^83/É/; t anon_000024end
    s/^84/Ñ/; t anon_000024end
    s/^85/Ö/; t anon_000024end
    s/^86/Ü/; t anon_000024end
    s/^87/á/; t anon_000024end
    s/^88/à/; t anon_000024end
    s/^89/â/; t anon_000024end
    s/^8A/ä/; t anon_000024end
    s/^8B/ã/; t anon_000024end
    s/^8C/å/; t anon_000024end
    s/^8D/ç/; t anon_000024end
    s/^8E/é/; t anon_000024end
    s/^8F/è/; t anon_000024end
    : anon_0000249
    s/^90/ê/; t anon_000024end
    s/^91/ë/; t anon_000024end
    s/^92/í/; t anon_000024end
    s/^93/ì/; t anon_000024end
    s/^94/î/; t anon_000024end
    s/^95/ï/; t anon_000024end
    s/^96/ñ/; t anon_000024end
    s/^97/ó/; t anon_000024end
    s/^98/ò/; t anon_000024end
    s/^99/ô/; t anon_000024end
    s/^9A/ö/; t anon_000024end
    s/^9B/õ/; t anon_000024end
    s/^9C/ú/; t anon_000024end
    s/^9D/ù/; t anon_000024end
    s/^9E/û/; t anon_000024end
    s/^9F/ü/; t anon_000024end
    : anon_000024A
    s/^A0/†/; t anon_000024end
    s/^A1/°/; t anon_000024end
    s/^A2/¢/; t anon_000024end
    s/^A3/£/; t anon_000024end
    s/^A4/§/; t anon_000024end
    s/^A5/•/; t anon_000024end
    s/^A6/¶/; t anon_000024end
    s/^A7/ß/; t anon_000024end
    s/^A8/®/; t anon_000024end
    s/^A9/©/; t anon_000024end
    s/^AA/™/; t anon_000024end
    s/^AB/´/; t anon_000024end
    s/^AC/¨/; t anon_000024end
    s/^AD/≠/; t anon_000024end
    s/^AE/Æ/; t anon_000024end
    s/^AF/Ø/; t anon_000024end
    : anon_000024B
    s/^B0/∞/; t anon_000024end
    s/^B1/±/; t anon_000024end
    s/^B2/≤/; t anon_000024end
    s/^B3/≥/; t anon_000024end
    s/^B4/¥/; t anon_000024end
    s/^B5/µ/; t anon_000024end
    s/^B6/∂/; t anon_000024end
    s/^B7/∑/; t anon_000024end
    s/^B8/∏/; t anon_000024end
    s/^B9/π/; t anon_000024end
    s/^BA/∫/; t anon_000024end
    s/^BB/ª/; t anon_000024end
    s/^BC/º/; t anon_000024end
    s/^BD/Ω/; t anon_000024end
    s/^BE/æ/; t anon_000024end
    s/^BF/ø/; t anon_000024end
    : anon_000024C
    s/^C0/¿/; t anon_000024end
    s/^C1/¡/; t anon_000024end
    s/^C2/¬/; t anon_000024end
    s/^C3/√/; t anon_000024end
    s/^C4/ƒ/; t anon_000024end
    s/^C5/≈/; t anon_000024end
    s/^C6/∆/; t anon_000024end
    s/^C7/«/; t anon_000024end
    s/^C8/»/; t anon_000024end
    s/^C9/…/; t anon_000024end
    s/^CA/ /; t anon_000024end
    s/^CB/À/; t anon_000024end
    s/^CC/Ã/; t anon_000024end
    s/^CD/Õ/; t anon_000024end
    s/^CE/Œ/; t anon_000024end
    s/^CF/œ/; t anon_000024end
    : anon_000024D
    s/^D0/–/; t anon_000024end
    s/^D1/—/; t anon_000024end
    s/^D2/“/; t anon_000024end
    s/^D3/”/; t anon_000024end
    s/^D4/‘/; t anon_000024end
    s/^D5/’/; t anon_000024end
    s/^D6/÷/; t anon_000024end
    s/^D7/◊/; t anon_000024end
    s/^D8/ÿ/; t anon_000024end
    s/^D9/Ÿ/; t anon_000024end
    s/^DA/⁄/; t anon_000024end
    s/^DB/€/; t anon_000024end
    s/^DC/‹/; t anon_000024end
    s/^DD/›/; t anon_000024end
    s/^DE/ﬁ/; t anon_000024end
    s/^DF/ﬂ/; t anon_000024end
    : anon_000024E
    s/^E0/‡/; t anon_000024end
    s/^E1/·/; t anon_000024end
    s/^E2/‚/; t anon_000024end
    s/^E3/„/; t anon_000024end
    s/^E4/‰/; t anon_000024end
    s/^E5/Â/; t anon_000024end
    s/^E6/Ê/; t anon_000024end
    s/^E7/Á/; t anon_000024end
    s/^E8/Ë/; t anon_000024end
    s/^E9/È/; t anon_000024end
    s/^EA/Í/; t anon_000024end
    s/^EB/Î/; t anon_000024end
    s/^EC/Ï/; t anon_000024end
    s/^ED/Ì/; t anon_000024end
    s/^EE/Ó/; t anon_000024end
    s/^EF/Ô/; t anon_000024end
    : anon_000024F
    s/^F0//; t anon_000024end
    s/^F1/Ò/; t anon_000024end
    s/^F2/Ú/; t anon_000024end
    s/^F3/Û/; t anon_000024end
    s/^F4/Ù/; t anon_000024end
    s/^F5/ı/; t anon_000024end
    s/^F6/ˆ/; t anon_000024end
    s/^F7/˜/; t anon_000024end
    s/^F8/¯/; t anon_000024end
    s/^F9/˘/; t anon_000024end
    s/^FA/˙/; t anon_000024end
    s/^FB/˚/; t anon_000024end
    s/^FC/¸/; t anon_000024end
    s/^FD/˝/; t anon_000024end
    s/^FE/˛/; t anon_000024end
    s/^FF/ˇ/; t anon_000024end
    : anon_000024end
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
b dynamicDispatch
    : func_r_getln
    # Insert the newline in advance so we dont have to do it later
    s/^/00001010<>/
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
    : anon_000026loopStart
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00000001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00000010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00000011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00000100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00000101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00000110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00000111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00001000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/	\n/\n00001001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00001011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00001100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00001101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00001110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00001111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00010000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00010001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00010010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00010011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00010100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00010101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00010110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00010111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00011000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00011001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00011010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00011011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00011100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00011101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00011110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n00011111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ \n/\n00100000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/!\n/\n00100001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/"\n/\n00100010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        s/#\n/\n00100011<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        s/\$\n/\n00100100<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/%\n/\n00100101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/&\n/\n00100110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        s/'\n/\n00100111<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/(\n/\n00101000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/)\n/\n00101001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        s/\*\n/\n00101010<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/+\n/\n00101011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/,\n/\n00101100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/-\n/\n00101101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        s/\.\n/\n00101110<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        s/\/\n/\n00101111<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/0\n/\n00110000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/1\n/\n00110001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/2\n/\n00110010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/3\n/\n00110011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/4\n/\n00110100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/5\n/\n00110101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/6\n/\n00110110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/7\n/\n00110111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/8\n/\n00111000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/9\n/\n00111001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/:\n/\n00111010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/;\n/\n00111011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/<\n/\n00111100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/=\n/\n00111101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/>\n/\n00111110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        s/\*\n/\n00111111<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/@\n/\n01000000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/A\n/\n01000001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/B\n/\n01000010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/C\n/\n01000011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/D\n/\n01000100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/E\n/\n01000101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/F\n/\n01000110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/G\n/\n01000111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/H\n/\n01001000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/I\n/\n01001001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/J\n/\n01001010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/K\n/\n01001011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/L\n/\n01001100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/M\n/\n01001101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/N\n/\n01001110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/O\n/\n01001111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/P\n/\n01010000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Q\n/\n01010001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/R\n/\n01010010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/S\n/\n01010011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/T\n/\n01010100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/U\n/\n01010101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/V\n/\n01010110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/W\n/\n01010111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/X\n/\n01011000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Y\n/\n01011001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Z\n/\n01011010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        s/\[\n/\n01011011<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        s/\\\n/\n01011100<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/]\n/\n01011101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        s/\^\n/\n01011110<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/_\n/\n01011111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        s/`\n/\n01100000<>/; t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/a\n/\n01100001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/b\n/\n01100010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/c\n/\n01100011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/d\n/\n01100100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/e\n/\n01100101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/f\n/\n01100110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/g\n/\n01100111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/h\n/\n01101000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/i\n/\n01101001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/j\n/\n01101010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/k\n/\n01101011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/l\n/\n01101100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/m\n/\n01101101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/n\n/\n01101110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/o\n/\n01101111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/p\n/\n01110000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/q\n/\n01110001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/r\n/\n01110010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/s\n/\n01110011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/t\n/\n01110100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/u\n/\n01110101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/v\n/\n01110110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/w\n/\n01110111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/x\n/\n01111000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/y\n/\n01111001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/z\n/\n01111010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/{\n/\n01111011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/|\n/\n01111100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/}\n/\n01111101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/~\n/\n01111110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n01111111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ä\n/\n10000000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Å\n/\n10000001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ç\n/\n10000010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/É\n/\n10000011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ñ\n/\n10000100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ö\n/\n10000101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ü\n/\n10000110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/á\n/\n10000111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/à\n/\n10001000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/â\n/\n10001001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ä\n/\n10001010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ã\n/\n10001011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/å\n/\n10001100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ç\n/\n10001101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/é\n/\n10001110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/è\n/\n10001111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ê\n/\n10010000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ë\n/\n10010001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/í\n/\n10010010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ì\n/\n10010011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/î\n/\n10010100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ï\n/\n10010101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ñ\n/\n10010110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ó\n/\n10010111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ò\n/\n10011000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ô\n/\n10011001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ö\n/\n10011010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/õ\n/\n10011011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ú\n/\n10011100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ù\n/\n10011101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/û\n/\n10011110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ü\n/\n10011111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/†\n/\n10100000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/°\n/\n10100001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/¢\n/\n10100010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/£\n/\n10100011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/§\n/\n10100100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/•\n/\n10100101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/¶\n/\n10100110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ß\n/\n10100111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/®\n/\n10101000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/©\n/\n10101001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/™\n/\n10101010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/´\n/\n10101011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/¨\n/\n10101100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/≠\n/\n10101101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Æ\n/\n10101110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ø\n/\n10101111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/∞\n/\n10110000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/±\n/\n10110001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/≤\n/\n10110010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/≥\n/\n10110011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/¥\n/\n10110100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/µ\n/\n10110101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/∂\n/\n10110110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/∑\n/\n10110111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/∏\n/\n10111000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/π\n/\n10111001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/∫\n/\n10111010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ª\n/\n10111011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/º\n/\n10111100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ω\n/\n10111101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/æ\n/\n10111110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ø\n/\n10111111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/¿\n/\n11000000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/¡\n/\n11000001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/¬\n/\n11000010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/√\n/\n11000011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ƒ\n/\n11000100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/≈\n/\n11000101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/∆\n/\n11000110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/«\n/\n11000111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/»\n/\n11001000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/…\n/\n11001001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ \n/\n11001010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/À\n/\n11001011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ã\n/\n11001100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Õ\n/\n11001101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Œ\n/\n11001110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/œ\n/\n11001111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/–\n/\n11010000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/—\n/\n11010001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/“\n/\n11010010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/”\n/\n11010011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/‘\n/\n11010100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/’\n/\n11010101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/÷\n/\n11010110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/◊\n/\n11010111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ÿ\n/\n11011000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ÿ\n/\n11011001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/⁄\n/\n11011010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/€\n/\n11011011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/‹\n/\n11011100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/›\n/\n11011101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ﬁ\n/\n11011110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ﬂ\n/\n11011111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/‡\n/\n11100000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/·\n/\n11100001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/‚\n/\n11100010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/„\n/\n11100011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/‰\n/\n11100100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Â\n/\n11100101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ê\n/\n11100110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Á\n/\n11100111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ë\n/\n11101000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/È\n/\n11101001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Í\n/\n11101010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Î\n/\n11101011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ï\n/\n11101100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ì\n/\n11101101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ó\n/\n11101110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ô\n/\n11101111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/\n/\n11110000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ò\n/\n11110001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ú\n/\n11110010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Û\n/\n11110011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/Ù\n/\n11110100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ı\n/\n11110101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/ˆ\n/\n11110110<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/˜\n/\n11110111<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/¯\n/\n11111000<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/˘\n/\n11111001<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/˙\n/\n11111010<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/˚\n/\n11111011<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/¸\n/\n11111100<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/˝\n/\n11111101<>/
            t anon_000025
        # Dont match newlines, there wont be any
        # M4 Comment character
        # Right quote
        # End of line
        # Start
        # Dot
        # Forward slash
        # Question mark
        # Capture group
        # Backslash
        # Regex start char
        # Left quote
            s/˛\n/\n11111110<>/
            t anon_000025
    : anon_000025
    # If the first char is not \n, we have more chars to process
    /^[^\n]/ b anon_000026loopStart
    # Otherwise, we're done
    s/^\n//
b dynamicDispatch
# Assuming the top of the stack is a pointer to the stdin buffer, read a value
# out of it, or get a new string if needed
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
# Rotations will auto-grow tape memory space
# Functions
# Counterintuitively, moving the pointer right means rotating the memory
# *left*, because our read head is always in the same place.
: main
    # Convert brainfuck script in first line to bytecode
    # All other lines are stdin
    # Delete irrelevant characters
    # Order is inconsistent because sed is weird
    s/[^][><+-.,]//g
    # Convert to numbers because its easier to deal with
    # The order is weird because otherwise sed breaks with the square brackets
    y/[><+-.,]/60123457/
    # Make sure braces are balanced
    h
    s/$//; t anon_000027
    : anon_000027
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
    s/^/00000000<>/
    # Main execution cycle
    : main_loop_start
        s/^\(.*\)|||\([0-8]\)/\2<>\1|||\2/
        /^0/ { 
    s/\([01@]*\)\(........\)$/\2\1/
    s/@@@@@@@@$/@@@@@@@@00000000/
        }
        /^1/ { 
    s/###\(........\)\(.*\)$/###\2\1/
    s/###\(.*\)@@@@@@@@$/###@@@@@@@@\100000000/
        }
        /^2/ { 
    s/^\(.*\)\(........\)$/\2<>\1\2/
    s/$//; t anon_000028
    : anon_000028
    # Increment one bit at a time
    s/^\(.......\)0/0\11/; t anon_0000291
    s/^\(.......\)1/1\10/; t anon_0000291
    : anon_0000291
    s/^0\(......\)0\(.\)/0\10\2/; t anon_0000292
    s/^0\(......\)1\(.\)/0\11\2/; t anon_0000292
    s/^1\(......\)0\(.\)/0\11\2/; t anon_0000292
    s/^1\(......\)1\(.\)/1\10\2/; t anon_0000292
    : anon_0000292
    s/^0\(.....\)0\(..\)/0\10\2/; t anon_0000293
    s/^0\(.....\)1\(..\)/0\11\2/; t anon_0000293
    s/^1\(.....\)0\(..\)/0\11\2/; t anon_0000293
    s/^1\(.....\)1\(..\)/1\10\2/; t anon_0000293
    : anon_0000293
    s/^0\(....\)0\(...\)/0\10\2/; t anon_0000294
    s/^0\(....\)1\(...\)/0\11\2/; t anon_0000294
    s/^1\(....\)0\(...\)/0\11\2/; t anon_0000294
    s/^1\(....\)1\(...\)/1\10\2/; t anon_0000294
    : anon_0000294
    s/^0\(...\)0\(....\)/0\10\2/; t anon_0000295
    s/^0\(...\)1\(....\)/0\11\2/; t anon_0000295
    s/^1\(...\)0\(....\)/0\11\2/; t anon_0000295
    s/^1\(...\)1\(....\)/1\10\2/; t anon_0000295
    : anon_0000295
    s/^0\(..\)0\(.....\)/0\10\2/; t anon_0000296
    s/^0\(..\)1\(.....\)/0\11\2/; t anon_0000296
    s/^1\(..\)0\(.....\)/0\11\2/; t anon_0000296
    s/^1\(..\)1\(.....\)/1\10\2/; t anon_0000296
    : anon_0000296
    s/^0\(.\)0\(......\)/0\10\2/; t anon_0000297
    s/^0\(.\)1\(......\)/0\11\2/; t anon_0000297
    s/^1\(.\)0\(......\)/0\11\2/; t anon_0000297
    s/^1\(.\)1\(......\)/1\10\2/; t anon_0000297
    : anon_0000297
    s/^00\(.......\)/0\1/; t anon_0000298
    s/^01\(.......\)/1\1/; t anon_0000298
    s/^10\(.......\)/1\1/; t anon_0000298
    s/^11\(.......\)/0\1/; t anon_0000298
    : anon_0000298
    s/^\(........\)<>\(.*\)........$/\2\1/
        }
        /^3/ { 
    s/^\(.*\)\(........\)$/\2<>\1\2/
    s/$//; t anon_000030
    : anon_000030
    # Invert each bit one at a time
    s/^\(.......\)0/\11/; t anon_0000311
    s/^\(.......\)1/\10/; t anon_0000311
    : anon_0000311
    s/^\(......\)0\(.\)/\11\2/; t anon_0000312
    s/^\(......\)1\(.\)/\10\2/; t anon_0000312
    : anon_0000312
    s/^\(.....\)0\(..\)/\11\2/; t anon_0000313
    s/^\(.....\)1\(..\)/\10\2/; t anon_0000313
    : anon_0000313
    s/^\(....\)0\(...\)/\11\2/; t anon_0000314
    s/^\(....\)1\(...\)/\10\2/; t anon_0000314
    : anon_0000314
    s/^\(...\)0\(....\)/\11\2/; t anon_0000315
    s/^\(...\)1\(....\)/\10\2/; t anon_0000315
    : anon_0000315
    s/^\(..\)0\(.....\)/\11\2/; t anon_0000316
    s/^\(..\)1\(.....\)/\10\2/; t anon_0000316
    : anon_0000316
    s/^\(.\)0\(......\)/\11\2/; t anon_0000317
    s/^\(.\)1\(......\)/\10\2/; t anon_0000317
    : anon_0000317
    s/^0\(.......\)/1\1/; t anon_0000318
    s/^1\(.......\)/0\1/; t anon_0000318
    : anon_0000318
    s/$//; t anon_000032
    : anon_000032
    # Increment one bit at a time
    s/^\(.......\)0/0\11/; t anon_0000331
    s/^\(.......\)1/1\10/; t anon_0000331
    : anon_0000331
    s/^0\(......\)0\(.\)/0\10\2/; t anon_0000332
    s/^0\(......\)1\(.\)/0\11\2/; t anon_0000332
    s/^1\(......\)0\(.\)/0\11\2/; t anon_0000332
    s/^1\(......\)1\(.\)/1\10\2/; t anon_0000332
    : anon_0000332
    s/^0\(.....\)0\(..\)/0\10\2/; t anon_0000333
    s/^0\(.....\)1\(..\)/0\11\2/; t anon_0000333
    s/^1\(.....\)0\(..\)/0\11\2/; t anon_0000333
    s/^1\(.....\)1\(..\)/1\10\2/; t anon_0000333
    : anon_0000333
    s/^0\(....\)0\(...\)/0\10\2/; t anon_0000334
    s/^0\(....\)1\(...\)/0\11\2/; t anon_0000334
    s/^1\(....\)0\(...\)/0\11\2/; t anon_0000334
    s/^1\(....\)1\(...\)/1\10\2/; t anon_0000334
    : anon_0000334
    s/^0\(...\)0\(....\)/0\10\2/; t anon_0000335
    s/^0\(...\)1\(....\)/0\11\2/; t anon_0000335
    s/^1\(...\)0\(....\)/0\11\2/; t anon_0000335
    s/^1\(...\)1\(....\)/1\10\2/; t anon_0000335
    : anon_0000335
    s/^0\(..\)0\(.....\)/0\10\2/; t anon_0000336
    s/^0\(..\)1\(.....\)/0\11\2/; t anon_0000336
    s/^1\(..\)0\(.....\)/0\11\2/; t anon_0000336
    s/^1\(..\)1\(.....\)/1\10\2/; t anon_0000336
    : anon_0000336
    s/^0\(.\)0\(......\)/0\10\2/; t anon_0000337
    s/^0\(.\)1\(......\)/0\11\2/; t anon_0000337
    s/^1\(.\)0\(......\)/0\11\2/; t anon_0000337
    s/^1\(.\)1\(......\)/1\10\2/; t anon_0000337
    : anon_0000337
    s/^00\(.......\)/0\1/; t anon_0000338
    s/^01\(.......\)/1\1/; t anon_0000338
    s/^10\(.......\)/1\1/; t anon_0000338
    s/^11\(.......\)/0\1/; t anon_0000338
    : anon_0000338
    s/$//; t anon_000034
    : anon_000034
    # Invert each bit one at a time
    s/^\(.......\)0/\11/; t anon_0000351
    s/^\(.......\)1/\10/; t anon_0000351
    : anon_0000351
    s/^\(......\)0\(.\)/\11\2/; t anon_0000352
    s/^\(......\)1\(.\)/\10\2/; t anon_0000352
    : anon_0000352
    s/^\(.....\)0\(..\)/\11\2/; t anon_0000353
    s/^\(.....\)1\(..\)/\10\2/; t anon_0000353
    : anon_0000353
    s/^\(....\)0\(...\)/\11\2/; t anon_0000354
    s/^\(....\)1\(...\)/\10\2/; t anon_0000354
    : anon_0000354
    s/^\(...\)0\(....\)/\11\2/; t anon_0000355
    s/^\(...\)1\(....\)/\10\2/; t anon_0000355
    : anon_0000355
    s/^\(..\)0\(.....\)/\11\2/; t anon_0000356
    s/^\(..\)1\(.....\)/\10\2/; t anon_0000356
    : anon_0000356
    s/^\(.\)0\(......\)/\11\2/; t anon_0000357
    s/^\(.\)1\(......\)/\10\2/; t anon_0000357
    : anon_0000357
    s/^0\(.......\)/1\1/; t anon_0000358
    s/^1\(.......\)/0\1/; t anon_0000358
    : anon_0000358
    s/^\(........\)<>\(.*\)........$/\2\1/
        }
        /^4/ { 
    s/^\(.*\)\(........\)$/\2<>\1\2/
    s/|||/000004<>|||/
    b func_r_putc
    : dynamic_000004
        }
        /^5/ { 
    # Stack state at the start of this:
    # <instr> <stdin_buffer>
    # In the future the instr maybe wont be there, but in the mean time
    # since its constant we can just drop it and then put it back
    s/^\([^<>]*<>\)//
    # Null byte terminating string, so need to read a new one
    /^00000000<>/ {
    s/|||/000005<>|||/
    b func_r_getln
    : dynamic_000005
    }
    # Next char is on the stack now yay
    s/^\(........\)<>\(.*\)........$/\2\1/
    s/^/5<>/
        }
        /^6/ { 
    s/^\(.*\)\(........\)$/\2<>\1\2/
    s/$//; t anon_000036
    : anon_000036
    /^00000000/ {
        # We could drop the top value and push the depth, but
        # we need the depth to be 0, which is our top value,
        # so we just leave the top value of the stack to be the depth
        : anon_000037
        s/|||\([0-8]\)\([0-8]*\)/|||\2\1/
        s/^\(.*\)|||\([0-8]\)/\2<>\1|||\2/
        # Closing brace at depth 0: done
        /^7<>00000000/ {
            s/^\([^<>]*<>\)//
            b anon_000038
        }
        # Closing brace at any other depth: dec depth
        /^7<>/ {
            s/^\([^<>]*<>\)//
    s/$//; t anon_000039
    : anon_000039
    # Invert each bit one at a time
    s/^\(.......\)0/\11/; t anon_0000401
    s/^\(.......\)1/\10/; t anon_0000401
    : anon_0000401
    s/^\(......\)0\(.\)/\11\2/; t anon_0000402
    s/^\(......\)1\(.\)/\10\2/; t anon_0000402
    : anon_0000402
    s/^\(.....\)0\(..\)/\11\2/; t anon_0000403
    s/^\(.....\)1\(..\)/\10\2/; t anon_0000403
    : anon_0000403
    s/^\(....\)0\(...\)/\11\2/; t anon_0000404
    s/^\(....\)1\(...\)/\10\2/; t anon_0000404
    : anon_0000404
    s/^\(...\)0\(....\)/\11\2/; t anon_0000405
    s/^\(...\)1\(....\)/\10\2/; t anon_0000405
    : anon_0000405
    s/^\(..\)0\(.....\)/\11\2/; t anon_0000406
    s/^\(..\)1\(.....\)/\10\2/; t anon_0000406
    : anon_0000406
    s/^\(.\)0\(......\)/\11\2/; t anon_0000407
    s/^\(.\)1\(......\)/\10\2/; t anon_0000407
    : anon_0000407
    s/^0\(.......\)/1\1/; t anon_0000408
    s/^1\(.......\)/0\1/; t anon_0000408
    : anon_0000408
    s/$//; t anon_000041
    : anon_000041
    # Increment one bit at a time
    s/^\(.......\)0/0\11/; t anon_0000421
    s/^\(.......\)1/1\10/; t anon_0000421
    : anon_0000421
    s/^0\(......\)0\(.\)/0\10\2/; t anon_0000422
    s/^0\(......\)1\(.\)/0\11\2/; t anon_0000422
    s/^1\(......\)0\(.\)/0\11\2/; t anon_0000422
    s/^1\(......\)1\(.\)/1\10\2/; t anon_0000422
    : anon_0000422
    s/^0\(.....\)0\(..\)/0\10\2/; t anon_0000423
    s/^0\(.....\)1\(..\)/0\11\2/; t anon_0000423
    s/^1\(.....\)0\(..\)/0\11\2/; t anon_0000423
    s/^1\(.....\)1\(..\)/1\10\2/; t anon_0000423
    : anon_0000423
    s/^0\(....\)0\(...\)/0\10\2/; t anon_0000424
    s/^0\(....\)1\(...\)/0\11\2/; t anon_0000424
    s/^1\(....\)0\(...\)/0\11\2/; t anon_0000424
    s/^1\(....\)1\(...\)/1\10\2/; t anon_0000424
    : anon_0000424
    s/^0\(...\)0\(....\)/0\10\2/; t anon_0000425
    s/^0\(...\)1\(....\)/0\11\2/; t anon_0000425
    s/^1\(...\)0\(....\)/0\11\2/; t anon_0000425
    s/^1\(...\)1\(....\)/1\10\2/; t anon_0000425
    : anon_0000425
    s/^0\(..\)0\(.....\)/0\10\2/; t anon_0000426
    s/^0\(..\)1\(.....\)/0\11\2/; t anon_0000426
    s/^1\(..\)0\(.....\)/0\11\2/; t anon_0000426
    s/^1\(..\)1\(.....\)/1\10\2/; t anon_0000426
    : anon_0000426
    s/^0\(.\)0\(......\)/0\10\2/; t anon_0000427
    s/^0\(.\)1\(......\)/0\11\2/; t anon_0000427
    s/^1\(.\)0\(......\)/0\11\2/; t anon_0000427
    s/^1\(.\)1\(......\)/1\10\2/; t anon_0000427
    : anon_0000427
    s/^00\(.......\)/0\1/; t anon_0000428
    s/^01\(.......\)/1\1/; t anon_0000428
    s/^10\(.......\)/1\1/; t anon_0000428
    s/^11\(.......\)/0\1/; t anon_0000428
    : anon_0000428
    s/$//; t anon_000043
    : anon_000043
    # Invert each bit one at a time
    s/^\(.......\)0/\11/; t anon_0000441
    s/^\(.......\)1/\10/; t anon_0000441
    : anon_0000441
    s/^\(......\)0\(.\)/\11\2/; t anon_0000442
    s/^\(......\)1\(.\)/\10\2/; t anon_0000442
    : anon_0000442
    s/^\(.....\)0\(..\)/\11\2/; t anon_0000443
    s/^\(.....\)1\(..\)/\10\2/; t anon_0000443
    : anon_0000443
    s/^\(....\)0\(...\)/\11\2/; t anon_0000444
    s/^\(....\)1\(...\)/\10\2/; t anon_0000444
    : anon_0000444
    s/^\(...\)0\(....\)/\11\2/; t anon_0000445
    s/^\(...\)1\(....\)/\10\2/; t anon_0000445
    : anon_0000445
    s/^\(..\)0\(.....\)/\11\2/; t anon_0000446
    s/^\(..\)1\(.....\)/\10\2/; t anon_0000446
    : anon_0000446
    s/^\(.\)0\(......\)/\11\2/; t anon_0000447
    s/^\(.\)1\(......\)/\10\2/; t anon_0000447
    : anon_0000447
    s/^0\(.......\)/1\1/; t anon_0000448
    s/^1\(.......\)/0\1/; t anon_0000448
    : anon_0000448
            b anon_000037
        }
        # Open brace: increase depth
        /^6<>/ {
            s/^\([^<>]*<>\)//
    s/$//; t anon_000045
    : anon_000045
    # Increment one bit at a time
    s/^\(.......\)0/0\11/; t anon_0000461
    s/^\(.......\)1/1\10/; t anon_0000461
    : anon_0000461
    s/^0\(......\)0\(.\)/0\10\2/; t anon_0000462
    s/^0\(......\)1\(.\)/0\11\2/; t anon_0000462
    s/^1\(......\)0\(.\)/0\11\2/; t anon_0000462
    s/^1\(......\)1\(.\)/1\10\2/; t anon_0000462
    : anon_0000462
    s/^0\(.....\)0\(..\)/0\10\2/; t anon_0000463
    s/^0\(.....\)1\(..\)/0\11\2/; t anon_0000463
    s/^1\(.....\)0\(..\)/0\11\2/; t anon_0000463
    s/^1\(.....\)1\(..\)/1\10\2/; t anon_0000463
    : anon_0000463
    s/^0\(....\)0\(...\)/0\10\2/; t anon_0000464
    s/^0\(....\)1\(...\)/0\11\2/; t anon_0000464
    s/^1\(....\)0\(...\)/0\11\2/; t anon_0000464
    s/^1\(....\)1\(...\)/1\10\2/; t anon_0000464
    : anon_0000464
    s/^0\(...\)0\(....\)/0\10\2/; t anon_0000465
    s/^0\(...\)1\(....\)/0\11\2/; t anon_0000465
    s/^1\(...\)0\(....\)/0\11\2/; t anon_0000465
    s/^1\(...\)1\(....\)/1\10\2/; t anon_0000465
    : anon_0000465
    s/^0\(..\)0\(.....\)/0\10\2/; t anon_0000466
    s/^0\(..\)1\(.....\)/0\11\2/; t anon_0000466
    s/^1\(..\)0\(.....\)/0\11\2/; t anon_0000466
    s/^1\(..\)1\(.....\)/1\10\2/; t anon_0000466
    : anon_0000466
    s/^0\(.\)0\(......\)/0\10\2/; t anon_0000467
    s/^0\(.\)1\(......\)/0\11\2/; t anon_0000467
    s/^1\(.\)0\(......\)/0\11\2/; t anon_0000467
    s/^1\(.\)1\(......\)/1\10\2/; t anon_0000467
    : anon_0000467
    s/^00\(.......\)/0\1/; t anon_0000468
    s/^01\(.......\)/1\1/; t anon_0000468
    s/^10\(.......\)/1\1/; t anon_0000468
    s/^11\(.......\)/0\1/; t anon_0000468
    : anon_0000468
            b anon_000037
        }
        # Anything else: just chill
        s/^\([^<>]*<>\)//
        b anon_000037
        : anon_000038
        # Let the drop after this block drop the depth
    }
    s/^\([^<>]*<>\)//
        }
        /^7/ { 
    s/^\(.*\)\(........\)$/\2<>\1\2/
    /^00000000<>/ b anon_000047
    s/^\([^<>]*<>\)//
    # Put depth on stack
    s/^/00000000<>/
    : anon_000048
    s/|||\([0-8]*\)\([0-8]\)/|||\2\1/
    s/^\(.*\)|||\([0-8]\)/\2<>\1|||\2/
    # Open brace at depth 0: done
    /^6<>00000000<>/ {
        s/^\([^<>]*<>\)//
        b anon_000049
    }
    # Open brace at any other depth: dec depth
    /^6<>/ {
        s/^\([^<>]*<>\)//
    s/$//; t anon_000050
    : anon_000050
    # Invert each bit one at a time
    s/^\(.......\)0/\11/; t anon_0000511
    s/^\(.......\)1/\10/; t anon_0000511
    : anon_0000511
    s/^\(......\)0\(.\)/\11\2/; t anon_0000512
    s/^\(......\)1\(.\)/\10\2/; t anon_0000512
    : anon_0000512
    s/^\(.....\)0\(..\)/\11\2/; t anon_0000513
    s/^\(.....\)1\(..\)/\10\2/; t anon_0000513
    : anon_0000513
    s/^\(....\)0\(...\)/\11\2/; t anon_0000514
    s/^\(....\)1\(...\)/\10\2/; t anon_0000514
    : anon_0000514
    s/^\(...\)0\(....\)/\11\2/; t anon_0000515
    s/^\(...\)1\(....\)/\10\2/; t anon_0000515
    : anon_0000515
    s/^\(..\)0\(.....\)/\11\2/; t anon_0000516
    s/^\(..\)1\(.....\)/\10\2/; t anon_0000516
    : anon_0000516
    s/^\(.\)0\(......\)/\11\2/; t anon_0000517
    s/^\(.\)1\(......\)/\10\2/; t anon_0000517
    : anon_0000517
    s/^0\(.......\)/1\1/; t anon_0000518
    s/^1\(.......\)/0\1/; t anon_0000518
    : anon_0000518
    s/$//; t anon_000052
    : anon_000052
    # Increment one bit at a time
    s/^\(.......\)0/0\11/; t anon_0000531
    s/^\(.......\)1/1\10/; t anon_0000531
    : anon_0000531
    s/^0\(......\)0\(.\)/0\10\2/; t anon_0000532
    s/^0\(......\)1\(.\)/0\11\2/; t anon_0000532
    s/^1\(......\)0\(.\)/0\11\2/; t anon_0000532
    s/^1\(......\)1\(.\)/1\10\2/; t anon_0000532
    : anon_0000532
    s/^0\(.....\)0\(..\)/0\10\2/; t anon_0000533
    s/^0\(.....\)1\(..\)/0\11\2/; t anon_0000533
    s/^1\(.....\)0\(..\)/0\11\2/; t anon_0000533
    s/^1\(.....\)1\(..\)/1\10\2/; t anon_0000533
    : anon_0000533
    s/^0\(....\)0\(...\)/0\10\2/; t anon_0000534
    s/^0\(....\)1\(...\)/0\11\2/; t anon_0000534
    s/^1\(....\)0\(...\)/0\11\2/; t anon_0000534
    s/^1\(....\)1\(...\)/1\10\2/; t anon_0000534
    : anon_0000534
    s/^0\(...\)0\(....\)/0\10\2/; t anon_0000535
    s/^0\(...\)1\(....\)/0\11\2/; t anon_0000535
    s/^1\(...\)0\(....\)/0\11\2/; t anon_0000535
    s/^1\(...\)1\(....\)/1\10\2/; t anon_0000535
    : anon_0000535
    s/^0\(..\)0\(.....\)/0\10\2/; t anon_0000536
    s/^0\(..\)1\(.....\)/0\11\2/; t anon_0000536
    s/^1\(..\)0\(.....\)/0\11\2/; t anon_0000536
    s/^1\(..\)1\(.....\)/1\10\2/; t anon_0000536
    : anon_0000536
    s/^0\(.\)0\(......\)/0\10\2/; t anon_0000537
    s/^0\(.\)1\(......\)/0\11\2/; t anon_0000537
    s/^1\(.\)0\(......\)/0\11\2/; t anon_0000537
    s/^1\(.\)1\(......\)/1\10\2/; t anon_0000537
    : anon_0000537
    s/^00\(.......\)/0\1/; t anon_0000538
    s/^01\(.......\)/1\1/; t anon_0000538
    s/^10\(.......\)/1\1/; t anon_0000538
    s/^11\(.......\)/0\1/; t anon_0000538
    : anon_0000538
    s/$//; t anon_000054
    : anon_000054
    # Invert each bit one at a time
    s/^\(.......\)0/\11/; t anon_0000551
    s/^\(.......\)1/\10/; t anon_0000551
    : anon_0000551
    s/^\(......\)0\(.\)/\11\2/; t anon_0000552
    s/^\(......\)1\(.\)/\10\2/; t anon_0000552
    : anon_0000552
    s/^\(.....\)0\(..\)/\11\2/; t anon_0000553
    s/^\(.....\)1\(..\)/\10\2/; t anon_0000553
    : anon_0000553
    s/^\(....\)0\(...\)/\11\2/; t anon_0000554
    s/^\(....\)1\(...\)/\10\2/; t anon_0000554
    : anon_0000554
    s/^\(...\)0\(....\)/\11\2/; t anon_0000555
    s/^\(...\)1\(....\)/\10\2/; t anon_0000555
    : anon_0000555
    s/^\(..\)0\(.....\)/\11\2/; t anon_0000556
    s/^\(..\)1\(.....\)/\10\2/; t anon_0000556
    : anon_0000556
    s/^\(.\)0\(......\)/\11\2/; t anon_0000557
    s/^\(.\)1\(......\)/\10\2/; t anon_0000557
    : anon_0000557
    s/^0\(.......\)/1\1/; t anon_0000558
    s/^1\(.......\)/0\1/; t anon_0000558
    : anon_0000558
        b anon_000048
    }
    # Close brace: increase depth
    /^7<>/ {
        s/^\([^<>]*<>\)//
    s/$//; t anon_000056
    : anon_000056
    # Increment one bit at a time
    s/^\(.......\)0/0\11/; t anon_0000571
    s/^\(.......\)1/1\10/; t anon_0000571
    : anon_0000571
    s/^0\(......\)0\(.\)/0\10\2/; t anon_0000572
    s/^0\(......\)1\(.\)/0\11\2/; t anon_0000572
    s/^1\(......\)0\(.\)/0\11\2/; t anon_0000572
    s/^1\(......\)1\(.\)/1\10\2/; t anon_0000572
    : anon_0000572
    s/^0\(.....\)0\(..\)/0\10\2/; t anon_0000573
    s/^0\(.....\)1\(..\)/0\11\2/; t anon_0000573
    s/^1\(.....\)0\(..\)/0\11\2/; t anon_0000573
    s/^1\(.....\)1\(..\)/1\10\2/; t anon_0000573
    : anon_0000573
    s/^0\(....\)0\(...\)/0\10\2/; t anon_0000574
    s/^0\(....\)1\(...\)/0\11\2/; t anon_0000574
    s/^1\(....\)0\(...\)/0\11\2/; t anon_0000574
    s/^1\(....\)1\(...\)/1\10\2/; t anon_0000574
    : anon_0000574
    s/^0\(...\)0\(....\)/0\10\2/; t anon_0000575
    s/^0\(...\)1\(....\)/0\11\2/; t anon_0000575
    s/^1\(...\)0\(....\)/0\11\2/; t anon_0000575
    s/^1\(...\)1\(....\)/1\10\2/; t anon_0000575
    : anon_0000575
    s/^0\(..\)0\(.....\)/0\10\2/; t anon_0000576
    s/^0\(..\)1\(.....\)/0\11\2/; t anon_0000576
    s/^1\(..\)0\(.....\)/0\11\2/; t anon_0000576
    s/^1\(..\)1\(.....\)/1\10\2/; t anon_0000576
    : anon_0000576
    s/^0\(.\)0\(......\)/0\10\2/; t anon_0000577
    s/^0\(.\)1\(......\)/0\11\2/; t anon_0000577
    s/^1\(.\)0\(......\)/0\11\2/; t anon_0000577
    s/^1\(.\)1\(......\)/1\10\2/; t anon_0000577
    : anon_0000577
    s/^00\(.......\)/0\1/; t anon_0000578
    s/^01\(.......\)/1\1/; t anon_0000578
    s/^10\(.......\)/1\1/; t anon_0000578
    s/^11\(.......\)/0\1/; t anon_0000578
    : anon_0000578
        b anon_000048
    }
    # Anything else: just chill
    s/^\([^<>]*<>\)//
    b anon_000048
    : anon_000049
    # the end r_drop will drop out depth
    : anon_000047
    s/^\([^<>]*<>\)//
        }
        /^8/ {
            b prog_end
        }
        : main_loop_end
        s/^\([^<>]*<>\)//
        s/|||\([0-8]\)\([0-8]*\)/|||\2\1/
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
    s/$//; t anon_000058
    : anon_000058
        s/^000001<>//; t dynamic_000001
        s/^000002<>//; t dynamic_000002
        s/^000003<>//; t dynamic_000003
        s/^000004<>//; t dynamic_000004
        s/^000005<>//; t dynamic_000005
    i Dynamic dispatch failed; printing stack:
    p
    q
