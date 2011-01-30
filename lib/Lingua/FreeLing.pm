package Lingua::FreeLing;

use strict;
use warnings;

use Carp;
use Try::Tiny;
use Lingua::FreeLing::ConfigData;
use File::Spec::Functions 'catfile';

our $VERSION = "0.01_01";

sub _valid_option {
    my ($value, $type) = @_;
    return ($value && exists($type->{$value})) ? $type->{$value} : undef;
}

sub _valid_bool {
    my $value = shift;
    return $value ? 1 : 0;
}

sub _valid_prob {
    my $value = shift;
    if ($value =~ /(\d+(?:\.\d+)? | \.\d+)/x && $1 >= 0 && $1 <= 1) {
        return $1
    } else {
        carp "Setting weird value as a probability value.";
        return 0
    }
}

sub _search_language_dir {
    my $lang = lc(shift @_);
    my $prefix = Lingua::FreeLing::ConfigData->config('prefix');
    my $supposed_dir = catfile($prefix, qw.share FreeLing., $lang);
    return (-d $supposed_dir) ? $supposed_dir : undef;
}

sub _is_word_list {
    my $l = shift;
    return undef unless ref($l) eq "ARRAY";
    for my $w (@$l) {
        try {
            return 0 unless ($w->isa("Lingua::FreeLing::Word") ||
                             $w->isa("Lingua::FreeLing::Bindings::word"));
        } catch {
            return 0;
        }
    }
    return 1;
}

sub _is_sentence_list {
    my $l = shift;
    return undef unless ref($l) eq "ARRAY";
    for my $w (@$l) {
        my $fail = 0;
        try {
            $fail = 1 unless ($w->isa("Lingua::FreeLing::Sentence") ||
                              $w->isa("Lingua::FreeLing::Bindings::sentence"));
        } catch {
            $fail = 1;
        };
        return 0 if $fail
    }
    return 1;
}

!0;

__END__

=head1 NAME

Lingua::FreeLing - a library for language analysis.

=head1 DESCRIPTION

This module is a Perl wrapper to FreeLing C++ library.
You can check the details on this library visiting its webpage
L<http://nlp.lsi.upc.edu/freeling/>.

The module is divided into different submodules, each with different
purposes.

=head1 SEE ALSO

L<Lingua::FreeLing::Word>

L<Lingua::FreeLing::Splitter>

L<Lingua::FreeLing::Sentence>

L<Lingua::FreeLing::Tokenizer>

L<Lingua::FreeLing::Word::Analysis>

L<Lingua::FreeLing::HMMTagger>

L<Lingua::FreeLing::MorphAnalyzer>

=cut

