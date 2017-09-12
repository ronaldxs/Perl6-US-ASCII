NAME
====

US-ASCII - ASCII restricted character classes based on Perl 6 predefined classes and ABNF/RFC5234 Core.

SYNOPSIS
========

```perl6
use US-ASCII;

say so /<US-ASCII::alpha>/ for <A À 9>; # True, False, False

grammar IPv6 does US-ASCII-UC {
    token h16 { <HEXDIG> ** 1..4}
}
# False, True, True, False, False
say so IPv6.parse($_, :rule<h16>) for ('DÉÃD', 'BEEF', 'A0', 'A๐', 'a0');

grammar SQL_92 does US-ASCII-UC {
    token unsigned-integer { <DIGIT>+ }
}
# True, False
say so SQL_92.parse($_, :rule<unsigned-integer>) for ('42', '4૫');
```

```perl6
use US-ASCII :UC;

say so /<ALPHA>/ for <A À 9>; # True, False, False
```

DESCRIPTION
===========

This module provides regex character classes restricted to ASCII including the predefined character classes of Perl 6 and ABNF (RFC 5234) Core rules. The US-ASCII grammar defines most character classes in lower case for direct use without composition as in the first SYNOPSIS example. The US-ASCII-UC role defines all character classes in upper case and is intended for composition into grammars. Upper case US-ASCII tokens may be imported with the import tag `:UC`. Composition of upper case named regex/tokens does not override the predefined Perl 6 character classes and conforms better to RFC 5234 ABNF, facilitating use with grammars of other internet standards based on that RFC. The US-ASCII-ABNF role extends US-ASCII-UC by defining all ABNF Core tokens including ones like DQUOTE that are trivially coded in Perl6 and others that are likely only to be useful for composition in grammars related to ABNF. Unlike RFC 5234, and some existing Perl 6 implementations of it, US-ASCII rules are very rarely defined by ordinal values and mostly use, hopefully clearer, Perl 6 character ranges and names.

Named Regex (token)
===================

Named Regex (token) in differing case in US-ASCII and US-ASCII-UC/(import tag :UC)
----------------------------------------------------------------------------------

Almost all are based on predefined Perl 6 character classes.

  * alpha / ALPHA

  * upper / UPPER

  * lower / LOWER

  * digit / DIGIT

  * xdigit / XDIGIT

  * hexdig / HEXDIG # ABNF 0..9A..F (but not a..f)

  * alnum / ALNUM

  * punct / PUNCT

  * graph / GRAPH

  * blank / BLANK

  * space / SPACE

  * print / PRINT

  * cntrl / CNTRL

  * vchar / VCHAR # ABNF \x[21]..\x[7E] visible (printing) chars

  * wb / WB

  * ww / WW

Shared by both US-ASCII and US-ASCII-UC
---------------------------------------

  * BIT ('0' or '1')

  * CHAR (Anything in US-ASCII other than NUL)

  * CRLF

Named Regex (token) in US-ASCII-ABNF/(import tag :ABNF) only useful for ABNF
----------------------------------------------------------------------------

  * CR

  * CTL

  * DQUOTE

  * HTAB

  * LF

  * SP (space)

  * LWSP (ABNF linear white space)

  * OCTET

  * WSP

<table>
  <thead>
    <tr>
      <td>ABNF Core rule</td>
      <td>Perl 6 equivalent</td>
    </tr>
  </thead>
  <tr>
    <td>CR</td>
    <td>\c[CR]</td>
  </tr>
  <tr>
    <td>CTL</td>
    <td>US-ASCII cntrl / CNTRL</td>
  </tr>
  <tr>
    <td>DQUOTE</td>
    <td>'"'</td>
  </tr>
  <tr>
    <td>HTAB</td>
    <td>"\t"</td>
  </tr>
  <tr>
    <td>LF</td>
    <td>\c[LF]</td>
  </tr>
  <tr>
    <td>SP</td>
    <td>' '</td>
  </tr>
  <tr>
    <td>WSP</td>
    <td>US-ASCII blank / BLANK</td>
  </tr>
</table>

Backward compatibility break with CR, LF, SP.
---------------------------------------------

In 0.1.X releases CR, LF and SP were provided by the US-ASCII grammar. They are now treated as ABNF Core only tokens, as they can be easily enough coded in Perl 6 using equivalents noted in the table above.

ABNF Core
=========

Since ABNF is defined using the ASCII character set the distribution includes an US-ASCII::ABNF::Core module defining the tokens for ABNF Core as enumerated in RFC 5234. See that module's documentation for more detail.

LIMITATIONS
===========

Perl 6 strings treat `"\c[CR]\c[LF]"` as a single grapheme and that sequence will not match either `<CR>` or `<LF>` but will match `<CRLF>`.

The Unicode `\c[KELVIN SIGN]` at code point `\x[212A]` is normalized by Perl 6 string processing to the letter 'K' and `say so "\x[212B]" ~~ /K/ ` prints `True`. Regex tests that match the letter K, including US-ASCII tokens, may thus appear to match the Kelvin sign.
