
######################################################################
# Test wb and (coming soon) ww.
#
# tests copied from:
#   https://github.com/perl6/roast/blob/master/S05-mass/rx.t
#
######################################################################

use Test;
use US-ASCII :UC;

plan 15; 

constant $abc-def-ghi = "abc\ndef\n-==\nghi";
constant $def-ab-cedilla = "def\nabç\n-==\nghi";

grammar test-wb-ww-inherit does US-ASCII-UC {
    method check-wb {
        ok $abc-def-ghi ~~ /<?WB>def/, 'word boundary \W\w by inheritance';
    }
}


#### <?wb>def       abc\ndef\n-==\nghi  y   word boundary \W\w
ok $abc-def-ghi ~~ /<?WB>def/, 'word boundary \W\w';
ok $abc-def-ghi ~~ /<?US-ASCII::wb>def/, 'word boundary \W\w longer name';
test-wb-ww-inherit.check-wb;

#### abc<?wb>       abc\ndef\n-==\nghi  y   word boundary \w\W
ok $abc-def-ghi ~~ /abc<?WB>/, 'word boundary \w\W';
ok $def-ab-cedilla ~~ /<?WB>ab<?WB>/, 'word boundaries \W\w\w\W unicode';

#### <?wb>abc       abc\ndef\n-==\nghi  y   BOS word boundary
ok $abc-def-ghi ~~ /<?WB>abc/, 'BOS word boundary';

#### ghi<?wb>       abc\ndef\n-==\nghi  y   EOS word boundary
ok $abc-def-ghi ~~ /ghi<?WB>/, 'EOS word boundary';

#### a<?wb>         abc\ndef\n-==\nghi  n   \w\w word boundary
ok $abc-def-ghi !~~ /a<?WB>/, '\w\w word boundary';

#### \-<?wb>            abc\ndef\n-==\nghi  n   \W\W word boundary
ok $abc-def-ghi !~~ /\-<?WB>/, '\W\W word boundary';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading ! indicates">

#### <!wb>def       abc\ndef\n-==\nghi  n   nonword boundary \W\w
ok $abc-def-ghi !~~ /<!WB>def/, 'nonword boundary \W\w';

#### abc<!wb>       abc\ndef\n-==\nghi  n   nonword boundary \w\W
ok $abc-def-ghi !~~ /abc<!WB>/, 'nonword boundary \w\W';

#### <!wb>abc       abc\ndef\n-==\nghi  n   BOS nonword boundary
ok $abc-def-ghi !~~ /<!WB>abc/, 'BOS nonword boundary';

#### ghi<!wb>       abc\ndef\n-==\nghi  n   EOS nonword boundary
ok $abc-def-ghi !~~ /ghi<!WB>/, 'EOS nonword boundary';

#### a<!wb>         abc\ndef\n-==\nghi  y   \w\w nonword boundary
ok $abc-def-ghi ~~ /a<!WB>/, '\w\w nonword boundary';

#### \-<!wb>            abc\ndef\n-==\nghi  y   \W\W nonword boundary
ok $abc-def-ghi ~~ /\-<!WB>/, '\W\W nonword boundary';


