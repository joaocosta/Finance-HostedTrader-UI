package Finance::HostedTrader::UI::Controller::Signal;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::ExpressionParser;
use JSON;

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
    $c->forward('View::TT');
}

=method
lastclose

returns the last known close price of a symbol.
This method knows how to calculate synthetic symbols,
so it can get the close price of even exotic things such as GBPCAD, XAGNZD, etc.

Hardcoded to work with Forex symbols only.
=cut
sub lastclose :Local {
    my ( $self, $c, @args ) = @_;

    my $db = Finance::HostedTrader::Datasource->new();
    my $cfg = $db->cfg;
    my $args = $c->request->query_params;

    my $symbols = (defined($args->{'s'}) ? [ split( ',', $args->{'s'}) ] : $cfg->symbols->natural);
    my $jsonp_callback = $args->{'jsoncallback'};

    $c->response->content_type('application/json');
    my $timeframe = 300;#TODO hardcoded lowest available timeframe is 5min. Could look it up in the config object ($db->cfg) instead.

    my @results;
    foreach my $symbol (@{$symbols}) {
        push @results, $db->getLastClose( symbol => $symbol);
    }

    my $obj = {
        "ResultSet" => {
            "Total" => scalar(@results),
            "Result" => \@results,
        }
    };

    if ($jsonp_callback) {
        $c->response->write($jsonp_callback . '(' . to_json($obj) . ')');
    } else {
        $c->response->write(to_json($obj));
    }

}

sub parse :Local {
    my ( $self, $c, @args ) = @_;
    my $db = Finance::HostedTrader::Datasource->new();
    my $cfg = $db->cfg;
    my $signal_processor = Finance::HostedTrader::ExpressionParser->new($db);
    my $args = $c->request->query_params;

    my $timeframe  = $args->{'t'} || 'day';
    my $expr = 'datetime,'.$args->{'e'};
    my $symbols = (defined($args->{'s'}) ? [ split( ',', $args->{'s'}) ] : $cfg->symbols->natural);
    my $jsonp_callback = $args->{'jsoncallback'};

    $c->response->content_type('application/json');

    my ($max_loaded_items, $max_display_items, $symbols_txt) = (1000, 1);
    my @results;
    foreach my $symbol (@{$symbols}) {
        my $data = $signal_processor->getIndicatorData({ 
								    'fields' => $expr, 
								    'symbol' => $symbol, 
								    'tf'     => $timeframe, 
								    'maxLoadedItems' => $max_loaded_items, 
								    'numItems' => $max_display_items,
                                });
        next unless(defined($data));
        $data = $data->[0];
        next unless(defined($data));

        my %hash;
        $hash{symbol} = $symbol;
        for (my $i=0;$i<scalar(@$data);$i++) {
            $hash{"item$i"} = $data->[$i];
        }

        push @results, \%hash;
    }

    my $obj = {
        "ResultSet" => {
            "Total" => scalar(@results),
            "Result" => \@results,
        }
    };

    if ($jsonp_callback) {
        $c->response->write($jsonp_callback . '(' . to_json($obj) . ')');
    } else {
        $c->response->write(to_json($obj));
    }
}

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
