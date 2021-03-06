package VegGuide::View::Mason;

use strict;
use warnings;

use parent 'Catalyst::View::HTML::Mason';

{
    package VegGuide::Mason;

    use Data::Dumper::Concise;
    use Image::Size qw( html_imgsize );
    use Lingua::EN::Inflect qw( PL );
    use List::AllUtils qw( all any first );
    use Math::Round qw( nearest );
    use Text::TOC 0.09;
    use Text::TOC::HTML;
    use URI::FromHash qw( uri );
    use VegGuide::JSON;
    use VegGuide::SiteURI qw( entry_uri entry_image_uri entry_review_uri
        news_item_uri region_uri user_uri site_uri
        static_uri );
    use VegGuide::Util qw( list_to_english string_is_empty );
}

# used in templates
use HTML::FillInForm;
use VegGuide::FillInFormBridge;

use File::Spec;
use VegGuide::Config;

__PACKAGE__->config( VegGuide::Config->MasonConfig() );

sub BUILD {
    my $self = shift;

    VegGuide::Util::chown_files_for_server(
        $self->interp()->files_written() );

    return;
}

sub has_template_for_path {
    my $self = shift;
    my $path = shift;

    return -f File::Spec->catfile(
        $self->config()->{interp_args}{comp_root},
        ( grep { defined && length } split /\//, $path ),
    );
}

1;

__END__

=head1 NAME

VegGuide::View::Mason - Catalyst View

=head1 SYNOPSIS

See L<VegGuide>

=head1 DESCRIPTION

Catalyst View.

=head1 AUTHOR

Dave Rolsky,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
