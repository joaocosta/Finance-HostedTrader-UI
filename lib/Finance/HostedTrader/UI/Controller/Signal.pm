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

sub parse :Local {
    my ( $self, $c, @args ) = @_;
    my $db = Finance::HostedTrader::Datasource->new();
    my $signal_processor = Finance::HostedTrader::ExpressionParser->new($db);
    my $args = $c->request->query_params;

    my $timeframe  = $args->{'t'} || 'day';
    my $expr = $args->{'e'};

    $c->response->content_type('application/json');

    my ($max_loaded_items, $max_display_items, $symbols_txt) = (1000, 1);
    my $symbols = $db->getNaturalSymbols;
    my @results;
    foreach my $symbol (@{$symbols}) {
        my $data = $signal_processor->getIndicatorData({ 
								    'expr'   => $expr, 
								    'symbol' => $symbol, 
								    'tf'     => $timeframe, 
								    'maxLoadedItems' => $max_loaded_items, 
								    'maxDisplayItems' => $max_display_items,
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

    $c->response->write(to_json($obj));
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
