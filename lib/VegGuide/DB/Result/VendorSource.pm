use utf8;
package VegGuide::DB::Result::VendorSource;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

VegGuide::DB::Result::VendorSource

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

=head1 TABLE: C<VendorSource>

=cut

__PACKAGE__->table("VendorSource");

=head1 ACCESSORS

=head2 vendor_source_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 display_uri

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 feed_uri

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 filter_class

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 last_processed_datetime

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1
  timezone: 'local'

=cut

__PACKAGE__->add_columns(
  "vendor_source_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "display_uri",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "feed_uri",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "filter_class",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "last_processed_datetime",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
    timezone => "local",
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</vendor_source_id>

=back

=cut

__PACKAGE__->set_primary_key("vendor_source_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<VendorSource___feed_uri>

=over 4

=item * L</feed_uri>

=back

=cut

__PACKAGE__->add_unique_constraint("VendorSource___feed_uri", ["feed_uri"]);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-11-09 14:48:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JejzMdrW4juL/GjU6uAJtQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;