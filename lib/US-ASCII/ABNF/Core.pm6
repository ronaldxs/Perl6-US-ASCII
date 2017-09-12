use v6.c;

=begin pod

=head1 NAME

US-ASCII::ABNF::Core - tokens for ABNF Core rules from RFC 5234

=head1 SYNOPSIS

=begin code :lang<perl6>
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
=end code

=begin code :lang<perl6>
use US-ASCII::ABNF::Core :ALL;

say so 'DÉÃD' ~~ /^<ALPHA>*$/;  # false
say so 'BEEF' ~~ /^<ALPHA>*$/;  # true
=end code

=head1 DESCRIPTION

Provides ABNF Core tokens, as specified in RFC 5234, for composition
into grammar from role or import for direct use in regexes and parsing.

=head1 Tokens

=item ALPHA
=item BIT
=item CHAR
=item CR
=item CRLF
=item CTL
=item DIGIT
=item DQUOTE
=item HEXDIG
=item HTAB
=item LF
=item LWSP
=item OCTET
=item SP
=item VCHAR
=item WSP

=head1 LIMITATIONS

Perl 6 strings treat C<"\c[CR]\c[LF]"> as a single grapheme and that sequence
will not match either C< <CR>> or C< <LF>> but will match C< <CRLF>>.

The Unicode C<\c[KELVIN SIGN]> at code point C<\x[212A]> is normalized by Perl
6 string processing to the letter 'K' and C< say so "\x[212B]" ~~ /K/ > prints
C<True>.  Regex tests that match the letter K, including US-ASCII::ABNF::Core
tokens, may thus appear to match the Kelvin sign.

=end pod


use US-ASCII::ABNF::Core::Common;
use US-ASCII::ABNF::Core::P6Common;
use US-ASCII::ABNF::Core::Only;
use US-ASCII::ABNF::Core::More;

role US-ASCII::ABNF::Core:ver<0.1.1>:auth<R Schmidt (ronaldxs@software-path.com)>
    does US-ASCII::ABNF::Core::Common
    does US-ASCII::ABNF::Core::Only
    does US-ASCII::ABNF::Core::More     {

token ALPHA     { <.US-ASCII::ABNF::Core::P6Common_g::alpha>   }
token DIGIT     { <.US-ASCII::ABNF::Core::P6Common_g::digit>   }
token HEXDIG    { <.US-ASCII::ABNF::Core::P6Common_g::hexdig>  }
token VCHAR     { <.US-ASCII::ABNF::Core::P6Common_g::vchar>   }

}

grammar US-ASCII::ABNF::Core-g:ver<0.1.1>:auth<R Schmidt (ronaldxs@software-path.com)>
    does US-ASCII::ABNF::Core {

    our token   ALPHA     is export(:ALL) { <.US-ASCII::ABNF::Core-g::ALPHA> }
    our token   BIT       is export(:ALL) { <.US-ASCII::ABNF::Core-g::BIT> }
    our token   CHAR      is export(:ALL) { <.US-ASCII::ABNF::Core-g::CHAR> }
    our token   CR        is export(:ALL) { <.US-ASCII::ABNF::Core-g::CR> }
    our token   CRLF      is export(:ALL) { <.US-ASCII::ABNF::Core-g::CRLF> }
    our token   CTL       is export(:ALL) { <.US-ASCII::ABNF::Core-g::CTL> }
    our token   DIGIT     is export(:ALL) { <.US-ASCII::ABNF::Core-g::DIGIT> }
    our token   DQUOTE    is export(:ALL) { <.US-ASCII::ABNF::Core-g::DQUOTE> }
    our token   HEXDIG    is export(:ALL) { <.US-ASCII::ABNF::Core-g::HEXDIG> }
    our token   HTAB      is export(:ALL) { <.US-ASCII::ABNF::Core-g::HTAB> }
    our token   LF        is export(:ALL) { <.US-ASCII::ABNF::Core-g::LF> }
    our token   LWSP      is export(:ALL) { <.US-ASCII::ABNF::Core-g::LWSP> }
    our token   OCTET     is export(:ALL) { <.US-ASCII::ABNF::Core-g::OCTET> }
    our token   SP        is export(:ALL) { <.US-ASCII::ABNF::Core-g::SP> }
    our token   VCHAR     is export(:ALL) { <.US-ASCII::ABNF::Core-g::VCHAR> }
    our token   WSP       is export(:ALL) { <.US-ASCII::ABNF::Core-g::WSP> }
}
