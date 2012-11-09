use utf8;
package VegGuide::DB::Result::LocationOwner;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

VegGuide::DB::Result::LocationOwner

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<LocationOwner>

=cut

__PACKAGE__->table("LocationOwner");

=head1 ACCESSORS

=head2 location_id

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "location_id",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "user_id",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</location_id>

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("location_id", "user_id");


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-11-09 14:48:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WdJMGnbcqmVlkjHAWdP25Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
