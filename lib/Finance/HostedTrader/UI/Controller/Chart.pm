package Finance::HostedTrader::UI::Controller::Chart;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use Finance::HostedTrader::ExpressionParser;

=head1 NAME

Finance::HostedTrader::UI::Controller::Chart - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub chart : Global {
    my ( $self, $c, @args ) = @_;

    my $symbol = $args[0] || 'AUDUSD';
    my $args = $c->request->query_params;
    my $timeframe  = $args->{'t'} || 'day';

    $c->stash->{template} = 'Chart.tt';
    $c->stash->{timeframe} = $timeframe;
    $c->stash->{symbol} = $symbol;
    $c->forward('View::TT');
}

sub settings :Local {
    my ( $self, $c ) = @_;
    my $args = $c->request->query_params;

    my $symbol     = $args->{'s'} || 'EURUSD';
    my $timeframe  = $args->{'t'} || 'day';
    my $overlays   = $args->{'o'};
    my $chart_count= $args->{'cc'};
    my $signals    = $args->{'sig'};

    my @events;

    my $signal_processor = Finance::HostedTrader::ExpressionParser->new();

    if (defined($signals) && $signals) {
        if (ref(\$signals) eq 'SCALAR') {
            $signals = [$signals];
        }

        foreach my $expr (@{$signals}) {
            my $dates = $signal_processor->getSignalData( {
                        'expr'            => $expr,
                        'symbol'          => $symbol, 
                        'tf'              => $timeframe, 
                });
            push @events, { key => 'A', desc => $expr, dates => $dates };
        }
    }

    my @charts;
    for my $cid (1..$chart_count) {
        my $a = $args->{'i'.$cid};
        if (ref(\$a) eq 'SCALAR') {
            $a = [$a];
        }
        push @charts, $a;
    }

    $c->response->content_type('text/xml');
    $c->stash->{template}   = 'chart/settings.tt';
    $c->stash->{symbol}     = $symbol;
    $c->stash->{timeframe}  = $timeframe;
    $c->stash->{overlays}   = $overlays;
    $c->stash->{charts} = \@charts;
    $c->stash->{timeframe} = $timeframe;
    $c->stash->{events} = \@events;
    $c->forward('View::chart');
}

sub data :Local {
    my ( $self, $c ) = @_;
    my $args = $c->request->query_params;

    my $symbol      = $args->{'s'} || 'EURUSD';
    my $timeframe   = $args->{'t'} || 'day';
    my $indicators  = $args->{'i'} || [];
    $indicators = [ $indicators ] if (ref(\$indicators) eq 'SCALAR');
    my ($max_loaded_items, $max_display_items) = (  5000, 500 );

    my $indicator_processor = Finance::HostedTrader::ExpressionParser->new();
    my $expr;
    $expr = "open,high,low,close";
    $expr.= ',' . join(',', @$indicators) if(scalar(@$indicators));

    my $data = $indicator_processor->getIndicatorData(
		{
                        'expr'            => $expr,
                        'symbol'          => $symbol, 
                        'tf'              => $timeframe, 
                        'maxLoadedItems'  => $max_loaded_items, 
                        'maxDisplayItems' => $max_display_items
		});

    $c->response->content_type('text/plain');

    foreach my $item (@$data) {
        $c->response->write(join(',', map {(defined($_) ? $_ : '')} @{$item})."\n");
    }
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
