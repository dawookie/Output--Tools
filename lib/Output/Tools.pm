package Output::Tools;

use 5.006000;
use strict;
use warnings;
use Carp qw(carp croak);


require Exporter;
use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

our %EXPORT_TAGS = (
    'all' => [
        qw(

            )
    ]
);

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
    verbose_status
    verbose_on
    verbose_off
    verbose_output
    debug_status
    debug_off
    debug_on
    debug_output
);

our $VERSION = '0.1.6';
our $debug   = 0;
our $verbose = 0;

=head1 NAME

Output::Tools - Perl extension debugging and verbose output.

=head1 SYNOPSIS

  use Output::Tools;
  debug_on();
  verbose_on();
  
  verbose_output('Anything you want printed');
  debug_output('Anything you want printed');

  debug_off();
  verbose_off();
  
=head1 DESCRIPTION

A cheap implementation to allow consistant output methods for verbose 
and/or debugging output.

=head2 EXPORT

$verbose

$debug

verbose_on()

verbose_off()

verbose_output()

debug_off()

debug_on()

debug_output()

=cut

=head2 verbose_on

Called to turn on verbose reporting.

=cut

sub verbose_on {
    $verbose = 1;
}

=head2 verbose_off

Called to turn off verbose reporting.

=cut

sub verbose_off {
    $verbose = 0;
}

=head2 verbose_status

Called to check if verbose is turned on.

=cut

sub verbose_status {
    return $verbose;

}


=head2 verbose_output

Outputs a string if the verbose or debug flag is set. 

=cut

sub verbose_output($) {
    if ( $debug || $verbose ) {
        print "\n";
        print @_;
        print "\n";
    }
}

=head2 debug_on

Called to turn on debugging output

=cut

sub debug_on {
    $debug = 1;
}

=head2 debug_off

Called to turn on debugging output

=cut

sub debug_off {
    $debug = 0;

}

=head2 debug_status

Called to check if debug is turned on.

=cut

sub debug_status {
    return $debug;

}


=head2 debug_output

Outputs the calling subroutine and a string if the debug flag is set. 

=cut

sub debug_output($) {
    if ($debug) {
        my @_debug_output = @_;
        my $_called_by    = caller(0);
        carp "$_called_by";
        carp @_debug_output;
    }
}

1;
__END__

=head1 AUTHOR

Rik Schneider, E<lt>rik@deranged.schneider.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Rik Schneider

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.6.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
