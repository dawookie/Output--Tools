use Test::More 'no_plan';
use IO::String;

BEGIN { use_ok('Output::Tools') }

is( $Output::Tools::debug,   0, '$debug:         is off by default' );
is( $Output::Tools::verbose, 0, '$verbose:       is off by default' );

is( debug_status(),   0, 'debug_status:   is reported as off' );
is( verbose_status(), 0, 'verbose_status: is reported as off' );

debug_on();
is( $Output::Tools::debug, 1, '$debug:         is turned on by debug_on()' );
is( debug_status(),   1, 'debug_status:   is reported as on' );

debug_off();
is( $Output::Tools::debug, 0, '$debug:         is turned on by debug_off()' );
is( debug_status(),   0, 'debug_status:   is reported as off' );

verbose_on();
is( $Output::Tools::verbose, 1, '$verbose:         is turned on by verbose_on()' );
is( verbose_status(), 1, 'verbose_status: is reported as on' );

verbose_off();
is( $Output::Tools::verbose, 0, '$verbose:         is turned on by verbose_off()' );
is( verbose_status(), 0, 'verbose_status: is reported as off' );



my $add_io = IO::String->new;

TODO: {
    local $TODO = 'I have not got this part down yet';
    verbose_off();
    debug_off();
    my $old_handle = select($add_io);
    verbose_output('This is a verbose test with verbose off and debug off');
    select($old_handle);
    like(
        ${ $add_io->string_ref },
        qr|This is a verbose test with verbose off and debug off|,
        'Got verbose string'
    );

    select($add_io);
    debug_output('This is a debug test with verbose off and debug off');
    select($old_handle);

    unlike(
        ${ $add_io->string_ref },
        qr|This is a debug test with verbose off and debug off|,
        'Did not get debug string'
    );

    verbose_on();
    debug_off();
    select($add_io);
    verbose_output('This is a verbose test with $verbose on and $debug off');
    select($old_handle);

    verbose_off();
    debug_on();
    select($add_io);
    verbose_output('This is a verbose test with $verbose off and $debug on');
    select($old_handle);

    verbose_on();
    debug_on();
    select($add_io);
    verbose_output('This is a verbose test with $verbose on and $debug on');
    select($old_handle);

    #like(
    #  ${$add_io->string_ref},
    #  qr|Location:|,
    #  q|got application redirect|
    #);

    undef $add_io;
}
