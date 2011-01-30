# -*- cperl -*-

use warnings;
use strict;

use Test::More tests => 19;
use Test::Warn;
use Lingua::FreeLing::Splitter;
use Lingua::FreeLing::Tokenizer;
use Data::Dumper;


my $paragraph = <<"EOP";
Retrasar la edad de jubilación y ampliar el número de años para poder
retirarse a los 65 con la pensión completa se ceba especialmente con
jóvenes y mujeres. Los primeros, en la actualidad, se incorporan más
tarde al mercado laboral tras finalizar sus estudios y son víctimas de
un alto paro juvenil y de una alta tasa de temporalidad. Las segundas,
además de tener una menor tasa de actividad, en muchos casos
interrumpen sus carreras de cotización (es decir, dejan de trabajar)
para cuidar de sus hijos al nacer. La consecuencia de esta situación
es que ambos colectivos se encontrarán lagunas de cotización.
EOP



my $es_split = Lingua::FreeLing::Splitter->new("es");

# defined
ok($es_split);

# is a L::FL::Splitter
isa_ok($es_split => 'Lingua::FreeLing::Splitter');

# has a data file associated and a splitter
ok(exists($es_split->{datafile}));
ok(exists($es_split->{splitter}));

# the splitter is of the right class
isa_ok($es_split->{splitter} => 'Lingua::FreeLing::Bindings::splitter');

# ok, the object can split?
can_ok($es_split => 'split');

# tokenize of undef/empty/string is undef
warning_is
  { ok(!$es_split->split())  }
  {carped => "Error: split argument isn't a list of words"};

warning_is
  { ok(!$es_split->split("")) }
  {carped => "Error: split argument isn't a list of words"};

warning_is
  { ok(!$es_split->split($paragraph)) }
  {carped => "Error: split argument isn't a list of words"};

my $es_tok = Lingua::FreeLing::Tokenizer->new("es");
my $tokens = $es_tok->tokenize($paragraph);
my $sentences  = $es_split->split($tokens);

ok($sentences);
for my $s (@$sentences) {
    isa_ok($s => 'Lingua::FreeLing::Sentence');
}

my $text_sentences = $es_split->split($tokens, to_text => 1);
ok($text_sentences);
is($text_sentences->[0],
   "Retrasar la edad de jubilación y ampliar el número de años para poder retirarse a los 65 con la pensión completa se ceba especialmente con jóvenes y mujeres .");
