# -*- cperl -*-
use Test::More tests => 17;

use warnings;
use strict;

BEGIN {
    use_ok( 'Lingua::FreeLing' );
    use_ok( 'Lingua::FreeLing::Bindings' );
    use_ok( 'Lingua::FreeLing::Tokenizer' );
    use_ok( 'Lingua::FreeLing::Splitter' );
    use_ok( 'Lingua::FreeLing::Word' );
    use_ok( 'Lingua::FreeLing::Sentence' );
    use_ok( 'Lingua::FreeLing::MorphAnalyzer' );
    use_ok( 'Lingua::FreeLing::Word::Analysis' );
    use_ok( 'Lingua::FreeLing::HMMTagger' );
}

diag( "Testing Lingua::FreeLing $Lingua::FreeLing::VERSION" );

ok($Lingua::FreeLing::VERSION                 => "version defined for FreeLing.pm");
ok($Lingua::FreeLing::Word::Analysis::VERSION => "version defined for Word::Analysis.pm");
ok($Lingua::FreeLing::Tokenizer::VERSION      => "version defined for Tokenizer.pm");
ok($Lingua::FreeLing::Splitter::VERSION       => "version defined for Splitter.pm");
ok($Lingua::FreeLing::Word::VERSION           => "version defined for Word.pm");
ok($Lingua::FreeLing::Sentence::VERSION       => "version defined for Sentence.pm");
ok($Lingua::FreeLing::MorphAnalyzer::VERSION  => "version defined for MorphAnalyzer.pm");
ok($Lingua::FreeLing::HMMTagger::VERSION      => "version defined for HMMTagger.pm");

