# elements of ABNF/RFC 5234 that retain legibility in all caps
unit grammar US-ASCII::ABNF::Common:ver<0.1.0>:auth<R Schmidt (ronaldxs@software-path.com)>;

token LF    { <[\c[LF]]> }
token CR    { <[\c[CR]]> }
token SP    { <[\ ]> }
token BIT   { <[01]> } # either ASCII digit 0 or 1
token CHAR  { <[\x[01]..\x[7F]]> } 
