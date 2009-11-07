use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Finance::HostedTrader::UI' }
BEGIN { use_ok 'Finance::HostedTrader::UI::Controller::Chart' }

ok( request('/chart')->is_success, 'Request should succeed' );


