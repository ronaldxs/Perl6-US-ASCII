# NAME
US-ASCII - ASCII restricted character classes based on Perl 6 predefined classes and ABNF/RFC5234 Core.

# SYNOPSIS

```Perl6
use US-ASCII;

say so /<US-ASCII::alpha>/ for <A À 9>; # True, False, False

grammar IPv6 is US-ASCII-UC {
  token h16 { <HEXDIG> ** 1..4}
}
# False, True, True, False, False
say so IPv6.parse($_, :rule<h16>) for ('DÉÃD', 'BEEF', 'A0', 'A๐', 'a0');

grammar SQL_92 is US-ASCII-UC {
  token unsigned-integer { <DIGIT>+ }
}
# True, False
say so SQL_92.parse($_, :rule<unsigned-integer>) for ('42', '4２');
```

# DESCRIPTION

This module provides regex character classes restricted to ASCII
including the predefined character classes of Perl 6 and some
ABNF (RFC 5234) Core rules. The module defines two grammars to
avoid readability issues with long upper case names.  The US-ASCII
grammar defines most character classes in lower case for direct use without inheritance as in the first SYNOPSIS example. The US-ASCII-UC grammar defines all character classes in upper case and is intended
for grammars that inherit. Inheriting upper case named rules/tokens
does not override the predefined Perl 6 character classes and
conforms better to RFC 5234 ABNF facilitating use with grammars of
other internet standards based on that RFC.  Unlike RFC 5234, and
some existing Perl 6 implementations of it, US-ASCII rules are very rarely defined by ordinal values and mostly use, hopefully clearer,
Perl6 character ranges and names.

# Rules (token)

## Shared by both US-ASCII and US-ASCII-UC

* LF
* CR
* SP (space)
* BIT ('0' or '1')
* CHAR (Anything in US-ASCII other than NUL)

## Rules (token) in differing case in US-ASCII and US-ASCII-UC

Almost all are based on predefined Perl 6 character classes.

* alpha / ALPHA
* upper / UPPER
* lower / LOWER
* digit / DIGIT
* xdigit / XDIGIT
* hexdig / HEXDIG # ABNF 0..9A..F (but not a..f)
* alnum / ALNUM
* punct / PUNCT
* graph / GRPAH
* blank / BLANK
* space / SPACE
* print / PRINT
* cntrl / CNTRL
