package RWD;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    # Make sure we don't keep any choices from last time
    app->destroy_session;

    template 'index';
};

post "/quest" => sub {
    my $swallow = body_parameters->get( 'swallow' );

    # Save these so we have them when we ask for JSON later
    session name    => body_parameters->get( 'name' );
    session quest   => body_parameters->get( 'quest' );
    session swallow => $swallow;

    # Do we pass, or are we cast into the gorge?
    if( $swallow eq "kind") {
        template 'off-you-go';
    }
    else {
        template 'cast-into-gorge';
    }
};

get "/my-quest" => sub {
    send_as JSON => [
        name    => session->read( 'name' ),
        quest   => session->read( 'quest' ),
        swallow => session->read( 'swallow' ),
    ];
};

true;
