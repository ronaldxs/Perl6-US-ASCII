# characters from RFC 5234/ABNF Core that are expected only to be
# useful for ABNF and not other P6 parsing

use US-ASCII::ABNF::Core::P6Common;
use US-ASCII::ABNF::Core::Common;

unit role US-ASCII::ABNF::Core::Only:ver<0.1.1>:auth<R Schmidt (ronaldxs@software-path.com)>;

token LF        { <[\c[LF]]> }
token CR        { <[\c[CR]]> }
token SP        { <[\ ]> }
token HTAB      { <[\t]> }
token DQUOTE    { <["]> }
token OCTET     { <[\x[0]..\x[FF]]> }

token LWSP      {   [
        <.US-ASCII::ABNF::Core::P6Common_g::blank>           |
        <.CRLF> <.US-ASCII::ABNF::Core::P6Common_g::blank> 
    ] * }
