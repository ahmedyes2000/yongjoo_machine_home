
#
# GENERATED WITH PDL::PP! Don't modify!
#
package PDL::Bad;

@EXPORT_OK  = qw(  badflag check_badflag badvalue orig_badvalue nbad nbadover ngood ngoodover setbadat  PDL::PP isbad PDL::PP isgood PDL::PP nbadover PDL::PP ngoodover PDL::PP setbadif PDL::PP setvaltobad PDL::PP setnantobad PDL::PP setbadtonan PDL::PP setbadtoval PDL::PP copybad );
%EXPORT_TAGS = (Func=>[@EXPORT_OK]);

use PDL::Core;
use PDL::Exporter;
use DynaLoader;



   
   @ISA    = ( 'PDL::Exporter','DynaLoader' );
   push @PDL::Core::PP, __PACKAGE__;
   bootstrap PDL::Bad ;





=head1 NAME

PDL::Bad - PDL does process bad values

=head1 DESCRIPTION

PDL has been compiled with WITH_BADVAL set to 1. Therefore,
you can enter the wonderful world of bad value support in
PDL.

This module is loaded when you do C<use PDL>,
C<Use PDL::Lite> or C<PDL::LiteF>.

Implementation details are given in
L<PDL::BadValues>.

=head1 SYNOPSIS

 use PDL::Bad;
 print "\nBad value support in PDL is turned " .
     $PDL::Bad::Status ? "on" : "off" . ".\n";

 Bad value support in PDL is turned on.

 and some other things

=head1 VARIABLES

There are currently three variables that this module defines
which may be of use.

=over 4

=item $PDL::Bad::Status

Set to 1

=item $PDL::Bad::UseNaN

Set to 1 if PDL was compiled with C<BADVAL_USENAN> set,
0 otherwise.

=item $PDL::Bad::PerPdl

Set to 1 if PDL was compiled with the I<experimental>
C<BADVAL_PER_PDL> option set, 0 otherwise.

=back

=cut







=head1 FUNCTIONS



=cut





# really should be constants
$PDL::Bad::Status = 1;
$PDL::Bad::UseNaN = 0;
$PDL::Bad::PerPdl = 0;

use strict;

use PDL::Types;
use PDL::Primitive;

############################################################
############################################################



############################################################
############################################################

*badflag         = \&PDL::badflag;
*badvalue        = \&PDL::badvalue;
*orig_badvalue   = \&PDL::orig_badvalue;

############################################################
############################################################

=head2 badflag

=for ref

switch on/off/examine bad data flag

=for example

  if ( $a->badflag() ) {
    print "Data may contain bad values.\n";
  }
  $a->badflag(1);      # set bad data flag
  $a->badflag(0);      # unset bad data flag

A return value of 1 does not guarantee the presence of
bad data in a piddle; all it does is say that we need to
I<check> for the presence of such beasties. To actually
find out if there are any bad values present in a piddle,
use the L<check_badflag|/check_badflag> method.

=for bad

Does support bad values.

=head2 badvalue

=for ref

returns the value used to indicate a missing (or bad) element
for the given piddle type. You can give it a piddle,
a PDL::Type object, or one of C<$PDL_B>, C<$PDL_S>, etc.

=for example

   $badval = badvalue( float );
   $a = ones(ushort,10);
   print "The bad data value for ushort is: ",
      $a->badvalue(), "\n";

If a new value is supplied via a piddle (e.g. C<$a-E<gt>badvalue(23)>),
then the data in the supplied piddle is converted to use the new
bad value as well if the data type is an integer
or C<$PDL::Bad::UseNaN == 0>.

Currently there is no way of automatically converting the bad
values of already existing piddles. This could be supported - e.g.
by having a per-piddle bad value or by storing a time index in the piddle
structure - if required.

If the C<$PDL::Bad::PerPdl> flag is set then it is possible to
change the bad value on a per-piddle basis, so

    $a = sequence (10);
    $a->badvalue (3); $a->badflag (1);
    $b = sequence (10);
    $b->badvalue (4); $b->badflag (1);

will set $a to be C<[0 1 2 BAD 4 5 6 7 8 9]> and $b to be
C<[0 1 2 3 BAD 5 6 7 8 9]>. If the flag is not set then both
$a and $b will be set to C<[0 1 2 3 BAD 5 6 7 8 9]>. Please
note that the code to support per-piddle bad values is
I<experimental> in the current release.

=for bad

Does support bad values.

=head2 orig_badvalue

=for ref

returns the original value used to represent bad values for
a given type.

This routine operates the same as L<badvalue|/badvalue>,
except you can not change the values.

It also has an I<awful> name.

=for example

   $orig_badval = orig_badvalue( float );
   $a = ones(ushort,10);
   print "The original bad data value for ushort is: ", 
      $a->orig_badvalue(), "\n";

=for bad

Does support bad values.

=head2 check_badflag

=for ref

clear the bad-value flag of a piddle if it does not
contain any bad values

Given a piddle whose bad flag is set, check whether it
actually contains any bad values and, if not, clear the flag.
It returns the final state of the bad-value flag.

=for example

 print "State of bad flag == ", $pdl->check_badflag;

=for bad

Does support bad values.

=cut

*check_badflag = \&PDL::check_badflag;

sub PDL::check_badflag {
    my $pdl = shift;
    $pdl->badflag(0) if $pdl->badflag and $pdl->nbad == 0;
    return $pdl->badflag;
} # sub: check_badflag()




# note:
#  if sent a piddle, we have to change it's bad values
#  (but only if it contains bad values)
#  - there's a slight overhead in that the badflag is
#    cleared and then set (hence propogating to all
#    children) but we'll ignore that)
#  - we can ignore this for float/double types
#    since we can't change the bad value
#
sub PDL::badvalue {
    no strict 'refs';

    my ( $self, $val ) = @_;
    my $num;
    if ( UNIVERSAL::isa($self,"PDL") ) {
	$num = $self->get_datatype;
	if ( $num < 4 and defined($val) and $self->badflag ) {
	    $self->inplace->setbadtoval( $val );
	    $self->badflag(1);
	}

	if ($PDL::Config{BADVAL_PER_PDL}) {
	    my $name = "PDL::_badvalue_per_pdl_int$num";
	    if ( defined $val ) {
		return &{$name}($self, $val )->sclr;
	    } else {
		return &{$name}($self)->sclr;
	    }
	}

    } elsif ( UNIVERSAL::isa($self,"PDL::Type") ) {
	$num = $self->enum;
    } else {
        # assume it's a number
        $num = $self;
    }

    my $name = "PDL::_badvalue_int$num";
    if ( defined $val ) {
	return &{$name}( $val )->sclr;
    } else {
	return &{$name}()->sclr;
    }

} # sub: badvalue()

sub PDL::orig_badvalue {
    no strict 'refs';

    my $self = shift;
    my $num;
    if ( UNIVERSAL::isa($self,"PDL") ) {
	$num = $self->get_datatype;
    } elsif ( UNIVERSAL::isa($self,"PDL::Type") ) {
	$num = $self->enum;
    } else {
        # assume it's a number
        $num = $self;
    }

    my $name = "PDL::_default_badvalue_int$num";
    return &${name}();

} # sub: orig_badvalue()

############################################################
############################################################





=head2 isbad

=for sig

  Signature: (a(); int [o]b())



=for ref

Is a value bad?

Returns a 1 if the value is bad, 0 otherwise.
Also see L<isfinite|PDL::Math/isfinite>.

=for example

 $a = pdl(1,2,3);
 $a->badflag(1);
 set($a,1,$a->badvalue);
 $b = isbad($a);
 print $b, "\n";
 [0 1 0]



=for bad

isbad does handle bad values.
The output piddles will NOT have their bad-value flag set.


=cut






*isbad = \&PDL::isbad;




=head2 isgood

=for sig

  Signature: (a(); int [o]b())



=for ref

Is a value good?

Returns a 1 if the value is good, 0 otherwise.
Also see L<isfinite|PDL::Math/isfinite>.

=for example

 $a = pdl(1,2,3);
 $a->badflag(1);
 set($a,1,$a->badvalue);
 $b = isgood($a);
 print $b, "\n";
 [1 0 1]



=for bad

isgood does handle bad values.
The output piddles will NOT have their bad-value flag set.


=cut






*isgood = \&PDL::isgood;




=head2 nbadover

=for sig

  Signature: (a(n); int+ [o]b())


=for ref

Find the number of bad elements along the 1st dimension.

This function reduces the dimensionality of a piddle
by one by finding the number of bad elements
along the 1st dimension.

By using L<xchg|PDL::Slices/xchg> etc. it is possible to use
I<any> dimension.

=for usage

 $a = nbadover($b);

=for example

 $spectrum = nbadover $image->xchg(0,1)



=for bad

nbadover does handle bad values.
It will set the bad-value flag of all output piddles if the flag is set for any of the input piddles.


=cut






*nbadover = \&PDL::nbadover;




=head2 ngoodover

=for sig

  Signature: (a(n); int+ [o]b())


=for ref

Find the number of good elements along the 1st dimension.

This function reduces the dimensionality of a piddle
by one by finding the number of good elements
along the 1st dimension.

By using L<xchg|PDL::Slices/xchg> etc. it is possible to use
I<any> dimension.

=for usage

 $a = ngoodover($b);

=for example

 $spectrum = ngoodover $image->xchg(0,1)



=for bad

ngoodover does handle bad values.
It will set the bad-value flag of all output piddles if the flag is set for any of the input piddles.


=cut






*ngoodover = \&PDL::ngoodover;



=head2 nbad

=for ref

Returns the number of bad values in a piddle

=for usage

 $x = nbad($data);

=for bad

Does support bad values.

=cut

*nbad = \&PDL::nbad;
sub PDL::nbad {
	my($x) = @_; my $tmp;
	$x->clump(-1)->nbadover($tmp=PDL->nullcreate($x) );
	return $tmp->at();
}



=head2 ngood

=for ref

Returns the number of good values in a piddle

=for usage

 $x = ngood($data);

=for bad

Does support bad values.

=cut

*ngood = \&PDL::ngood;
sub PDL::ngood {
	my($x) = @_; my $tmp;
	$x->clump(-1)->ngoodover($tmp=PDL->nullcreate($x) );
	return $tmp->at();
}



=head2 setbadat

=for ref

Set the value to bad at a given position.

=for usage

 setbadat $piddle, @position

C<@position> is a coordinate list, of size equal to the
number of dimensions in the piddle.
This is a wrapper around L<set|PDL::Core/set> and is
probably mainly useful in test scripts!

=for example

 perldl> $x = sequence 3,4
 perldl> $x->setbadat 2,1
 perldl> p $x
 [
  [  0   1   2]
  [  3   4 BAD]
  [  6   7   8]
  [  9  10  11]
 ]

=for bad

Supports badvalues.

=cut

*setbadat = \&PDL::setbadat;
sub PDL::setbadat {
    barf 'Usage: setbadat($pdl, $x, $y, ...)' if $#_<1;
    my $self  = shift; 
    PDL::Core::set_c ($self, [@_], $self->badvalue);
    $self->badflag(1);
    return $self;
}





=head2 setbadif

=for sig

  Signature: (a(); int mask(); [o]b())


=for ref

Set elements bad based on the supplied mask, otherwise
copy across the data.

=for example

 $a = sequence(5,5);
 $a = $a->setbadif( $a % 2 );
 print "a badflag: ", $a->badflag, "\n";
 a badflag: 1

Unfortunately, this routine can I<not> be run inplace, since the
current implementation can not handle the same piddle used as
C<a> and C<mask> (eg C<$a-E<gt>inplace-E<gt>setbadif($a%2)> fails).

Also see L<setvaltobad|/setvaltobad> and L<setnantobad|/setnantobad>.



=for bad

The output always has its bad flag set, even if it does not contain
any bad values (use L<check_badflag|/check_badflag> to check
whether there are any bad values in the output). 
Any bad values in the input piddles are copied across to the output piddle.


=cut






*setbadif = \&PDL::setbadif;




=head2 setvaltobad

=for sig

  Signature: (a(); [o]b(); double value)


=for ref

Set bad all those elements which equal the supplied value.

=for example

 $a = sequence(10) % 3;
 $a->inplace->setvaltobad( 0 );
 print "$a\n";
 [BAD 1 2 BAD 1 2 BAD 1 2 BAD]

This is a simpler version of L<setbadif|/setbadif>, but this
function can be done inplace.  See L<setnantobad|/setnantobad>
if you want to convert NaN/Inf to the bad value.



=for bad

The output always has its bad flag set, even if it does not contain
any bad values (use L<check_badflag|/check_badflag> to check
whether there are any bad values in the output). 
Any bad values in the input piddles are copied across to the output piddle.


=cut






*setvaltobad = \&PDL::setvaltobad;




=head2 setnantobad

=for sig

  Signature: (a(); [o]b())


=for ref

Sets NaN/Inf values in the input piddle bad
(only relevant for floating-point piddles).
Can be done inplace.

=for usage

 $b = $a->setnantobad;
 $a->inplace->setnantobad;



=for bad

Supports bad values.

=cut






*setnantobad = \&PDL::setnantobad;




=head2 setbadtonan

=for sig

  Signature: (a(); [o]b())


=for ref

Sets Bad values to NaN
(only relevant for floating-point piddles).
Can be done inplace and it clears the bad flag.

=for usage

 $b = $a->setbadtonan;
 $a->inplace->setbadtonan;



=for bad

Supports bad values.

=cut






*setbadtonan = \&PDL::setbadtonan;




=head2 setbadtoval

=for sig

  Signature: (a(); [o]b(); double newval)


=for ref

Replace any bad values by a (non-bad) value. 

Can be done inplace. Also see
L<badmask|PDL::Math/badmask>.

=for example

 $a->inplace->setbadtoval(23); 
 print "a badflag: ", $a->badflag, "\n";
 a badflag: 0



=for bad

The output always has its bad flag cleared.
If the input piddle does not have its bad flag set, then
values are copied with no replacement.


=cut






*setbadtoval = \&PDL::setbadtoval;




=head2 copybad

=for sig

  Signature: (a(); mask(); [o]b())


=for ref

Copies values from one piddle to another, setting them
bad if they are bad in the supplied mask.

Can be done inplace.

=for example

 $a = byte( [0,1,3] );
 $mask = byte( [0,0,0] );
 set($mask,1,$mask->badvalue);
 $a->inplace->copybad( $mask );
 p $a;
 [0 BAD 3]

It is equivalent to:

 $c = $a + $mask * 0



=for bad

Handles bad values.

=cut






*copybad = \&PDL::copybad;


;


=head1 CHANGES

The I<experimental> C<BADVAL_PER_PDL> configuration option,
which - when set - allows per-piddle bad values, was added
after the 2.4.2 release of PDL.
The C<> variable can be
inspected to see if this feature is available.



=head1 AUTHOR

Doug Burke (djburke@cpan.org), 2000, 2001, 2003, 2006.

The per-piddle bad value support is by Heiko Klein (2006).

All rights reserved. There is no warranty. You are allowed to
redistribute this software / documentation under certain conditions. For
details, see the file COPYING in the PDL distribution. If this file is
separated from the PDL distribution, the copyright notice should be
included in the file.



=cut





# Exit with OK status

1;

		   