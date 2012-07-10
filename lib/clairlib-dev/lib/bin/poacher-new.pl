#-----------------------------------------------------------------------

=head1 NAME

poacher - a simple web site validation robot, based on WWW::Robot

=head1 SYNOPSIS

poacher [ -help | -verbose | -version ] [ -command program ] url

=cut

#-----------------------------------------------------------------------

use strict;
require 5.002;

#-----------------------------------------------------------------------
 
=head1 DESCRIPTION

B<Poacher> is a web robot which is used to check a web site for various
problems, such as broken links, and badly formed HTML.
The checking of page content is performed by a separate program,
currently just B<weblint>.

Poacher is provided as a sample application of the WWW::Robot module -
it is just an expanded version of the sample code included in the
documentation for WWW::Robot.
Please let me know if you have any ideas for new features,
or improvements: for Poacher or the Robot module.

=cut

#-----------------------------------------------------------------------
use FindBin;
use lib "$FindBin::Bin/..";
use Clair::Utils::Robot2;
use URI::URL;
use Getopt::Long;
use IO::Pipe;
use English;

#-----------------------------------------------------------------------
 
=head1 OPTIONS

=over 4

=item -command program

Specifies a program which you would like invoked on every page
for which the GET request is successful. For example, you could
use this to invoke weblint on every page.

=item -email address

Provides your email address, which is noted in requests made by the
robot. This is so people can contact you if your robot goes crazy.

=item -external

The robot should check that external URLs are accessible.
We effectively ping them using a HEAD request.

=item -traversal [ depth | breadth ]

Specifies whether the robot should perform a depth-first traversal
or a breadth-first traversal.

=item -help

Display a short help message with a reminder of supported
command-line options.

=item -version

Display the version of Poacher.

=item -verbose

Enabled verbose reporting as the poacher runs.

=back

=cut

#-----------------------------------------------------------------------


use vars qw($VERSION);
$VERSION         = '0.005';

my $siterootroot='';
my $check=0;
my @forbidden_urls = ();
my $numberURLS=0;
my $EXTERNAL     = 0;
my $test         = '';
my $SHOW_HELP    = 0;
my $SHOW_VERSION = 0;
my $TRAVERSAL    = 'depth';
my $VERBOSE      = 0;
my $BOTNAME      = 'Poacher';
my $COMMAND;
my $EMAIL;
my $top;


my $siteRoot;
my $robot;
my $cache_file;
&ParseCommandLine();
&Initialise();
if ($robot->run($siteRoot))
{
  #radev: commented on June 29, 2006
  #open(LOG, ">>$ENV{PERLTREE_HOME}/download/poacherLog");
  #print LOG "$siteRoot finished successfully:".`date`."\n" or print STDERR 
  #  "Error writing to log file.\n";
  #close LOG;
}
exit 0;


#=======================================================================
# Initialise() - initialise global variables, contents, tables, etc
#
# This function sets up various global variables such as the version number
# for WebAssay, the program name identifier, usage statement, etc.
#=======================================================================
sub Initialise
{
    my $oldfh;


    #-------------------------------------------------------------------
    # Unbuffer standard output. Just in case we're running a command
    # on each URL - should ensure we don't get strangely interleaved
    # output from robot, us, and the command.
    #-------------------------------------------------------------------
    $oldfh = select STDOUT;
    $OUTPUT_AUTOFLUSH = 1;
    select $oldfh;


    #-------------------------------------------------------------------
    # $robot: the WWW::Robot object we use to traverse web pages
    #-------------------------------------------------------------------
    $robot = new WWW::Robot(
                            'NAME'      => $BOTNAME,
                            'VERSION'   => $VERSION,
                            'EMAIL'     => $EMAIL,
                            'TRAVERSAL' => $TRAVERSAL,
                            'VERBOSE'   => $VERBOSE,
                            'SITEROOTROOT'   => $siterootroot,
                            'CACHEFILE'   => $cache_file
                           );

    if (!defined $robot)
    {
	die "Failed to create robot, unable to continue.\n";
    }

    $robot->addHook('follow-url-test',     \&follow_url_test);
    $robot->addHook('invoke-on-contents',  \&process_contents);
    $robot->addHook('invoke-on-get-error', \&process_get_error);

    #$robot->proxy(['ftp', 'http', 'wais', 'gopher'],
    #	  'http://horatio:8080/');
    #$robot->no_proxy('canon2');

    $robot->setAttribute('REQUEST_DELAY', 0);
}

#=======================================================================
# follow_url_test() - tell the robot module whether is should follow link
#=======================================================================
sub follow_url_test
{
    my $robot     = shift;
    my $hook_name = shift;
    my $url       = shift;

    $numberURLS++;
    if (!sanityCheck($url)) { print STDERR "sanity: $url\n"; return 0; }    
    if ($url  =~ m!;.*=!) { print STDERR "second: $url\n"; return 0; }
    if ($url->scheme ne 'http' && $url->scheme ne 'https') {
		print STDERR "scheme: $url\n"; return 0;
    }
    if ($url =~ /\/\/\//) { print STDERR "backslash: $url\n"; return 0; }

###########################added by amjad#######################
#@timedata=localtime(time);
#if($timedata[1]>=25 && $timedata[1]<=27)
#{
	#open(F1,">/data0/projects/glat/sq1");
    open (FORBIDDEN,"<forbidden_urls");
    while (<FORBIDDEN>) {
	chomp;
	if (/^\s+$/) { next; }
	if ($url =~ /$_/) {
		print STDERR "forbidden: $url\n";
		#print F1 "hello world";
		close FORBIDDEN;
		return 0;
	}
    }
    close FORBIDDEN;
#}
    #-------------------------------------------------------------------
    # need to decide whether we should follow it. Rather than check
    # for .gif, .zip, etc, we look for extensions which we'll follow
    #-------------------------------------------------------------------
### commented out by Gunes
#    if ($url =~ m![^/.]+\.([^/]+)$!)
#    {
#        $extension = $1;
##########        return 0 if ($extension !~ /^s?html?$/);
#        return 0 if 
#         ($extension !~ /^s?html?$/ 
#       && $extension !~ /^php$/ 
#       && $extension !~ /^asp$/
#       && $extension !~ /^cfm$/
#       && $extension !~ /^css$/
#       && $extension !~ /^cgi$/);
#    }

    #-------------------------------------------------------------------
    # Check whether URL is on the site
    #-------------------------------------------------------------------

    #my @parts=split /\//, $url;
    #if ($#parts > 13)
    #{
    #  return 0;
    #}
    if ($test eq "") {
      $test = "^http:\/\/[a-zA-Z0-9\.\-]*$top\/";
    }
    if ($url !~ /$test/) {
        print STDERR "Skipping  this url to test: $url\n";
        return 0;
    } else {
        print STDERR "Accepting: $url\n";
    }

    return 1;
}

#=======================================================================
# process_get_error() - hook function invoked whenever a GET fails
#=======================================================================
sub process_get_error
{
    my $robot     = shift;
    my $hook_name = shift;
    my $url       = shift;
    my $response  = shift;


# DR - Sep. 18, 2004 - don't print bad URLs
#    print "$url\n";
#    print "    error code ", $response->code, "\n";
}

#=======================================================================
# process_contents() - process the contents of a URL we've retrieved
#=======================================================================
sub process_contents
{
    my $robot     = shift;
    my $hook_name = shift;
    my $url       = shift;
    my $response  = shift;
    my $structure = shift;
    my $filename  = shift;

    return 1 if $response->content_type ne 'text/html';
print STDERR " correct: \n";
    print "$url\n";

    if ($response->base eq $url.'/')
    {
        print STDERR "    you should really have a trailing / on this URL: $url\n";
    }
    run_command($COMMAND, $filename) if defined $COMMAND;

}

#------------------------------------------------------------------------
# ParseCommandLine() - read configuration file for WebAssay
#
# This function reads the configuration file for WebAssay. There are
# three possible sources, which are tried in the following order:
#	1. -f switch on the command-line
#	2. $HOME/.webassay
#	3. local site configuration file
#------------------------------------------------------------------------
sub ParseCommandLine
{
    my @switches = (
                    'command=s',    \$COMMAND,
                    'email=s',      \$EMAIL,
                    'external',     \$EXTERNAL,
		    'test=s',       \$test,
                    'help',         \$SHOW_HELP,
                    'verbose',      \$VERBOSE,
                    'version',      \$SHOW_VERSION,
                    'traversal=s',  \$TRAVERSAL,
                   );

    &GetOptions(@switches) || die "use -help switch to display brief help\n";

    if ($SHOW_VERSION)
    {
        print "This is $BOTNAME, version $VERSION\n\n";
        exit 0;
    }

    if ($SHOW_HELP)
    {
        print <<EofHelp;
    $BOTNAME, v$VERSION - check a web site for broken links and other problems

    Usage: poacher [ -external ] [ -command program ] [ -test regex] url

        -command program : run the specified program on every URL
        -email address   : your contact email address
        -external        : check external URLs referenced in pages
        -test regex      : Pass in a regular expression to use for testing
                           URLs
	-help            : display this message
	-verbose         : display verbose information as running
	-version         : display the version of $BOTNAME
EofHelp
        exit 0;
    }

    if (@ARGV != 1 && @ARGV != 2)
    {
        die "$BOTNAME: you must give exactly one URL (the site root)\n";
    }

    #-------------------------------------------------------------------
    # We're gonna require the user to provide an email address.
    # We can probably be a lot smarter about working out a default.
    #-------------------------------------------------------------------
    if (!defined $EMAIL)
    {
        $EMAIL = $ENV{'USER'} || die "Please set your email address\n";
    }

    #--------------------------------------------------------------------
    # A single URL on the command-line at this point: the URL for the
    # root of the site we are to check.
    #--------------------------------------------------------------------
    $siteRoot = shift @ARGV;
    my @parts=split /\//, $siteRoot;
    my $siterootA=$parts[2];          # get the domain
    my @siteTail=split /\./, $siterootA;
    shift @siteTail;
    $siterootroot=join '.', @siteTail;

    $top = $siteRoot;
    $top =~ s/\/[^\/]+$//;

    my $url1 = new URI::URL $top;
    my $host = $url1->host;
    $host =~ s/^www.//g;
    $top = $host;
    print $top, "\n";

    $cache_file = shift @ARGV;
}

#=======================================================================
# run_command() - invoke a user-specified command on the page contents
#       $command   - the command to invoke
#	$filename  - path to file which we want to invoke the command on
#
#=======================================================================
sub run_command
{
    my $command      = shift;
    my $filename     = shift;

    my $pipe;

    $pipe = new IO::Pipe();
    $pipe->reader("$command $filename") || do
    {
	warn "Failed to open a pipe from \"$command $filename\": $!\n";
	return;
    };

    while (<$pipe>)
    {
	s/^/    /;
        print;
    }

    $pipe->close();
}

#-----------------------------------------------------------------------

sub sanityCheck($)
{
  my $url=shift;
  my @parts=split /\//, $url;
  my %frequency;
  my $doubled = 0;
  foreach my $dir (@parts)
  {
    if(defined $frequency{$dir})
      {
        $frequency{$dir}++;
        $doubled++ if $frequency{$dir}>=2;
        return 0 if $doubled >=2;
      }
    else
      { $frequency{$dir}=1;}
  }
  return 1;
}


=head1 EXAMPLE

The following example shows how you can use Poacher to check a site,
running weblint on every page seen:

    % poacher -command 'weblint -s' http://www.foobar.com/

The B<-s> switch to weblint enables short messages, where the filename
is not listed, just the line number.

=head1 TODO LIST

This is a brief list of some ideas related to Poacher:

=over 4

=item *

Generate a web page with the results.

=item *

Check external URLs to make sure they exist.

=item *

Configuration file, for setting proxies, email address,
and other information.

=back

=head1 SEE ALSO

=over 4

=item WWW::Robot

The robot module which provides the web traversal engine.

=item libwww-perl5

The collection of modules which provides all the base functionality
on which all this stuff is built. The modules are available in the
libwww-perl5 distribution on CPAN. Kudos to Gisle Aas.

=item Getopt::Long

Johan Vromans' module for parsing command-line options,
included in the Perl distribution.

=item Weblint

A perl script for checking the contents of a web page for syntax
errors, and other classes of problem.

=back

=head1 AUTHOR

Neil Bowers E<lt>neilb@cre.canon.co.ukE<gt>

=head1 COPYRIGHT

Copyright (C) 1997, Canon Research Centre Europe.

This script is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

#-----------------------------------------------------------------------
