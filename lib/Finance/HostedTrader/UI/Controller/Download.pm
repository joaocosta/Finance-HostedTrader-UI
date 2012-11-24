package Finance::HostedTrader::UI::Controller::Download;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Finance::HostedTrader::UI::Controller::Download - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(1) {
    my ( $self, $c, $symbol ) = @_;

    my $args = $c->request->query_params;
    my $timeframe  = $args->{'t'} || 'day';

    my $filename = "$symbol\_$timeframe.zip";
    my $fullpath = "/home/joao/download/$filename";

    $c->response->content_type('multipart/x-zip');
    $c->response->headers->content_length( -s $fullpath );
#    $c->response->headers->last_modified( $stat->mtime );
    $c->response->headers->header('Content-disposition:' => qq[attachment; filename="$filename"] );
    $c->response->headers->expires( time() );
#    $c->response->headers->header( 'Last-Modified' => HTTP::Date::time2str);
    $c->response->headers->header( 'Pragma'        => 'no-cache' );
    $c->response->headers->header( 'Cache-Control' => 'no-cache' );

    open my $fh, '<', $fullpath or die("Cannot open $fullpath for reading");
    while(1) {
        my $data;
        my $read = read($fh, $data, 65536);
        die($!) unless(defined($read));
        last unless($read);
        $c->response->write( $data );
    }
    close($fh);
}

#Override the Root.pm end action so that
#no view is rendered
sub end : Private {
    my ( $self, $c ) = @_;

}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
