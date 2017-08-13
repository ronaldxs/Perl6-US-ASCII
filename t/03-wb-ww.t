
######################################################################
# Test wb and (coming soon) ww.
#
# tests copied from:
#   https://github.com/perl6/roast/blob/master/S05-mass/rx.t
#
######################################################################

use Test;
use US-ASCII :UC;

plan 14;

constant $test_str = "abc\ndef\n-==\nghi";

grammar test-wb-ww-inherit does US-ASCII-UC {
    method check-wb {
        ok $test_str ~~ /<?WB>def/, 'word boundary \W\w';
    }
}


#### <?wb>def       abc\ndef\n-==\nghi  y   word boundary \W\w
ok $test_str ~~ /<?WB>def/, 'word boundary \W\w';
ok $test_str ~~ /<?US-ASCII::wb>def/, 'word boundary \W\w';
test-wb-ww-inherit.check-wb;

#### abc<?wb>       abc\ndef\n-==\nghi  y   word boundary \w\W
ok $test_str ~~ /abc<?WB>/, 'word boundary \w\W';

#### <?wb>abc       abc\ndef\n-==\nghi  y   BOS word boundary
ok $test_str ~~ /<?WB>abc/, 'BOS word boundary';

#### ghi<?wb>       abc\ndef\n-==\nghi  y   EOS word boundary
ok $test_str ~~ /ghi<?WB>/, 'EOS word boundary';

#### a<?wb>         abc\ndef\n-==\nghi  n   \w\w word boundary
ok $test_str !~~ /a<?WB>/, '\w\w word boundary';

#### \-<?wb>            abc\ndef\n-==\nghi  n   \W\W word boundary
ok $test_str !~~ /\-<?WB>/, '\W\W word boundary';

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading ! indicates">

#### <!wb>def       abc\ndef\n-==\nghi  n   nonword boundary \W\w
ok $test_str !~~ /<!WB>def/, 'nonword boundary \W\w';

#### abc<!wb>       abc\ndef\n-==\nghi  n   nonword boundary \w\W
ok $test_str !~~ /abc<!WB>/, 'nonword boundary \w\W';

#### <!wb>abc       abc\ndef\n-==\nghi  n   BOS nonword boundary
ok $test_str !~~ /<!WB>abc/, 'BOS nonword boundary';

#### ghi<!wb>       abc\ndef\n-==\nghi  n   EOS nonword boundary
ok $test_str !~~ /ghi<!WB>/, 'EOS nonword boundary';

#### a<!wb>         abc\ndef\n-==\nghi  y   \w\w nonword boundary
ok $test_str ~~ /a<!WB>/, '\w\w nonword boundary';

#### \-<!wb>            abc\ndef\n-==\nghi  y   \W\W nonword boundary
ok $test_str ~~ /\-<!WB>/, '\W\W nonword boundary';


