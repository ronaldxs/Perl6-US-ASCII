NAME
====

US-ASCII::ABNF::Core - tokens for ABNF Core rules from RFC 5234

SYNOPSIS
========

```perl6
use US-ASCII::ABNF::Core;

grammar IPv4 does US-ASCII::ABNF::Core {
    token TOP   {
        <dec-octet> '.' <dec-octet> '.' <dec-octet> '.' <dec-octet>
    }
    token dec-octet         {
        '25' <[0..5]>           |   # 250 - 255
        '2' <[0..4]> <DIGIT>    |   # 200 - 249
        '1' <DIGIT> ** 2        |   # 100 - 199
        <[1..9]> <DIGIT>        |   # 10 - 99
        <DIGIT>                     # 0 - 9
    }
}
say so IPv4.parse("199.2.167.5");   # true
say so IPv4.parse("199.૫.167.5");   # false
```

```perl6
use US-ASCII::ABNF::Core :ALL;

say so 'DÉÃD' ~~ /^<ALPHA>*$/;  # false
say so 'BEEF' ~~ /^<ALPHA>*$/;  # true
```

DESCRIPTION
===========

Provides ABNF Core tokens, as specified in RFC 5234, for composition into grammar from role or import for direct use in regexes and parsing.

Tokens
======

  * ALPHA

  * BIT

  * CHAR

  * CR

  * CRLF

  * CTL

  * DIGIT

  * DQUOTE

  * HEXDIG

  * HTAB

  * LF

  * LWSP

  * OCTET

  * SP

  * VCHAR

  * WSP

LIMITATIONS
===========

Perl 6 strings treat `"\c[CR]\c[LF]"` as a single grapheme and that sequence will not match either `<CR>` or `<LF>` but will match `<CRLF>`.

The Unicode `\c[KELVIN SIGN]` at code point `\x[212A]` is normalized by Perl 6 string processing to the letter 'K' and `say so "\x[212B]" ~~ /K/ ` prints `True`. Regex tests that match the letter K, including US-ASCII::ABNF::Core tokens, may thus appear to match the Kelvin sign.
