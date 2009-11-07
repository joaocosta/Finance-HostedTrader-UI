package Finance::HostedTrader::UI::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Finance::HostedTrader::UI::Controller::Root - Root Controller for Finance::HostedTrader::UI

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c, $args ) = @_;

    $c->stash->{template} = 'homepage.tt';
    $c->forward('View::TT');
}

sub symbol :Path :Args(1) {
    my ( $self, $c, $symbol ) = @_;

    my $args = $c->request->query_params;
    my $timeframe  = $args->{'t'} || 'day';

    $c->stash->{template} = 'Chart.tt';
    $c->stash->{timeframe} = $timeframe;
    $c->stash->{symbol} = $symbol;
    $c->forward('View::TT');
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
