use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Finance::HostedTrader::UI' }
BEGIN { use_ok 'Finance::HostedTrader::UI::Controller::Download' }

ok( request('/download')->is_success, 'Request should succeed' );


