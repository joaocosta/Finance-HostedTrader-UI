package Finance::HostedTrader::UI::Schema::Result::Fruits;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("fruits");
__PACKAGE__->add_columns(
  "type",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 10,
  },
  "variety",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 0,
    size => 20,
  },
);
__PACKAGE__->set_primary_key("type", "variety");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-10-18 04:23:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iQ3gMOP2m4j7vzIhUbc2jA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
