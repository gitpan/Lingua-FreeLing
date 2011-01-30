# -*- cperl -*-

use warnings;
use strict;

use Test::More tests => 1;
use Lingua::FreeLing::Sentence;

my $sentence = Lingua::FreeLing::Sentence->new();

ok($sentence);
