# -*- cperl -*-

use warnings;
use strict;

use Test::More tests => 31;
use Lingua::FreeLing::Bindings;
use Lingua::FreeLing::ConfigData;
use Data::Dumper;

use File::Spec::Functions 'catfile';

my $prefix = Lingua::FreeLing::ConfigData->config('prefix');

my $tokenizer = Lingua::FreeLing::Bindings::tokenizer->new(catfile($prefix => 'share'
                                                                   => 'FreeLing' => 'es' =>
                                                                   'tokenizer.dat'));

isa_ok($tokenizer => 'Lingua::FreeLing::Bindings::tokenizer');

can_ok($tokenizer => 'tokenize');

my $words = $tokenizer->tokenize("Los sindicatos logran que la reforma de las pensiones acordada hoy con el Gobierno tenga en cuenta la debilidad de dos colectivos clave: mujeres y jóvenes");

is(scalar(@$words) => 27);
for my $word (@$words) {
    isa_ok($word => 'Lingua::FreeLing::Bindings::word');
}

my @real_words = map { $_->get_form } @$words;

is_deeply(\@real_words, [qw"Los sindicatos logran que la reforma de las pensiones acordada hoy con el Gobierno tenga en cuenta la debilidad de dos colectivos clave : mujeres y jóvenes"]);
