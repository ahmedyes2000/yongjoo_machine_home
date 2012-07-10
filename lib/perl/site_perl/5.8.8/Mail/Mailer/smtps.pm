# Copyrights 1995-2010 by Mark Overmeer <perl@overmeer.net>.
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 1.06.
# Based on smtp.pm, adapted by Maciej Żenczykowski

use strict;

package Mail::Mailer::smtps;
use vars '$VERSION';
$VERSION = '2.06';

use base 'Mail::Mailer::rfc822';

use Net::SMTP::SSL;
use Mail::Util qw(mailaddress);
use Carp;

sub can_cc { 0 }

sub exec {
    my ($self, $exe, $args, $to) = @_;
    my %opt   = @$args;
    my $host  = $opt{Server} || undef;
    $opt{Debug} ||= 0;
    $opt{Port}  ||= 465;

    my $smtp = Net::SMTP::SSL->new($host, %opt)
	or return undef;

    if($opt{Auth})
    {   $smtp->auth(@{$opt{Auth}})
           or return undef;
    }

    ${*$self}{sock} = $smtp;

    $smtp->mail(mailaddress);
    $smtp->to($_) for @$to;
    $smtp->data;

    untie *$self if tied *$self;
    tie *$self, 'Mail::Mailer::smtps::pipe', $self;
    $self;
}

sub set_headers($)
{   my ($self, $hdrs) = @_;
    $self->SUPER::set_headers
     ( { From => "<" . mailaddress() . ">"
       , %$hdrs
       , 'X-Mailer' => "Mail::Mailer[v$Mail::Mailer::VERSION] "
           . " Net::SMTP[v$Net::SMTP::VERSION]"
           . " Net::SMTP::SSL[v$Net::SMTP::SSL::VERSION]"
       }
     );
}

sub epilogue()
{   my $self = shift;
    my $sock = ${*$self}{sock};

    $sock->dataend;
    $sock->quit;

    delete ${*$self}{sock};
    untie *$self;
}

sub close(@)
{   my ($self, @to) = @_;
    my $sock = ${*$self}{sock};

    $sock && fileno $sock
        or return 1;

    $self->epilogue;

    # Epilogue should destroy the SMTP filehandle,
    # but just to be on the safe side.
    $sock && fileno $sock
        or return 1;

    close $sock
        or croak 'Cannot destroy socket filehandle';

    1;
}

package Mail::Mailer::smtps::pipe;
use vars '$VERSION';
$VERSION = '2.06';


sub TIEHANDLE
{   my ($class, $self) = @_;
    my $sock = ${*$self}{sock};
    bless \$sock, $class;
}

sub PRINT
{   my $self = shift;
    my $sock = $$self;
    $sock->datasend( @_ );
}

1;
