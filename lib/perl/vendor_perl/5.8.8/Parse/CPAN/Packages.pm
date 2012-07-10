package Parse::CPAN::Packages;
use strict;
use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( details data dists latestdists ));
use CPAN::DistnameInfo;
use Compress::Zlib;
use IO::Zlib;
use Parse::CPAN::Packages::Package;
use version;
use vars qw($VERSION);
$VERSION = '2.26';

sub new {
    my $class = shift;

    my $self = { data => {}, dists => {}, latestdists => {} };
    bless $self, $class;

    # read the file then parse it if present
    $self->parse(shift) if @_;

    return $self;
}

# read the file into memory and return it
sub _slurp_details {
    my $self     = shift;
    my $filename = (@_) ? shift: "02packages.details.txt.gz";

    if ( $filename =~ /Description:/ ) {
        return $filename;
    } elsif ( $filename =~ /\.gz/ ) {
        my $fh = IO::Zlib->new( $filename, "rb" )
            || die "Failed to read $filename: $!";
        return join '', <$fh>;
    } elsif ( $filename =~ /^\037\213/ ) {
        return Compress::Zlib::memGunzip($filename);
    } else {
        open( IN, $filename ) || die "Failed to read $filename: $!";
        return join '', <IN>;
        close(IN);
    }
}

sub parse {
    my $self    = shift;
    my $details = $self->_slurp_details(shift);

    # remove the preamble
    $details = ( split "\n\n", $details )[1];

    # run though each line of the file
    foreach my $line ( split "\n", $details ) {

        # make a package object from the line
        my ( $package_name, $package_version, $prefix ) = split ' ', $line;
        $self->add_quick( $package_name, $package_version, $prefix );
    }
}

sub add_quick {
    my $self = shift;
    my ( $package_name, $package_version, $prefix ) = @_;

    # create the package object
    my $m = Parse::CPAN::Packages::Package->new;
    $m->package($package_name);
    $m->version($package_version);

    # create a distribution object (or get an existing one)
    my $dist = $self->distribution_from_prefix($prefix);

    # make the package have the distribion and the distribution
    # have the package.  Yes, this creates a cirtular reference.  eek!
    $m->distribution($dist);
    $dist->add_package($m);

    # record this distribution and package
    $self->add_distribution($dist);
    $self->add_package($m);
}

sub distribution_from_prefix {
    my $self   = shift;
    my $prefix = shift;

    # see if we have one of these already and return it if we do.
    my $d = $self->distribution($prefix);
    return $d if $d;

    # create a new one otherwise
    $d = Parse::CPAN::Packages::Distribution->new;
    my $i = CPAN::DistnameInfo->new($prefix);
    $d->prefix($prefix);
    $d->dist( $i->dist );
    $d->version( $i->version );
    $d->maturity( $i->maturity );
    $d->filename( $i->filename );
    $d->cpanid( $i->cpanid );
    $d->distvname( $i->distvname );
    return $d;
}

sub add_package {
    my $self    = shift;
    my $package = shift;

    # store it
    $self->data->{ $package->package } = $package;

    return $self;
}

sub package {
    my $self         = shift;
    my $package_name = shift;
    return $self->data->{$package_name};
}

sub packages {
    my $self = shift;
    return values %{ $self->data };
}

sub add_distribution {
    my $self = shift;
    my $dist = shift;

    $self->_store_distribution($dist);
    $self->_ensure_latest_distribution($dist);
}

sub _store_distribution {
    my $self = shift;
    my $dist = shift;

    $self->dists->{ $dist->prefix } = $dist;
}

sub _ensure_latest_distribution {
    my $self = shift;
    local $a = shift;
    local $b = $self->latest_distribution( $a->dist );
    unless ($b) {
        $self->_set_latest_distribution($a);
        return;
    }
    my ( $av, $bv );
    eval {
        $av = version->new( $a->version || 0 );
        $bv = version->new( $a->version || 0 );
    };
    if ( $av && $bv ) {
        if ( $av > $bv ) {
            $self->_set_latest_distribution($a);
        }
    } else {
        if ( $a->dist > $b->dist ) {
            $self->_set_latest_distribution($a);
        }
    }
}

sub distribution {
    my $self = shift;
    my $dist = shift;
    return $self->dists->{$dist};
}

sub distributions {
    my $self = shift;
    return values %{ $self->dists };
}

sub _set_latest_distribution {
    my $self = shift;
    my $dist = shift;
    return unless $dist->dist;
    $self->latestdists->{ $dist->dist } = $dist;
}

sub latest_distribution {
    my $self = shift;
    my $dist = shift;
    return unless $dist;
    return $self->latestdists->{$dist};
}

sub latest_distributions {
    my $self = shift;
    return values %{ $self->latestdists };
}

sub package_count {
    my $self = shift;
    return scalar scalar $self->packages;
}

sub distribution_count {
    my $self = shift;
    return scalar $self->distributions;
}

sub latest_distribution_count {
    my $self = shift;
    return scalar $self->latest_distributions;
}

1;

__END__

=head1 NAME

Parse::CPAN::Packages - Parse 02packages.details.txt.gz

=head1 SYNOPSIS

  use Parse::CPAN::Packages;

  # must have downloaded
  my $p = Parse::CPAN::Packages->new("02packages.details.txt.gz");
  # either a filename as above or pass in the contents of the file
  # (uncompressed)
  my $p = Parse::CPAN::Packages->new($packages_details_contents);

  my $m = $p->package("Acme::Colour");
  # $m is a Parse::CPAN::Packages::Package object
  print $m->package, "\n";   # Acme::Colour
  print $m->version, "\n";   # 1.00

  my $d = $m->distribution();
  # $d is a Parse::CPAN::Packages::Distribution object
  print $d->prefix, "\n";    # L/LB/LBROCARD/Acme-Colour-1.00.tar.gz
  print $d->dist, "\n";      # Acme-Colour
  print $d->version, "\n";   # 1.00
  print $d->maturity, "\n";  # released
  print $d->filename, "\n";  # Acme-Colour-1.00.tar.gz
  print $d->cpanid, "\n";    # LBROCARD
  print $d->distvname, "\n"; # Acme-Colour-1.00

  # all the package objects
  my @packages = $p->packages;

  # all the distribution objects
  my @distributions = $p->distributions;

  # the latest distribution
  $d = $p->latest_distribution("Acme-Colour");
  is($d->prefix, "L/LB/LBROCARD/Acme-Colour-1.00.tar.gz");
  is($d->version, "1.00");

  # all the latest distributions
  my @distributions = $p->latest_distributions;

=head1 DESCRIPTION

The Comprehensive Perl Archive Network (CPAN) is a very useful
collection of Perl code. It has several indices of the files that it
hosts, including a file named "02packages.details.txt.gz" in the
"modules" directory. This file contains lots of useful information and
this module provides a simple interface to the data contained within.

In a future release L<Parse::CPAN::Packages::Package> and
L<Parse::CPAN::Packages::Distribution> might have more information.

=head2 Methods

=over

=item new

Creates a new instance from a details file.

The constructor can be passed either the path to the
C<02packages.details.txt.gz> file, a path to an ungzipped version of
this file, or a scalar containing the entire uncompressed contents of
the file.

Note that this module does not concern itself with downloading this
file. You should do this yourself.  For example:

   use LWP::Simple qw(get);
   my $data = get("http://www.cpan.org/modules/02packages.details.txt.gz");
   my $p = Parse::CPAN::Packages->new($data);

=item package($packagename)

Returns a C<Parse::CPAN::Packages::Package> that represents the
named package.

  my $p = Parse::CPAN::Distribution->new($gzfilename);
  my $package = $p->package("Acme::Colour");

=item packages()

Returns a list of B<Parse::CPAN::Packages::Package> objects
representing all the packages that were extracted from the file.

=item package_count()

Returns the numebr of packages stored.

=item distribution($filename)

Returns a B<Parse::CPAN::Distribution> that represents the
filename passed:

  my $p = Parse::CPAN::Distribution->new($gzfilename);
  my $dist = $p->distribution('L/LB/LBROCARD/Acme-Colour-1.00.tar.gz');

=item distrbutions()

Returns a list of B<Parse::CPAN::Distribution> objects representing
all the known distributions.

=item distribution_count()

Returns the number of distributions stored.

=item latest_distribution($distname)

Returns the C<Parse::CPAN::Distribution> that represents the latest
distribution for the named disribution passed, that is to say it
returns the distribution that has the highest version number (as
determined by version.pm or number comparison if that fails):

  my $p = Parse::CPAN::Distribution->new($gzfilename);
  my $dist = $p->distribution('Acme-Color');

=item latest_distrbutions()

Returns a list of B<Parse::CPAN::Distribution> objects representing
all the latest distributions.

=item latest_distribution_count()

Returns the number of distributions stored.

=back

=head2 Addtional Methods

These are additional methods that you may find useful.

=over

=item parse($filename)

Parses the filename.  Works in a similar fashion to the the
constructor (i.e. you can pass it a filename for a
compressed/1uncompressed file, a uncompressed scalar containing the
file.  You can also pass nothing to indicate to load the compressed
file from the current working directory.)

Note that each time this function is run the packages and distribtions
found will be C<added> to the current list of packages.

=item add_quick($package_name, $package_version, $prefix)

Quick way of adding a new package and distribution.

=item add_package($package_obj)

Adds a package.  Note that you'll probably want to add the
corrisponding distribution for that package too (it's not done
automatically.)

=item add_distribution($distribution_obj)

Adds a distribution.  Note that you'll probably want to add the
corrisponding packages for that distribution too (it's not done
automatically.)

=cut

=back

=head1 AUTHOR

Leon Brocard <acme@astray.com>

=head1 COPYRIGHT

Copyright (C) 2004, Leon Brocard

This module is free software; you can redistribute it or modify it under
the same terms as Perl itself.

=head1 BUGS

This module leaks memory as packages hold distributions and
distributions hold packages.  No attempt has been made to fix this as
it's not anticpated that this will be used in long running programs
that will dispose of the objects once created.

The old interface for C<new> where if you passed no arguments it would
look for a C<02packages.details.txt.gz> in your current directory is
no longer supported.

=head1 TODO

delete_* methods.  merge_into method.  Documentation for other modules.

=head1 SEE ALSO

L<CPAN::DistInfoname>, L<Parse::CPAN::Packages::Writer>.
