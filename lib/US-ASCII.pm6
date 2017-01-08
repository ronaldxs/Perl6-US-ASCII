grammar US-ASCII:ver<0.0.1>:auth<R Schmidt (ronaldxs@software-path.com)> {
    token alpha     { <[A..Za..z]> }
    token upper     { <[A..Z]> }
    token lower     { <[a..z]> }
    token digit     { <[0..9]> }
    token xdigit    { <[A..Fa..f0..9]> }
    token alnum     { <[A..Za..z0..9]> }
    token blank     { <[ \t]> }
    # see RT #130527 for why we might need _punct
    token _punct    { <[\-!"#%&'()*,./:;?@[\\\]_{}]> }
    token punct     { <+_punct> }

    # unicode basic latin is US-ASCII
    constant charset = set chr(0) .. chr(127);
}

# if uou are not using inheritance then US-ASCII::alpha as above is
# easier to read then US-ASCII::ALPHA.  You might want to inherit the
# rules and not overwrite the builtins as provided below.
grammar US-ASCII-UC {
    token ALPHA     { <.US-ASCII::alpha> }
    token UPPER     { <.US-ASCII::upper> }
    token LOWER     { <.US-ASCII::lower> }
    token DIGIT     { <.US-ASCII::digit> }
    token XDIGIT    { <.US-ASCII::xdigit> }
    token ALNUM     { <.US-ASCII::alnum> }
    token PUNCT     { <.US-ASCII::punct> }

    constant charset = US-ASCII::charset;
}
