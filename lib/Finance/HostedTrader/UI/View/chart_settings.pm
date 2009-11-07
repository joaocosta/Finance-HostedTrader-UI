package Finance::HostedTrader::UI::View::chart_settings;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
            TEMPLATE_EXTENSION => '.tt',
            INCLUDE_PATH => Finance::HostedTrader::UI->path_to('root', 'ttemplates'),
            TIMER => 1,
        );

=head1 NAME

Finance::HostedTrader::UI::View::chart_settings - TT View for Finance::HostedTrader::UI

=head1 DESCRIPTION

TT View for Finance::HostedTrader::UI.

=head1 SEE ALSO

L<Finance::HostedTrader::UI>

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
