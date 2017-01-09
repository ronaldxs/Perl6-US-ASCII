grammar US-ASCII:ver<0.0.1>:auth<R Schmidt (ronaldxs@software-path.com)> {
    token alpha     { <[A..Za..z]> }
    token upper     { <[A..Z]> }
    token lower     { <[a..z]> }
    token digit     { <[0..9]> }
    token xdigit    { <[0..9A..Fa..f]> }
    token alnum     { <[0..9A..Za..z]> }
    # see RT #130527 for why we might need _punct and _space
    token _punct    { <[\-!"#%&'()*,./:;?@[\\\]_{}]> }
    token punct     { <+_punct> }
    token graph     { <+_punct +[0..9A..Za..z]> }
    token blank     { <[\t\ ]> }
    # \n logical so \x[a] for now
    # should CRLF be one or two spaces?
    # can't just rely on \n because match \x[85]
    # https://docs.perl6.org/language/regexes#Backslashed,_predefined_character_classes
    # \n is supposed to also match a Windows CR LF codepoint pair; though it is unclear whether the magic happens at the time that external data is read, or at regex match time. 
    # https://github.com/perl6/doc/issues/1092
    token _space    { <[\t\x[a]\x[b]\x[c]\r\ ]> } # \n logical so \x[a]
    token space     { <+_space> }
    token print     { <+_punct +_space +[0..9A..Za..z]> }
    token cntrl     { <[\x[0]..\x[f]]+[\x[7f]]> }

    # todo ww, wb others?
    # token LF        { <[\x[0A]]> }
    # token CR        { <[\x[0D]]> }
    # token NL ??

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
    token GRAPH     { <.US-ASCII::graph> }
    token BLANK     { <.US-ASCII::blank> }
    token SPACE     { <.US-ASCII::space> }
    token PRINT     { <.US-ASCII::print> }
    token CNTRL     { <.US-ASCII::cntrl> }

    constant ASCII-charset = US-ASCII::charset;
}
