# BIT and CRLF are ABNF but also imagined to useful token rules for p6
#

unit role US-ASCII::ABNF::Core::Common:ver<0.1.4>:auth<R Schmidt (ronaldxs@software-path.com)>;

token BIT   { <[01]> } # either ASCII digit 0 or 1
token CRLF  { \c[CR]\c[LF] }
token CHAR  { <[\x[01]..\x[7F]]> } 
