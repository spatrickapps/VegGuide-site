package VegGuide::Controller::Base;

use strict;
use warnings;

use base 'Catalyst::Controller';

# Normally I'd inherit from this class, but that seems to magically
# break handling of "normal" views (the various *_GET_html
# methods). Instead we'll manually "import" the handy status related
# methods it provides, which is pretty lame.
use Catalyst::Controller::REST;

BEGIN
{
    for my $meth ( qw( status_ok status_created status_accepted
                       status_bad_request status_not_found ) )
    {
        no strict 'refs';
        *{ __PACKAGE__ . '::' . $meth } = \&{ 'Catalyst::Controller::REST::' . $meth };
    }
}

use Alzabo::Runtime::UniqueRowCache;
use HTTP::Status qw( RC_UNAUTHORIZED );
use URI::Escape qw( uri_unescape );
use URI::FromHash qw( uri );
use VegGuide::AlzaboWrapper;
use VegGuide::Javascript;
use VegGuide::JSON;
use VegGuide::Util qw( string_is_empty );


sub begin : Private
{
    my $self = shift;
    my $c    = shift;

    Alzabo::Runtime::UniqueRowCache->clear();
    VegGuide::AlzaboWrapper->ClearCache();

    # Always authenticate to make sure we have some sort of user
    # object available. This will be a guest object if the user hasn't
    # logged in yet, but we don't want $c->user() returning undef.
    $c->authenticate( {} )
        unless $c->user();

    return unless $c->request()->looks_like_browser();

    VegGuide::Javascript->CreateSingleFile()
        unless VegGuide::Config->IsProduction() || VegGuide::Config->Profiling();

    my $response = $c->response();
    $response->breadcrumbs()->add( uri  => '/',
                                   label => 'VegGuide.Org',
                                 );

    for my $type ( 'RSS', 'Atom' )
    {
        my $ct = 'application/' . lc $type . '+xml';

        $response->alternate_links()->add
            ( mime_type => $ct,
              title     => "VegGuide.Org: Sitewide Recent Changes",
              uri       => uri( path => '/site/recent.' . lc $type ),
            );
    }

    return 1;
}

sub end : Private
{
    my $self = shift;
    my $c    = shift;

    return $self->NEXT::end($c)
        if $c->stash()->{rest};

    if ( ( ! $c->response()->status()
           || $c->response()->status() == 200 )
         && ! $c->response()->body()
         && ! @{ $c->error() || [] } )
    {
        $c->forward( $c->view() );
    }

    return;
}

sub _require_auth
{
    my $self = shift;
    my $c    = shift;
    my $msg  = shift;

    return if $c->vg_user()->is_logged_in();

    $c->_redirect_with_error
        ( error  => $msg,
          status => RC_UNAUTHORIZED,
          uri    => '/user/login_form',
          params => { return_to => $c->request()->uri() },
        );
}

sub _params_from_path_query
{
    my $self = shift;
    my $path = shift;

    return if string_is_empty($path);

    my %p;
    for my $kv ( split /;/, $path )
    {
        my ( $k, $v ) = map { uri_unescape($_) } split /=/, $kv;

        if ( $p{$k} )
        {
            if ( ref $p{$k} )
            {
                push @{ $p{$k} }, $v;
            }
            else
            {
                $p{$k} = [ $p{$k}, $v ];
            }
        }
        else
        {
            $p{$k} = $v;
        }
    }

    return %p;
}


sub _set_entity
{
    my $self   = shift;
    my $c      = shift;
    my $entity = shift;

    $c->response()->body( VegGuide::JSON->Encode($entity) );

    return 1;
}


1;
