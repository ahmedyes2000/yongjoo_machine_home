
#
# GENERATED WITH PDL::PP! Don't modify!
#
package PDL::IO::Misc;

@EXPORT_OK  = qw(  rcols wcols swcols rgrep rdsa PDL::PP bswap2 PDL::PP bswap4 PDL::PP bswap8  isbigendian  rasc rcube PDL::PP _rasc );
%EXPORT_TAGS = (Func=>[@EXPORT_OK]);

use PDL::Core;
use PDL::Exporter;
use DynaLoader;



   
   @ISA    = ( 'PDL::Exporter','DynaLoader' );
   push @PDL::Core::PP, __PACKAGE__;
   bootstrap PDL::IO::Misc ;





=head1 NAME

PDL::IO::Misc - misc IO routines for PDL

=head1 DESCRIPTION

Some basic I/O functionality: FITS, tables, byte-swapping

=head1 SYNOPSIS

 use PDL::IO::Misc;

=cut







=head1 FUNCTIONS



=cut





use PDL::Primitive;
use PDL::Types;
use PDL::Options;
use PDL::Bad;
use Carp;
use Symbol qw/ gensym /;
use strict;





=head2 bswap2

=for sig

  Signature: (x(); )

=for ref

Swaps pairs of bytes in argument x()



=cut






*bswap2 = \&PDL::bswap2;




=head2 bswap4

=for sig

  Signature: (x(); )

=for ref

Swaps quads of bytes in argument x()



=cut






*bswap4 = \&PDL::bswap4;




=head2 bswap8

=for sig

  Signature: (x(); )

=for ref

Swaps octets of bytes in argument x()



=cut






*bswap8 = \&PDL::bswap8;




# ***CROCK*** Internal routine to extend 1D PDL array by size $n - dirty hack
# - needs a proper extend function rather than this nasty recreation
# - changed to ensure input/output piddles have the same type

sub ext1D {
   my ($a,$n) = @_;
   my $nold   = $a->getdim(0);
   my $b      = zeroes($a->type,$nold+$n);  # New pdl
   my $bb     = $b->slice("0:".($nold-1));
   $bb       .= $a;
   $_[0]      = $b;
1;}

# taken outside of rcols() to avoid clutter
sub _handle_types ($$$) {
    my $ncols = shift;
    my $deftype = shift;
    my $types = shift;

    barf "Unknown PDL type given for DEFTYPE.\n"
        unless ref($deftype) eq "PDL::Type";

    my @cols = ref($types) eq "ARRAY" ? @$types : ();
        
    if ( $#cols > -1 ) {
        # truncate if required
        $#cols = $ncols if $#cols > $ncols;
        
        # check input values are sensible
        for ( 0 .. $#cols ) {
            barf "Unknown value '$cols[$_]' in TYPES array.\n" 
                unless ref($cols[$_]) eq "PDL::Type";
        }
    }

    # fill in any missing columns
    for ( ($#cols+1) .. $ncols ) { push @cols, $deftype; }

    return @cols;
} # sub: _handle_types

=head2 rcols()

=for ref

Read ASCII whitespaced cols from a file into piddles and perl arrays
(also see L</rgrep()>).

There are two calling conventions - the old version, where
a pattern can be specified after the filename/handle, and the new
version where options are given as as hash reference. This 
reference can be given as either the second or last argument.

The default behaviour is to ignore lines beginning with a # character
and lines that only consist of whitespace. Options exist to only read
from lines that match, or do not match, supplied patterns, and
to set the types of the created piddles.

Can take file name or *HANDLE, and if no columns are specified, 
all are assumed. For the allowed types, see
L<PDL::Core/Datatype_conversions>.

Options:

EXCLUDE or IGNORE
- ignore lines matching this pattern (default B<'/^#/'>).

INCLUDE or KEEP
- only use lines which match this pattern (default B<''>).

LINES   
- which line numbers to use. Line numbers start at 0 and the syntax 
is 'a:b:c' to use every c'th matching line between a and b
(default B<''>).

DEFTYPE
- default data type for stored data (if not specified, use the type 
stored in C<$PDL::IO::Misc::deftype>, which starts off as B<double>).

TYPES
- reference to an array of data types, one element for each column 
to be read in.
Any missing columns use the DEFTYPE value (default B<[]>).

PERLCOLS
- an array of column numbers which are to be read into perl arrays
rather than piddles. References to these arrays are returned after
the requested piddles (default B<undef>).

=for usage

  Usage:
    ($x,$y,...) = rcols( *HANDLE|"filename", { EXCLUDE => '/^!/' }, 
                         $col1, $col2, ... )
    ($x,$y,...) = rcols( *HANDLE|"filename", $col1, $col2, ..., 
                         { EXCLUDE => '/^!/' } )
    ($x,$y,...) = rcols( *HANDLE|"filename", "/foo/", $col1, $col2, ... )
 
e.g.,

=for example

  $x      = PDL->rcols 'file1';
  ($x,$y) = rcols *STDOUT;

  # read in lines containing the string foo, where the first
  # example also ignores lines that with a # character.
  ($x,$y,$z) = rcols 'file2', 0,4,5, { INCLUDE => '/foo/' };
  ($x,$y,$z) = rcols 'file2', 0,4,5, 
                 { INCLUDE => '/foo/', EXCLUDE => '' };

  # ignore the first 27 lines of the file, reading in as ushort's
  ($x,$y) = rcols 'file3', { LINES => '27:-1', DEFTYPE => ushort };
  ($x,$y) = rcols 'file3', 
              { LINES => '27:', TYPES => [ ushort, ushort ] };

  # read in the first column as a perl array and the next two as piddles
  ($x,$y,$name) = rcols 'file4', 1, 2, { PERLCOLS => [ 0 ] };
  printf "Number of names read in = %d\n", 1 + $#$name;

Notes:

1. Quotes are required on patterns.

2. Columns are separated by whitespace by default,
use C<$PDL::IO::Misc::colsep> to specify an alternate
separator.

3. For PDL-2.003, the meaning of the 'c' value in the LINES option has
changed: it now only counts matching lines rather than all lines as in
previous versions of PDL. 

4. LINES => '-1:0:3' may not work as you expect, since lines are skipped
when read in, then the whole array reversed.

=cut

use vars qw/ $colsep $deftype /;

$colsep = " ";      # Default column separator
$deftype = double;  # Default type for piddles

# NOTE: XXX
#  need to look at the line-selection code. For instance, if want
#   lines => '-1:0:3', 
#  read in all lines, reverse, then apply the step
#  -> fix point 4 above
# 
# perhaps should just simplify the LINES option - ie remove
# support for reversed arrays?
#

sub rcols{PDL->rcols(@_)}

sub PDL::rcols {
   my $class = shift;
   barf 'Usage ($x,$y,...) = rcols( *HANDLE|"filename", ["/pattern/" or \%options], $col1, $col2, ..., [ \%options] )' 
       if $#_<0;

   my $is_handle = defined fileno $_[0] ? 1 : 0;
   my $fh = $is_handle ? $_[0] : gensym;
   open $fh, $_[0] or die "File $_[0] not found\n" unless $is_handle;
   shift;

   # set up default options
   my $opt = new PDL::Options( {
       EXCLUDE => '/^#/',
       INCLUDE => '',
       LINES => '',
       DEFTYPE => $deftype,
       TYPES   => [],
       PERLCOLS => undef
       } );
   $opt->synonyms( { IGNORE => 'EXCLUDE', KEEP => 'INCLUDE' } );

   # has the user supplied any options
   if ( defined($_[0]) ) {
       # ensure the old-style behaviour by setting the exclude pattern to ''
       if ( $_[0] =~ m|^/.*/$| )      { $opt->options( { EXCLUDE => '', INCLUDE => shift } ); }
       elsif ( ref($_[0]) eq "HASH" ) { $opt->options( shift ); }
   }

   # maybe the last element is a hash array as well
   $opt->options( pop ) if defined($_[-1]) and ref($_[-1]) eq "HASH";

   # a reference to a hash array
   my $options = $opt->current();   

   # what are the patterns?
   foreach my $pattern ( qw( INCLUDE EXCLUDE ) ) {
       if ( $$options{$pattern} ne '' ) {
         barf "rcols() - unable to parse $pattern value.\n" if $$options{$pattern} !~ m|^/.*/$|;
         $$options{$pattern} =~ s|^/(.*)/$|$1|;
       }
   }

   # which columns are to be read into piddles and which into perl arrays?
   my @perl_cols = ();
   @perl_cols = @{ $$options{PERLCOLS} } if $$options{PERLCOLS};
   my ( @pdl_cols )  = @_;

   # work out which line numbers are required
   # - the regexp's are a bit over the top
   my ( $a, $b, $c );
   if ( $$options{LINES} ne '' ) {
       if ( $$options{LINES} =~ /^\s*([+-]?\d*)\s*:\s*([+-]?\d*)\s*$/ ) {
           $a = $1; $b = $2;
       } elsif ( $$options{LINES} =~ /^\s*([+-]?\d*)\s*:\s*([+-]?\d*)\s*:\s*([+]?\d*)\s*$/ ) {
           $a = $1; $b = $2; $c = $3;
       } else {
           barf "rcols() - unable to parse LINES option.\n";
       }
   }

   # Since we do not know how many lines there are in advance, things get a bit messy
   my ( $index_start, $index_end ) = ( 0, -1 );
   $index_start  = $a if defined($a) and $a ne '';
   $index_end    = $b if defined($b) and $b ne '';
   my $line_step = $c || 1;

   # $line_rev = 0/1 for normal order/reversed
   # $line_start/_end refer to the first and last line numbers that we want
   # (the values of which we may not know until we've read in all the file)
   my ( $line_start, $line_end, $line_rev );
   if ( ($index_start >= 0 and $index_end < 0) ) {
       # eg 0:-1
       $line_rev = 0; $line_start = $index_start;
   } elsif ( $index_end >= 0 and $index_start < 0 ) {
       # eg -1:0
       $line_rev = 1; $line_start = $index_end; 
   } elsif ( $index_end >= $index_start and $index_start >= 0 ) {
       # eg 0:10
       $line_rev = 0; $line_start = $index_start; $line_end = $index_end;
   } elsif ( $index_start > $index_end and $index_end >= 0 ) {
       # eg 10:0
       $line_rev = 1; $line_start = $index_end; $line_end = $index_start;
   } elsif ( $index_start <= $index_end ) {
       # eg -5:-1
       $line_rev = 0;
   } else {
       # eg -1:-5
       $line_rev = 1;
   }
   
   my @ret;

   my (@v,$k); 

   my $line_num = -1;
   my $line_ctr = $line_step - 1;  # ensure first line is always included
   my $index    = -1;
   my $pdlsize  =  0;
   my $extend   = 10000;

   my $line_store;  # line numbers of saved data

   while(<$fh>) {

       $line_num++;

       # the order of these checks is important, particularly whether we
       # check for line_ctr before or after the pattern matching
       # Prior to PDL 2.003 the line checks were done BEFORE the
       # pattern matching
       #
       # need this first check, even with it almost repeated at end of loop,
       # incase the pattern matching excludes $line_num == $line_end, say
       last if     defined($line_end)   and $line_num > $line_end;
       next if     defined($line_start) and $line_num < $line_start;
       next if     $$options{EXCLUDE} ne '' and /$$options{EXCLUDE}/;
       next unless $$options{INCLUDE} eq '' or  /$$options{INCLUDE}/;
       next unless ++$line_ctr == $line_step;
       $line_ctr = 0;

       $index++;
       @v = $colsep eq ' ' ? split(' ') : split($colsep) ; 

       # if the first line, set up the output piddles
       # using all the columns if the user doesn't specify anything
       if ( $index == 0 ) {
         @pdl_cols = ( 0 .. $#v ) if $#pdl_cols < 0;

         # sort out the types of the piddles
         my @types = _handle_types( $#pdl_cols, $$options{DEFTYPE}, $$options{TYPES} );
         if ( $PDL::verbose ) { # dbg aid
             print "Reading data into piddles of type: [ ";
             foreach my $t ( @types ) {
                 print $t->shortctype() . " ";
             }
             print "]\n";
         }
         
         $k = 0;
         for (0..$#pdl_cols) { $ret[$_] = $class->zeroes($types[$_],1); $k++; }
         for (@perl_cols)    { $ret[$k++] = []; }
         $line_store = $class->zeroes(long,1); # only need to store integers
       }

       # if necessary, extend PDL in buffered manner
       if ( $pdlsize < $index ) {
         for (0..$#pdl_cols) { ext1D( $ret[$_], $extend ); }
           ext1D( $line_store, $extend );
           $pdlsize += $extend;
       }

       # Set values - '1*' is split() bug workaround
       # - stick perl arrays onto end of $ret
       $k = 0;
       for (@pdl_cols)  { set $ret[$k++], $index, 1*$v[$_]; }
       for (@perl_cols) { push @{ $ret[$k++] }, $v[$_]; }

       # store the line number
       $line_store->set( $index, $line_num );

       # Thanks to Frank Samuelson for this
       last if defined($line_end) and $line_num == $line_end;
   }

   close($fh) unless $is_handle;

   # have we read anything in? if not, return empty piddles
   if ( $index == -1 ) {
       print "Warning: rcols() did not read in any data.\n" if $PDL::verbose;
       if ( wantarray ) {
         foreach ( 0 .. $#pdl_cols ) { $ret[$_] = PDL->null; }
         for ( ($#pdl_cols+1) .. ($#pdl_cols+1+$#perl_cols) ) { $ret[$_] = []; }
           return ( @ret );
       } else { 
           return PDL->null;
       }
   }

   # if the user has asked for lines => 0:-1 or 0:10 or 1:10 or 1:-1,
   # - ie not reversed and the last line number is known -
   # then we can skip the following nastiness
   if ( $line_rev == 0 and $index_start >= 0 and $index_end >= -1 ) {
       for ( 0 .. $#pdl_cols ) { $ret[$_] = $ret[$_]->slice("0:${index}"); };
       if ( $PDL::verbose ) {
           if ( $#pdl_cols != -1 ) { print "Read in ", $ret[0]->nelem, " elements.\n"; }
           else                    { print "Read in ", $#{ $ret[0] }, " elements.\n"; }
       }
       wantarray ? return(@ret) : return $ret[0];
   }

   # Work out which line numbers we want. First we clean up the piddle
   # containing the line numbers that have been read in
   $line_store = $line_store->slice("0:${index}");

   # work out the min/max line numbers required
   if ( $line_rev ) {
       if ( defined($line_start) and defined($line_end) ) {
           my $dummy = $line_start;
           $line_start = $line_end;
           $line_end = $dummy;
       } elsif ( defined($line_start) ) {
           $line_end = $line_start;
       } else {
           $line_start = $line_end; 
       }
   }
   $line_start = $line_num + 1 + $index_start if $index_start < 0;
   $line_end   = $line_num + 1 + $index_end   if $index_end   < 0;

   my $indices;

   { no warnings 'precedence';	
     if ( $line_rev ) {
         $indices = which( $line_store >= $line_end & $line_store <= $line_start )->slice('-1:0');
     } else {
         $indices = which( $line_store >= $line_start & $line_store <= $line_end );
     }
   }

   # truncate the piddles
   for ( 0 .. $#pdl_cols ) { $ret[$_] = $ret[$_]->index($indices); };

   # truncate/reverse/etc the perl arrays
   my @indices_array = list $indices;
   $k = $#pdl_cols + 1;
   foreach ( 0 .. $#perl_cols ) {
       my @temp = @{ $ret[$k] };
       $ret[$k] = [];
       foreach my $i ( @indices_array ) { push @{ $ret[$k] }, $temp[$i] };
       $k++;
   }

   if ( $PDL::verbose ) {
       if ( $#pdl_cols != -1 ) { print "Read in ", $ret[0]->nelem, " elements.\n"; }
       else                    { print "Read in ", $#{ $ret[0] }, " elements.\n"; }
   }
   wantarray ? return(@ret) : return $ret[0];
}


=head2 wcols()

=for ref

Write ASCII whitespaced cols into file from piddles efficiently.

If no columns are specified all are assumed.
Will optionally only process lines matching a pattern.
Can take file name or *HANDLE, and
if no file/filehandle is given defaults to STDOUT.

Options:

HEADER
- prints this string before the data. If the string
is not terminated by a newline, one is added
(default B<''>).

=for usage

 Usage: wcols $piddle1, $piddle2,..., *HANDLE|"outfile", [\%options];

e.g.,

=for example

  wcols $x, $y+2, 'foo.dat';
  wcols $x, $y+2, *STDERR;
  wcols $x, $y+2, '|wc';
  wcols $a,$b,$c; # Orthogonal version of 'print $a,$b,$c' :-)

  wcols "%10.3f", $a,$b; # Formatted
  wcols "%10.3f %10.5g", $a,$b; # Individual column formatting

  wcols $a,$b, { HEADER => "#   a   b" };

Note: columns are separated by whitespace by default,
use $PDL::IO::Misc::colsep to specify an alternate
separator.

=cut

*wcols = \&PDL::wcols;

sub PDL::wcols {
   barf 'Usage: wcols(@[$format_string], vectors,*HANDLE|"filename", [\%options])' if @_<1;

   my ($format_string, $step, $fh);
   if (ref(\$_[0]) eq "SCALAR") {
       $step = $format_string = shift; # 1st arg not piddle
       $step =~ s/(%%|[^%])//g;  # use step to count number of format items
       $step = length ($step);
   }
   # if last argument is a reference to a hash, parse the options
   my $header;
   if ( ref( $_[-1] ) eq "HASH" ) {
       my $opt = pop;
       foreach my $key ( keys %$opt ) {
           if ( $key =~ /^H/i ) { $header = $opt->{$key}; }  # option: HEADER
           else {
               print "Warning: wcols does not understand option <$key>.\n"; 
           }
       }
   }
   my $file = $_[-1];
   my $file_opened;
   my $is_handle = !UNIVERSAL::isa($file,'PDL') && defined fileno($file) ? 1 
        : 0;
   if ($is_handle) {  # file handle passed directly
       $fh = $file; pop;
   }
   else{
       if (ref(\$file) eq "SCALAR") {  # Must be a file name
          $fh = gensym;
         if (!$is_handle) {
            $file = ">$file" unless $file =~ /^\|/ or $file =~ /^\>/;
             open $fh, $file or barf "File $file can not be opened for writing\n";
         }
          pop;
          $file_opened = 1;
       }
       else{  # Not a filehandle or filename, assume something else
              # (probably piddle) and send to STDOUT
          $fh = *STDOUT;
       }
   }

   my @p = @_;
   my $n = $p[0]->nelem;
   for (@p) {
      barf "wcols: 1d args must have same number of elements\n"
         if $_->nelem != $n or $_->getndims!=1;
   }
   if ( defined $header ) {
       $header .= "\n" unless $header =~ m/\n$/;
       print $fh $header;
   }
   my $i;
   for ($i=0; $i<$n; $i++) {
       if ($format_string) {
           my @d;
           for (@p) {
               push @d,$_->at($i);
               if (@d == $step) {
                   printf $fh $format_string,@d;
                   printf $fh $colsep;
                   $#d = -1;
               }
           }
           if (@d && !$i) {
               my $str;
               if ($#p>0) {
                   $str = ($#p+1).' columns don\'t';
               } else {
                   $str = '1 column doesn\'t';
               }
               $str .= " fit in $step column format ".
               '(even repeated) -- discarding surplus';
               carp $str;
               # printf $fh $format_string,@d;
               # printf $fh $colsep;
           }
       } else {
           for (@p) {
               print $fh $_->at($i),$colsep;
           }
       }
       print $fh "\n";
   }
   close($fh) if $file_opened;
   return 1;
}

=head2 swcols()

=for ref

generate string list from C<sprintf> format specifier and a list of piddles

C<swcols> takes an (optional) format specifier of the printf sort and a list
of 1d piddles as input. It returns a perl array (or array reference if
called in
scalar context) where
each element of the array is the string generated by printing the
corresponding element of the piddle(s) using the format specified. If
no format is specified it uses the default print format.

=for usage

 Usage: @str = swcols format, pdl1,pdl2,pdl3,...;
  or
        $str = swcols format, pdl1,pdl2,pdl3,...;

=cut

*swcols = \&PDL::swcols;

sub PDL::swcols{
  my ($format_string,$step);

  my @outlist;

  if (ref(\$_[0]) eq "SCALAR") {
         $step = $format_string = shift; # 1st arg not piddle
         $step =~ s/(%%|[^%])//g;  # use step to count number of format items
         $step = length ($step);
  }
  
  my @p = @_;
  my $n = $p[0]->nelem;
  for (@p) {
         barf "swcols: 1d args must have same number of elements\n"
                if $_->nelem != $n or $_->getndims!=1;
  }

  my $i;
  for ($i=0; $i<$n; $i++) {
         if ($format_string) {
           my @d;
           for (@p) {
                  push @d,$_->at($i);
                  if (@d == $step) {
                         push @outlist,sprintf $format_string,@d;
                         $#d = -1;
                  }
           }
           if (@d && !$i) {
                  my $str;
                  if ($#p>0) {
                         $str = ($#p+1).' columns don\'t';
                  } else {
                         $str = '1 column doesn\'t';
                  }
                  $str .= " fit in $step column format ".
               '(even repeated) -- discarding surplus';
                  carp $str;
                  # printf $fh $format_string,@d;
                  # printf $fh $colsep;
           }
         } else {
           for (@p) {
                  push @outlist,sprintf $_->at($i),$colsep;
           }
         }
  }
  wantarray ? return @outlist: return \@outlist;
}


=head2 rgrep()

=for ref

Read columns into piddles using full regexp pattern matching.

Options:

UNDEFINED: This option determines what will be done for undefined 
values. For instance when reading a comma-separated file of the type 
C<1,2,,4> where the C<,,> indicates a missing value. 

The default value is to assign C<$PDL::undefval> to undefined values,
but if C<UNDEFINED> is set this is used instead. This would normally 
be set to a number, but if it is set to C<Bad> and PDL is compiled
with Badvalue support (see L<PDL::Bad/>) then undefined values are set to
the appropriate badvalue and the column is marked as bad.

DEFTYPE: Sets the default type of the columns - see the documentation for
 L</rcols()>

TYPES:   A reference to a Perl array with types for each column - see 
the documentation for L</rcols()>

BUFFERSIZE: The number of lines to extend the piddle by. It might speed
up the reading a little bit by setting this to the number of lines in the
file, but in general L</rasc()> is a better choice

Usage

=for usage

 ($x,$y,...) = rgrep(sub, *HANDLE|"filename")

e.g.

=for example

 ($a,$b) = rgrep {/Foo (.*) Bar (.*) Mumble/} $file;

i.e. the vectors C<$a> and C<$b> get the progressive values
of C<$1>, C<$2> etc.

=cut

  sub rgrep (&@) {
     barf 'Usage ($x,$y,...) = rgrep(sub, *HANDLE|"filename", [{OPTIONS}])'
         if $#_ > 2;

     my (@ret,@v,$nret); my ($m,$n)=(-1,0); # Count/PDL size
     my $pattern = shift;

     my $is_handle = defined fileno $_[0] ? 1 : 0;
     my $fh = $is_handle ? $_[0] : gensym;
     open $fh, $_[0] or die "File $_[0] not found\n" unless $is_handle;

     if (ref($pattern) ne "CODE") {
         die "Got a ".ref($pattern)." for rgrep?!";
     }

	
     # set up default options
     my $opt = new PDL::Options( {
         DEFTYPE => $deftype,
         TYPES => [],
         UNDEFINED => $PDL::undefval,
	 BUFFERSIZE => 10000
         } );
     # Check if the user specified options
     my $u_opt = $_[1] || {};
     $opt->options( $u_opt);

     my $options = $opt->current();   

     # If UNDEFINED is set to .*bad.* then undefined are set to
     # bad - unless we have a Perl that is not compiled with Bad support
     my $undef_is_bad = ($$options{UNDEFINED} =~ /bad/i);
     if ($undef_is_bad && !$PDL::Bad::Status) {
	carp "UNDEFINED cannot be set to Badvalue when PDL hasn't been compiled with Bad value support - \$PDL::undefval used instead\n";
        $undef_is_bad = 0;
     }        
     barf "Unknown PDL type given for DEFTYPE.\n"
        unless ref($$options{DEFTYPE}) eq "PDL::Type";


     while(<$fh>) {
         next unless @v = &$pattern;

         $m++;  # Count got
         if ($m==0) {
           $nret = $#v;   # Last index of values to return

	   # Handle various columns as in rcols - added 18/04/05
           my @types = _handle_types( $nret, $$options{DEFTYPE}, $$options{TYPES} );	
           for (0..$nret) {
                # Modified 18/04/05 to use specified precision.
	 	$ret[$_] = PDL->zeroes($types[$_], 1);
           }
       } else { # perhaps should only carp once...
           carp "Non-rectangular rgrep" if $nret != $#v;
       }
       if ($n<$m) {
           for (0..$nret) {
               ext1D( $ret[$_], $$options{BUFFERSIZE} ); # Extend PDL in buffered manner
           }
           $n += $$options{BUFFERSIZE};
      }
       for(0..$nret) { 
	# Set values - '1*' is to ensure numeric
	# We now (JB - 18/04/05) also check for defined values or not
	# Ideally this should include Badvalue support..
	if ($v[$_] eq '') {
	   # Missing value - let us treat this specially
	   if ($undef_is_bad) {
	       set $ret[$_], $m, $$options{DEFTYPE}->badvalue();
               # And set bad flag on $ref[$_]!
               $ret[$_]->badflag(1);
           } else {
               set $ret[$_], $m, $$options{UNDEFINED};
           } 
	} else {
    	   set $ret[$_], $m, 1*$v[$_];
	}
     } 
   }
                                 
   close($fh) unless $is_handle;
   for (@ret) { $_ = $_->slice("0:$m")->copy; }; # Truncate
   wantarray ? return(@ret) : return $ret[0];
}


=head2 rdsa()

=for ref

Read a FIGARO/NDF format file.

Requires non-PDL DSA module. Contact Frossie (frossie@jach.hawaii.edu)
Usage:

=for usage

 ([$xaxis],$data) = rdsa($file)

=for example

 $a = rdsa 'file.sdf'

Not yet tested with PDL-1.9X versions

=cut

sub rdsa{PDL->rdsa(@_)}

use vars qw/ $dsa_loaded /;
sub PDL::rdsa {
    my $class = shift;
    barf 'Usage: ([$xaxis],$data) = rdsa($file)' if $#_!=0;
    my $file = shift; my $pdl = $class->new; my $xpdl;
    eval 'use DSA' unless $dsa_loaded++;
    barf 'Cannot use DSA library' if $@ ne "";

    my $status = 0;

    # Most of this stuff stolen from Frossie:

    dsa_open($status);
    dsa_named_input('IMAGE',$file,$status);
    goto skip if $status != 0;

    dsa_get_range('IMAGE',my $vmin,my $vmax,$status);
    my @data_dims;
    dsa_data_size('IMAGE',5, my $data_ndims, \@data_dims, my $data_elements, 
                  $status);
    dsa_map_data('IMAGE','READ','FLOAT',my $data_address,my $data_slot,
                 $status);

    @data_dims = @data_dims[0..$data_ndims-1];
    print "Dims of $file = @data_dims\n" if $PDL::verbose;
    $pdl->set_datatype($PDL_F);
    $pdl->setdims([@data_dims]);
    my $dref = $pdl->get_dataref;
    mem2string($data_address,4*$data_elements,$$dref);
    $pdl->upd_data();

    if (wantarray) { # Map X axis values
      my @axis_dims;
      dsa_axis_size('IMAGE',1,5, my $axis_ndims, \@axis_dims,
                    my $axis_elements, $status);
      dsa_map_axis_data('IMAGE',1,'READ','FLOAT',my $axis_address,
                    my $axis_slot,$status);
      @axis_dims = @axis_dims[0..$axis_ndims-1];
      $xpdl = $class->new;
      $xpdl->set_datatype($PDL_F);
      $xpdl->setdims([@axis_dims]);
      my $xref = $xpdl->get_dataref;
      mem2string($axis_address,4*$axis_elements,$$xref);
      $xpdl->upd_data();
    }

    skip: dsa_close($status);

    barf("rdsa: obtained DSA error") if $status != 0;

    return ($xpdl,$pdl);
}

=head2 isbigendian()

=for ref

Determine endianness of machine - returns 0 or 1 accordingly

=cut



sub PDL::isbigendian { return 0; };
*isbigendian = \&PDL::isbigendian;




=head2 rasc()

=for ref

Simple function to slurp in ASCII
numbers quite quickly, although error handling is marginal (to
nonexistent).

=for usage

  $pdl->rasc("filename"|FILEHANDLE [,$noElements]);
      Where:
        filename is the name of the ASCII file to read or
          open file handle
        $noElements is the optional number of elements in the file to read.
            (If not present, all of the file will be read to fill up $pdl).
        $pdl can be of type float or double for more precision.

=for example

  #  (test.num is an ascii file with 20 numbers. One number per line.)
  $in = PDL->null;
  $num = 20;
  $in->rasc('test.num',20);
  $imm = zeroes(float,20,2);
  $imm->rasc('test.num');

=cut

sub rasc {PDL->rasc(@_)}
sub PDL::rasc {
  use IO::File;
  my ($pdl, $file, $num) = @_;
  $num = -1 unless defined $num;
  my $fi = $file;
  my $is_openhandle = defined fileno $fi ? 1 : 0;
  unless ($is_openhandle) {
    barf 'usage: rasc $pdl, "filename"|FILEHANDLE, [$num_to_read]'
       if !defined $file || ref $file;
    $fi = new IO::File "<$file" or barf "Can't open $file";
  }
  $pdl->_rasc(my $ierr=null,$num,$fi);
  close $fi unless $is_openhandle;
  return all $ierr > 0;
}

# ----------------------------------------------------------

=head2 rcube

=for ref

Read list of files directly into a large data cube (for efficiency)

=for usage

 $cube = rcube \&reader_function, @files;

=for example

 $cube = rcube \&rfits, glob("*.fits");

This IO function allows direct reading of files into a large data cube,
Obviously one could use cat() but this is more memory efficient.

The reading function (e.g. rfits, readfraw) (passed as a reference)
and files are the arguments.

The cube is created as the same X,Y dims and datatype as the first
image specified. The Z dim is simply the number of images.

=cut

sub rcube {

    my $reader = shift;

    barf "Usage: blah" unless ref($reader) eq "CODE";

    my $k=0;
    my ($im,$cube,$tmp,$nx,$ny);
    my $nz = scalar(@_);

    for my $file (@_) {
       print "Slice ($k) - reading file $file...\n" if $PDL::verbose;
       $im = &$reader($file);
       ($nx, $ny) = dims $im;
       if ($k == 0) {
          print "Creating $nx x $ny x $nz cube...\n" if $PDL::verbose;
          $cube = $im->zeroes($im->type,$nx,$ny,$nz);
        }
        else {
          barf "Dimensions do not match for file $file!\n" if
             $im->getdim(0) != $nx or $im->getdim(1) != $ny ;

       }
       $tmp = $cube->slice(":,:,($k)");
       $tmp .= $im;
       $k++;
      }

      return $cube;
}






*_rasc = \&PDL::_rasc;


;


=head1 AUTHOR

Copyright (C) Karl Glazebrook 1997 and Craig DeForest 2001, 2003.
All rights reserved. There is no warranty. You are allowed
to redistribute this software / documentation under certain
conditions. For details, see the file COPYING in the PDL
distribution. If this file is separated from the PDL distribution,
the copyright notice should be included in the file.

=cut





# Exit with OK status

1;

		   