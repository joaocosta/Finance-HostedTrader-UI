package Finance::HostedTrader::UI::Controller::Signal;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Finance::HostedTrader::UI::Controller::Signal - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub signal : Global {
    my ( $self, $c, @args ) = @_;

}

sub end : Private {
    my ( $self, $c ) = @_;
    $c->forward('View::TT');
}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
