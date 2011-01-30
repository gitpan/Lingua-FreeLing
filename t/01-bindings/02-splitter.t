# -*- cperl -*-

use warnings;
use strict;

use Test::More tests => 7;
use Lingua::FreeLing::Bindings;
use Lingua::FreeLing::ConfigData;
use Data::Dumper;

use File::Spec::Functions 'catfile';

my $prefix = Lingua::FreeLing::ConfigData->config('prefix');
my $splitter = Lingua::FreeLing::Bindings::splitter->new(catfile($prefix => 'share'
                                                                 => 'FreeLing' => 'es' =>
                                                                 'splitter.dat'));

my $tokenizer = Lingua::FreeLing::Bindings::tokenizer->new(catfile($prefix => 'share'
                                                                   => 'FreeLing' => 'es' =>
                                                                   'tokenizer.dat'));

isa_ok($splitter => 'Lingua::FreeLing::Bindings::splitter');
can_ok($splitter => 'split');

my $text = <<EOT;
Retrasar la edad de jubilación y ampliar el número de años para poder
retirarse a los 65 con la pensión completa se ceba especialmente con
jóvenes y mujeres. Los primeros, en la actualidad, se incorporan más
tarde al mercado laboral tras finalizar sus estudios y son víctimas de
un alto paro juvenil y de una alta tasa de temporalidad. Las segundas,
además de tener una menor tasa de actividad, en muchos casos
interrumpen sus carreras de cotización (es decir, dejan de trabajar)
para cuidar de sus hijos al nacer. La consecuencia de esta situación
es que ambos colectivos se encontrarán lagunas de cotización.
EOT

my $words = $tokenizer->tokenize($text);
my $split = $splitter->split($words, 1);

my $all_words = 1;
for my $sentence (@$split) {
    isa_ok($sentence, 'Lingua::FreeLing::Bindings::sentence');
    my $list_of_words = $sentence->get_words;
    for my $w (@$list_of_words) {
        $all_words = 0 unless ref($w) eq "Lingua::FreeLing::Bindings::word";
    }
}
ok($all_words);
