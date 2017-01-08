use Test;
use US-ASCII;

# much testing copied from roast charsets.t
# https://github.com/perl6/roast/blob/master/S05-mass/charsets.t

# latin-chars are characters from first two Unicode code blocks
# which are "Basic Latin" and "Latin-1 Supplement"
my $latin-chars = [~] chr(0)..chr(0xFF);

my @upper_r = 'A' .. 'Z';
my @lower_r = 'a' .. 'z';
my @digit_r = '0' .. '9';
my @xdigit_r = (@digit_r, 'A' .. 'F', 'a' .. 'f').flat;

is $latin-chars.comb(/<US-ASCII::alpha>/).join,
    (@upper_r, @lower_r).flat.join,
    'alpha correct US-ASCII char subset';
is $latin-chars.comb(/<US-ASCII::upper>/).join, $([~] @upper_r),
    'upper correct US-ASCII char subset';
is $latin-chars.comb(/<US-ASCII::lower>/).join, $([~] @lower_r),
    'lower correct US-ASCII char subset';
is $latin-chars.comb(/<US-ASCII::digit>/).join, $([~] @digit_r),
    'digit correct US-ASCII char subset';
is $latin-chars.comb(/<US-ASCII::xdigit>/).join, $([~] @xdigit_r),
    'xdigit correct US-ASCII char subset';
is $latin-chars.comb(/<US-ASCII::alnum>/).join,
    (@digit_r, @upper_r, @lower_r).flat.join,
    'alnum correct US-ASCII char subset';
is $latin-chars.comb(/<US-ASCII::punct>/).join,
    q<!"#%&'()*,-./:;?@[\]_{}>, 'punct chars since unicode 6.1';
                                  

grammar ascii-by-count is US-ASCII-UC {
    token alpha-c52     { ^ <-ALPHA>* [ <ALPHA> <-ALPHA>* ] ** 52 $ }
    token upper-c26     { ^ <-UPPER>* [ <UPPER> <-UPPER>* ] ** 26 $ }
    token lower-c26     { ^ <-LOWER>* [ <LOWER> <-LOWER>* ] ** 26 $ }
    token digit-c10     { ^ <-DIGIT>* [ <DIGIT> <-DIGIT>* ] ** 10 $ }
    token xdigit-c22    { ^ <-XDIGIT>* [ <XDIGIT> <-XDIGIT>* ] ** 22 $ }
    token alnum-c62     { ^ <-ALNUM>* [ <ALNUM> <-ALNUM>* ] ** 62 $ }
    token punct-c23     { ^ <-PUNCT>* [ <PUNCT> <-PUNCT>* ] ** 23 $ }
}

subtest {
    ok $latin-chars ~~ /<ascii-by-count::alpha-c52>/,
        'ALPHA subset has right size';
    ok (@upper_r, @lower_r).flat.join ~~ /<ascii-by-count::alpha-c52>/,
        'ALPHA subset has right elements';
}, 'ALPHA char class';

subtest {
    ok $latin-chars ~~ /<ascii-by-count::upper-c26>/,
        'UPPER subset has right size';
    ok $([~] @upper_r) ~~ /<ascii-by-count::upper-c26>/,
        'UPPER subset has right elements';
}, 'UPPER char class';

subtest {
    ok $latin-chars ~~ /<ascii-by-count::lower-c26>/,
        'LOWER subset has right size';
    ok $([~] @lower_r) ~~ /<ascii-by-count::lower-c26>/,
        'LOWER subset has right elements';
}, 'LOWER char class';

subtest {
    ok $latin-chars ~~ /<ascii-by-count::digit-c10>/,
        'DIGIT subset has right size';
    ok $([~] @digit_r) ~~ /<ascii-by-count::digit-c10>/,
        'DIGIT subset has right elements';
}, 'DIGIT char class';

subtest {
    ok $latin-chars ~~ /<ascii-by-count::xdigit-c22>/,
        'XDIGIT subset has right size';
    ok $([~] @xdigit_r) ~~ /<ascii-by-count::xdigit-c22>/,
        'XDIGIT subset has right elements';
}, 'XDIGIT char class';

subtest {
    ok $latin-chars ~~ /<ascii-by-count::alnum-c62>/,
        'ALNUM subset has right size';
    ok (@digit_r, @upper_r, @lower_r).flat.join ~~
            /<ascii-by-count::alnum-c62>/,
        'ALNUM subset has right elements';
}, 'ALNUM char class';

subtest {
    ok $latin-chars ~~ /<ascii-by-count::punct-c23>/,
        'PUNCT subset has right size';
    ok q<!"#%&'()*,-./:;?@[\]_{}> ~~ /<ascii-by-count::punct-c23>/,
        'PUNCT subset has right elements';
}, 'PUNCT char class';
