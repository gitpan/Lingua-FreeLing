package Lingua::FreeLing::Word;

use warnings;
use strict;

use Lingua::FreeLing::Bindings;
use Lingua::FreeLing::Word::Analysis;

our $VERSION = "0.01";

=encoding UTF-8

=head1 NAME

Lingua::FreeLing::Word - Interface to FreeLing Word object

=head1 SYNOPSIS

   use Lingua::FreeLing::Word;

   my $empty_word = Lingua::FreeLing::Word->new;
   my $hello_word = Lingua::FreeLing::Word->new('hello');

=head1 DESCRIPTION

=head2 CONSTRUCTOR

=over 4

=item C<new>

The C<new> constructor returns a new C<Lingua::FreeLing::Word>
object. If a parameter is passed, it is interpreted as the word form,
and it is automatically set. Otherwise, an empty word object is
returned.

=back

=cut

sub new {
    my ($class, $word) = @_;
    if ($word) {
        $word = Lingua::FreeLing::Bindings::word->new($word);
    } else {
        $word = Lingua::FreeLing::Bindings::word->new();
    }
    return bless { word => $word } => $class;
}

sub _new_from_binding {
    my ($class, $word) = @_;
    return bless { word => $word } => $class;
}


=head2 ACESSORS

The word object has some simple accessors to retrieve some
information:

=over 4

=item C<to_hash>

Returns a reference to a hash with the form, lemma and parole (POS) of
the word.

=cut

sub to_hash {
    my $self = shift;
    return +{
             form   => $self->form,
             lemma  => $self->lemma,
             parole => $self->parole,
            };
}

=item C<lemma>

Returns the word C<lemma>, if set. Note that this value can't be set
directly. You can create word analysis, associate them to the word,
and then select the desired analysis (setting up the lemma value).

  my $word_lemma = $word->lemma;

=cut

sub lemma {
    my $self = shift;
    return $self->{word}->get_lemma;
}

=item C<parole>

Returns the word C<parole> (POS), if set. Again, note that this value
can't be set directly. You can create word analysis, associate them to
the word, and then select the desired analysis (setting up the parole
value).

  my $word_pos = $word->parole;

=cut

sub parole {
    my $self = shift;
    return $self->{word}->get_parole;
}

=item C<analysis>

Returns a list of possible analysis. You can pass an extra option
C<FeatureStructure> to obtain the analysis as a list of hashes (list
of feature structures), instead of L<Lingua::FreeLing::Word::Analysis>
objects.

  my $list = $word->analysis(FeatureStructure => 1);

B<TODO:> it is missing the option to add an analysis, or set the full
set at once.

=back

=cut

# XXX - Missing
# *add_analysis = *Lingua::FreeLing::Bindingsc::word_add_analysis;
# *set_analysis = *Lingua::FreeLing::Bindingsc::word_set_analysis;
sub analysis {
    my ($self, %ops) = @_;
    my $analysis_list = $self->{word}->get_analysis;
    for (@$analysis_list) {
        $_ = Lingua::FreeLing::Word::Analysis->_new_from_binding($_);
        if (defined($ops{FeatureStructure})) {
            $_ = $_->to_hash;
        }
    }
    return $analysis_list;
}


=head2 ACESSORS/SETTER

The following accessors also work as setters if an extra argument is
supplied.

   my $word_form = $word->form;

=over 4

=item C<form>

=back

=cut

sub form {
    my $self = shift @_;
    if ($_[0]) {
        $self->{word}->set_form(shift @_)
    } else {
        $self->{word}->get_form;
    }
}

=head2 TODO

There are a lot of methods to interface with the Word object that are
currently not implemented. They should be made available as soon as
there is time.

=cut

# *get_n_selected = *Lingua::FreeLing::Bindingsc::word_get_n_selected;
# *get_n_unselected = *Lingua::FreeLing::Bindingsc::word_get_n_unselected;
# *is_multiword = *Lingua::FreeLing::Bindingsc::word_is_multiword;
# *get_n_words_mw = *Lingua::FreeLing::Bindingsc::word_get_n_words_mw;
# *get_words_mw = *Lingua::FreeLing::Bindingsc::word_get_words_mw;
# *selected_begin = *Lingua::FreeLing::Bindingsc::word_selected_begin;
# *selected_end = *Lingua::FreeLing::Bindingsc::word_selected_end;
# *unselected_begin = *Lingua::FreeLing::Bindingsc::word_unselected_begin;
# *unselected_end = *Lingua::FreeLing::Bindingsc::word_unselected_end;
# *get_short_parole = *Lingua::FreeLing::Bindingsc::word_get_short_parole;
# *get_senses_string = *Lingua::FreeLing::Bindingsc::word_get_senses_string;
# *get_span_start = *Lingua::FreeLing::Bindingsc::word_get_span_start;
# *get_span_finish = *Lingua::FreeLing::Bindingsc::word_get_span_finish;
# *found_in_dict = *Lingua::FreeLing::Bindingsc::word_found_in_dict;
# *set_found_in_dict = *Lingua::FreeLing::Bindingsc::word_set_found_in_dict;
# *has_retokenizable = *Lingua::FreeLing::Bindingsc::word_has_retokenizable;
# *set_span = *Lingua::FreeLing::Bindingsc::word_set_span;
# *find_tag_match = *Lingua::FreeLing::Bindingsc::word_find_tag_match;
# *copy_analysis = *Lingua::FreeLing::Bindingsc::word_copy_analysis;
# *select_analysis = *Lingua::FreeLing::Bindingsc::word_select_analysis;
# *unselect_analysis = *Lingua::FreeLing::Bindingsc::word_unselect_analysis;
# *get_n_analysis = *Lingua::FreeLing::Bindingsc::word_get_n_analysis;
# *unselect_all_analysis = *Lingua::FreeLing::Bindingsc::word_unselect_all_analysis;
# *select_all_analysis = *Lingua::FreeLing::Bindingsc::word_select_all_analysis;
# *analysis_begin = *Lingua::FreeLing::Bindingsc::word_analysis_begin;
# *analysis_end = *Lingua::FreeLing::Bindingsc::word_analysis_end;

1;

__END__

=head1 SEE ALSO

Lingua::FreeLing(3) for the documentation table of contents. The
freeling library for extra information, or perl(1) itself.

=head1 AUTHOR

Alberto Manuel Brandão Simões, E<lt>ambs@cpan.orgE<gt>

Jorge Cunha Mendes E<lt>jorgecunhamendes@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Projecto Natura

=cut


