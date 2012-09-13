use strict;
use warnings;

use Test::More;
use Config::Any::TT2;

if ( !Config::Any::TT2->is_supported ) {
    plan skip_all => 'TT2 format not supported';
}
else {
    plan tests => 8;
}

{
    my $config = Config::Any::TT2->load( 't/conf/conf.tt2' );
    ok( $config );
    is( $config->{ name }, 'TestApp' );
}

# test invalid options
{
    my $config = eval {
        Config::Any::TT2->load( 't/conf/conf.tt2', { AUTO_RESET => 1 } );
    };
    ok( !$config, 'unsupported option' );
    ok( $@,       "error thrown ($@)" );
}

{
    my $config = eval {
        Config::Any::TT2->load( 't/conf/conf.tt2', { INCLUDE_PATH => '/tmp', } );
    };
    ok( !$config, 'wrong include path' );
    ok( $@,       "error thrown ($@)" );
}

# test invalid config
{
    my $file = 't/invalid/conf.tt2';
    my $config = eval { Config::Any::TT2->load( $file ) };

    ok( !$config, 'config load failed' );
    ok( $@,       "error thrown ($@)" );
}
