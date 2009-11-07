package Finance::HostedTrader::UI::Schema::Result::Audusd60;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("AUDUSD_60");
__PACKAGE__->add_columns(
  "datetime",
  {
    data_type => "DATETIME",
    default_value => undef,
    is_nullable => 0,
    size => 19,
  },
  "open",
  { data_type => "FLOAT", default_value => undef, is_nullable => 0, size => 32 },
  "low",
  { data_type => "FLOAT", default_value => undef, is_nullable => 0, size => 32 },
  "high",
  { data_type => "FLOAT", default_value => undef, is_nullable => 0, size => 32 },
  "close",
  { data_type => "FLOAT", default_value => undef, is_nullable => 0, size => 32 },
);
__PACKAGE__->set_primary_key("datetime");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-10-18 04:23:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yJctY/xGQB4Pi38YICXYKw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
