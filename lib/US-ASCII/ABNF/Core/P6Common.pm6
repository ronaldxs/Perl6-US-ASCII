# alpha and digit are used by both ABNF and p6
# blank and cntrl are p6 classes with different names in ABNF (CTL and WSP)
# hexdig and vchar are from ABNF but are nice to have in p6 for ASCII

# internal use - you probably don't want to use this directly

role US-ASCII::ABNF::Core::P6Common:ver<0.1.1>:auth<R Schmidt (ronaldxs@software-path.com)> {

token alpha     { <[A..Za..z]> }
token digit     { <[0..9]> }
token blank     { <[\t\ ]> }
token cntrl     { <[\x[0]..\x[1f]]+[\x[7f]]> }
token hexdig    { <[0..9A..F]> }
token vchar     { <[\x[21]..\x[7E]]> }

}

# extending grammars with "does ...::P6Common" overrides
# default p6 character classes so use grammar below to avoid leakage
grammar US-ASCII::ABNF::Core::P6Common_g:ver<0.1.1>:auth<R Schmidt (ronaldxs@software-path.com)> does US-ASCII::ABNF::Core::P6Common {}
