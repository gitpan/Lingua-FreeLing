package Lingua::FreeLing::Sentence;
use Lingua::FreeLing::Word;

use warnings;
use strict;

our $VERSION = "0.01";

=encoding UTF-8

=head1 NAME

Lingua::FreeLing::Sentence - Interface to FreeLing Sentence object

=head1 SYNOPSIS

   use Lingua::FreeLing::Sentence;

   my $words = $sentence->words;

   my $sentence = $sentence->to_text;

=head1 DESCRIPTION

This module is a wrapper to the FreeLing Sentence object (a list of
words, that someone has validated as a complete sentence.

=head2 CONSTRUCTOR

=over 4

=item C<new>

The constructor returns a new Sentence object. As no setters are
available (for now), it is not really relevant. Tests are being done
to understand how to set/add words in the sentence.

=back

=cut

sub new {
    my $class = shift;
    return bless { sentence => Lingua::FreeLing::Bindings::sentence->new() } => $class;
}

sub _new_from_binding {
    my ($class, $sentence) = @_;
    return bless { sentence => $sentence } => $class;
}

=head2 ACESSORS

Current sentence acessors are:

=over 4

=item C<words>

Returns a reference to a list of L<Lingua::FreeLing::Word>.

=cut

sub words {
    my $self = shift;
    my $words = $self->{sentence}->get_words;
    for (@$words) {
        $_ = Lingua::FreeLing::Word->_new_from_binding($_);
    }
    return $words;
}

=item C<is_parsed>

Returns a boolean value stating if the sentence has been parsed or
not.

=cut

sub is_parsed {
    my $self = shift;
    return $self->{sentence}->is_parsed;
}


=item C<to_text>

Returns a string with words separated by a blank space.

=cut

sub to_text {
    my $self = shift;
    my $words = $self->{sentence}->get_words;
    return join(" " => map { $_->get_form } @$words);
}


# XXX - TODO
# *set_parse_tree = *Lingua::FreeLing::Bindingsc::sentence_set_parse_tree;
# *get_parse_tree = *Lingua::FreeLing::Bindingsc::sentence_get_parse_tree;
# *get_dep_tree = *Lingua::FreeLing::Bindingsc::sentence_get_dep_tree;
# *set_dep_tree = *Lingua::FreeLing::Bindingsc::sentence_set_dep_tree;
# *is_dep_parsed = *Lingua::FreeLing::Bindingsc::sentence_is_dep_parsed;
# *words_begin = *Lingua::FreeLing::Bindingsc::sentence_words_begin;
# *words_end = *Lingua::FreeLing::Bindingsc::sentence_words_end;

1;

__END__

=back

=head1 SEE ALSO

Lingua::FreeLing(3) for the documentation table of contents. The
freeling library for extra information, or perl(1) itself.

=head1 AUTHOR

Alberto Manuel Brandão Simões, E<lt>ambs@cpan.orgE<gt>

Jorge Cunha Mendes E<lt>jorgecunhamendes@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Projecto Natura

=cut


