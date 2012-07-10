#############################################################################
# $Id: Conn.pm,v 1.24.2.17 2007/06/14 09:21:14 gerv%gerv.net Exp $
#
# ***** BEGIN LICENSE BLOCK *****
# Version: MPL 1.1/GPL 2.0/LGPL 2.1
#
# The contents of this file are subject to the Mozilla Public License Version
# 1.1 (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
# http://www.mozilla.org/MPL/
#
# Software distributed under the License is distributed on an "AS IS" basis,
# WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
# for the specific language governing rights and limitations under the
# License.
#
# The Original Code is PerLDAP.
#
# The Initial Developer of the Original Code is
# Netscape Communications Corporation.
# Portions created by the Initial Developer are Copyright (C) 2001
# the Initial Developer. All Rights Reserved.
#
# Contributor(s):
#   Clayton Donley
#   Leif Hedstrom <leif@perldap.org>
#   Michelle Hedstrom <mwyner@perldap.org>
#
# Alternatively, the contents of this file may be used under the terms of
# either the GNU General Public License Version 2 or later (the "GPL"), or
# the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
# in which case the provisions of the GPL or the LGPL are applicable instead
# of those above. If you wish to allow use of your version of this file only
# under the terms of either the GPL or the LGPL, and not to allow others to
# use your version of this file under the terms of the MPL, indicate your
# decision by deleting the provisions above and replace them with the notice
# and other provisions required by the GPL or the LGPL. If you do not delete
# the provisions above, a recipient may use your version of this file under
# the terms of any one of the MPL, the GPL or the LGPL.
#
# ***** END LICENSE BLOCK *****

# DESCRIPTION
#    This is the main object class for connecting to an LDAP server,
#    and perform searches and updates. It depends on the ::Entry
#    object class, which is the data type returned from a search
#    operation for instance.

require 5.005;
package Mozilla::LDAP::Conn;

use Mozilla::LDAP::Utils 1.5 ();
use Mozilla::LDAP::API 1.5 qw(/.+/);
use Mozilla::LDAP::Entry 1.5 ();

use strict;
use vars qw($VERSION);

$VERSION = "1.5";


#############################################################################
# Creator, create and initialize a new LDAP object ("connection"). We support
# either providing all parameters as a hash array, or as individual
# arguments.
#
sub new
{
  my $class = shift;
  my $self = {};

  if (ref $_[$[] eq "HASH")
    {
      my $hash = shift;

      $self->{"host"} = $hash->{"host"} if defined($hash->{"host"});
      $self->{"port"} = $hash->{"port"} if defined($hash->{"port"});
      $self->{"binddn"} = $hash->{"bind"} if defined($hash->{"bind"});
      $self->{"bindpasswd"} = $hash->{"pswd"} if defined($hash->{"pswd"});
      $self->{"bindpasswd"} = $hash->{"password"} if defined($hash->{"password"});
      $self->{"certdb"} = $hash->{"cert"} if defined($hash->{"cert"});
      $self->{"certdb"} = $hash->{"certificate"} if defined($hash->{"certificate"});
      $self->{"version"} = $hash->{"vers"} || $hash->{"version"} || LDAP_VERSION3;
      $self->{"usenspr"} = 1 if (defined($hash->{"nspr"}) && $hash->{"nspr"});
      $self->{"callback"} = $hash->{"callback"} if defined($hash->{"callback"});
      $self->{"certname"} = $hash->{"certname"} if defined($hash->{"certname"});
      $self->{"keypwd"} = $hash->{"keypwd"} if defined($hash->{"keypwd"});
      $self->{"starttls"} = $hash->{"starttls"} if defined($hash->{"starttls"});
      $self->{"entryclass"} = $hash->{"entryclass"} || 'Mozilla::LDAP::Entry';
      if (defined($hash->{"timeout"})) {
        die "Can only use the timeout option with NSPR enabled connections"
          unless defined($self->{"usenspr"});
        $self->{"timeout"} = $hash->{"timeout"};
      }
    }
  else
    {
      my ($host, $port, $binddn, $bindpasswd, $certdb, $authmeth,
          $version, $nspr) = @_;

      $self->{"host"} = $host if defined($host);
      $self->{"port"} = $port if defined($port);
      $self->{"binddn"} = $binddn if defined($binddn);
      $self->{"bindpasswd"} = $bindpasswd if defined($bindpasswd);
      $self->{"certdb"} = $certdb if defined($certdb);
      $self->{"version"} = $version || LDAP_VERSION3;
      $self->{"usenspr"} = 1 if (defined($nspr) && $nspr);
      $self->{"entryclass"} = "Mozilla::LDAP::Entry";
    }

  # Anonymous bind is the default...
  $self->{"binddn"} = "" unless defined($self->{"binddn"});
  $self->{"bindpasswd"} = "" unless defined($self->{"bindpasswd"});

  # Find an appropriate default port number if not specified.
  if (!defined($self->{"port"}) || ($self->{"port"} eq ""))
    {
      if (defined($self->{"certdb"}) && ($self->{"certdb"} ne ""))
	{
	  $self->{"port"} = LDAPS_PORT;
	}
      else
	{
	  $self->{"port"} = LDAP_PORT;
	}
    }
  bless $self, $class;

  return unless $self->init();
  return $self;
}


#############################################################################
# Destructor, makes sure we close any open LDAP connections.
#
sub DESTROY
{
  my $self = shift;

  return unless defined($self->{"ld"});

  $self->close();
}


#############################################################################
# Initialize a normal connection. This seems silly, why not just merge
# this back into the creator method (new)...
#
sub init
{
  my $self = shift;
  my ($ret, $ld);

  return 0 unless (defined($self->{"host"}));
  return 0 unless (defined($self->{"port"}));

  if (defined($self->{"certdb"}) && ($self->{"certdb"} ne ""))
    { #use SSL
      $ret = ldapssl_client_init($self->{"certdb"}, 0);
      return 0 if ($ret < 0);

      if ($self->{"starttls"}) {
          $ld = ldap_init($self->{"host"}, $self->{"port"});
          return 0 unless $ld;

          $ret = prldap_install_routines($ld, 0);
          return 0 unless ($ret == LDAP_SUCCESS);
      } else { # regular ssl
          $ld = ldapssl_init($self->{"host"}, $self->{"port"}, 1);
      }

      if ($self->{"certname"}) { # enable clientauth
          $ret = ldapssl_enable_clientauth($ld, 0, $self->{"keypwd"}, $self->{"certname"});
          return 0 unless ($ret == LDAP_SUCCESS);
      }

      if ($self->{"starttls"}) {
          $ret = ldap_start_tls_s($ld, 0, 0);
          return 0 unless ($ret == LDAP_SUCCESS);
      }
    }
  else
    {
      $ld = ldap_init($self->{"host"}, $self->{"port"});
    }
  return 0 unless $ld;
  $self->{"ld"} = $ld;

  if (defined($self->{"usenspr"})) {
    if (!$self->{"starttls"}) { # already did this above for starttls
        $ret = prldap_install_routines($self->{"ld"}, 0);
        return 0 unless ($ret == LDAP_SUCCESS);
    }
    if (defined($self->{"timeout"})) {
      $ret = prldap_set_session_option($self->{"ld"}, 0,
                                       PRLDAP_OPT_IO_MAX_TIMEOUT,
                                       $self->{"timeout"});
      return 0 unless ($ret == LDAP_SUCCESS);
    }
  }

  $self->setVersion($self->{"version"});

  if ($self->{"certname"}) # client auth - must use sasl bind
    {
      my $rc = ldap_sasl_bind_s($ld, "", "EXTERNAL", 0, 0, 0, 0);
      if ($rc != LDAP_SUCCESS) {
          my ($dn, $errmsg);
          $rc = $self->getErrorCode(\$dn, \$errmsg);
          print "Error: $rc - ", $self->getErrorString(), ": $errmsg for certname ", $self->{"certname"}, "\n";
      }
      return (($rc == LDAP_SUCCESS) ? 1 : 0);
    }
  elsif (defined($self->{"callback"}))
    {
      my ($result, $ret);
      my $id = ldap_simple_bind($ld, $self->{"binddn"}, $self->{"bindpasswd"});

      $ret = ldap_result($ld, $id, 0, 1, $result);
      return 0 unless ($ret == LDAP_RES_BIND);

      # The callback must return  1 or 0 (success or failure on the login).
      $ret = $self->{"callback"}($self, $result);
      ldap_msgfree($result);
      return $ret;
    }
  else
    {
      $ret = ldap_simple_bind_s($ld, $self->{"binddn"}, $self->{"bindpasswd"});
      return (($ret == LDAP_SUCCESS) ? 1 : 0);
    }
}


#############################################################################
# Create a new, empty, Entry object, properly tied into the Entry class.
# This is mostly for convenience, you could directly do the "tie" yourself
# in your code.
#
sub newEntry
{
  my ($self, $dn) = @_;
  my $entry;

  if (ref $self) {
    $entry = $self->{"entryclass"}->new();
  } else {
    $entry = Mozilla::LDAP::Entry->new();
  }

  $entry->setDN($dn) if (defined($dn) && $dn ne "");

  return $entry;
}


#############################################################################
# Checks if a string is a properly formed LDAP URL.
#
sub isURL
{
  my ($self, $url) = @_;

  return ldap_is_ldap_url($url);
}


#############################################################################
# Return the actual low level LD connection structure, which is needed if
# you want to call any of the API functions yourself...
#
sub getLD
{
  my $self = shift;

  return $self->{"ld"} if defined($self->{"ld"});
}


#############################################################################
# Return the actual the current result message, don't use this unless you
# really have to...
#
sub getRes
{
  my $self = shift;

  return $self->{"ldres"} if defined($self->{"ldres"});
}


#############################################################################
# Return the Error code from the last LDAP api function call. The last two
# optional arguments are pointers to strings, and will be set to the
# match string and extra error string if appropriate.
#
sub getErrorCode
{
  my $self = shift;
  my ($match, $msg);

  return LDAP_SUCCESS unless defined($self->{"ld"});

  if (ref $_[$[] eq "HASH")
    {
      my $hash = shift;

      $match = $hash->{"match"} if defined($hash->{"match"});
      $msg = $hash->{"mesg"} if defined($hash->{"mesg"});
    }
  else
    {
      ($match, $msg) = @_;
    }

  return $self->{"searchres"} if defined($self->{"searchres"});
  return ldap_get_lderrno($self->{"ld"}, $match, $msg);
}
*getError = \*getErrorCode;


#############################################################################
# Return the Error string from the last LDAP api function call.  
#
sub getErrorString 
{
  my $self = shift;
  my $err;
  
  return LDAP_SUCCESS unless defined($self->{"ld"});
  if (defined($self->{"searchres"}))
    {
      $err = $self->{"searchres"};
    }
  else
    {
      $err = ldap_get_lderrno($self->{"ld"}, undef, undef);
    }

  return ldap_err2string($err);
}


#############################################################################
# Print the last error code...
#
sub printError
{
  my ($self, $str) = @_;

  return unless defined($self->{"ld"});

  $str = "LDAP error:" unless defined($str);
  print "$str ", $self->getErrorString(), "\n";
}


#############################################################################
# Normal LDAP search. Note that this will actually perform LDAP URL searches
# if the filter string looks like a proper URL.
#
sub search
{
  my $self = shift;
  my ($basedn, $scope, $filter, $attrsonly, $attrs, $res, $sortattrs, $cmp);

  if (ref $_[$[] eq "HASH")
    {
      my $hash = shift;

      $basedn = $hash->{"base"} || "";
      $scope = Mozilla::LDAP::Utils::str2Scope($hash->{"scope"});
      $filter = $hash->{"filter"} || "(objectclass=*)";
      $attrsonly = $hash->{"attrsonly"} || undef;
      $attrs = $hash->{"attrs"} || undef;
      $sortattrs = $hash->{"sortattrs"} || undef;
      $cmp = $hash->{"cmp"} || undef;
    }
  else
    {
      my @rest;

      ($basedn, $scope, $filter, $attrsonly, @rest) = @_;
      $scope = Mozilla::LDAP::Utils::str2Scope($scope);
      if (ref $rest[0] eq "ARRAY")
        {
          $attrs = $rest[0];
        }
      elsif (scalar(@rest) > 0)
        {
          $attrs = \@rest;
        }
      else
        {
          $attrs = undef;
          $sortattrs = undef;
          $cmp = undef;
        }
    }
  $filter = "(objectclass=*)" if ($filter =~ /^ALL$/i);

  if (defined($self->{"ldres"}))
    {
      ldap_msgfree($self->{"ldres"});
      undef $self->{"ldres"};
    }
  $self->{"ldres"} = 0;		# This gets rid of the annoying warning
  if (defined($self->{"searchres"}))
    {
      undef $self->{"searchres"};
    }

  if (ldap_is_ldap_url($filter))
    {
      $res = ldap_url_search_s($self->{"ld"}, $filter, $attrsonly,
                               $self->{"ldres"});
      if ($res == LDAP_SUCCESS || $res == LDAP_TIMELIMIT_EXCEEDED ||
          $res == LDAP_SIZELIMIT_EXCEEDED ||$res == LDAP_ADMINLIMIT_EXCEEDED)
	{
          $self->{"searchres"} = $res unless $res == LDAP_SUCCESS;
	  $self->{"ldfe"} = 1;
          if (defined($sortattrs))
            {
              if (scalar(@{$sortattrs}) > 1)
                {
                  ldap_multisort_entries($self->{"ld"}, $self->{"ldres"},
                                         $sortattrs, $cmp);
                }
              else
                {
                  ldap_sort_entries($self->{"ld"}, $self->{"ldres"},
                                    $sortattrs->[0], $cmp);
                }
            }

	  return $self->nextEntry();
	}
    }
  else
    {
      $res = ldap_search_s($self->{"ld"}, $basedn, $scope, $filter,
                           defined($attrs) ? $attrs : 0,
                           defined($attrsonly) ? $attrsonly : 0,
                           $self->{"ldres"});
      if ($res == LDAP_SUCCESS || $res == LDAP_TIMELIMIT_EXCEEDED ||
          $res == LDAP_SIZELIMIT_EXCEEDED ||$res == LDAP_ADMINLIMIT_EXCEEDED)
        {
          $self->{"searchres"} = $res unless $res == LDAP_SUCCESS;
	  $self->{"ldfe"} = 1;
          if (defined($sortattrs))
            {
              if (scalar(@{$sortattrs}) > 1)
                {
                  ldap_multisort_entries($self->{"ld"}, $self->{"ldres"},
                                         $sortattrs, $cmp);
                }
              else
                {
                  ldap_sort_entries($self->{"ld"}, $self->{"ldres"},
                                    $sortattrs->[0], $cmp);
                }
            }

	  return $self->nextEntry();
	}
    }

  undef $self->{"ldres"};
  return "";
}


#############################################################################
# URL search, optimized for LDAP URL searches.
#
sub searchURL
{
  my $self = shift;
  my ($url, $attrsonly, $res);

  if (ref $_[$[] eq "HASH")
    {
      my $hash = shift;

      $url = $hash->{"url"};
      $attrsonly = $hash->{"attrsonly"} || 0;
    }
  else
    {
      ($url, $attrsonly) = @_;
    }

  if (defined($self->{"ldres"}))
    {
      ldap_msgfree($self->{"ldres"});
      undef $self->{"ldres"};
    }
  $self->{"ldres"} = 0;		# This avoids the annoying warnings
  if (defined($self->{"searchres"}))
    {
      undef $self->{"searchres"};
    }
      
  $res = ldap_url_search_s($self->{"ld"}, $url,
                           defined($attrsonly) ? $attrsonly : 0,
                           $self->{"ldres"});
  if ($res == LDAP_SUCCESS || $res == LDAP_TIMELIMIT_EXCEEDED ||
      $res == LDAP_SIZELIMIT_EXCEEDED ||$res == LDAP_ADMINLIMIT_EXCEEDED)
    {
      $self->{"searchres"} = $res unless $res == LDAP_SUCCESS;
      $self->{"ldfe"} = 1;
      return $self->nextEntry();
    }

  undef $self->{"ldres"};
  return "";
}


#############################################################################
# Browse an LDAP entry, very much like the regular search, except we set
# some defaults (like scope=BASE, filter=(objectclass=*) and so on). Note
# that this method does not support the attributesOnly flag.
#
sub browse
{
  my $self = shift;
  my ($basedn, @attrs, $scope, $attrsonly);

  if (ref $_[$[] eq "HASH")
    {
      my $hash = shift;

      $basedn = $hash->{"base"} || "";
      $attrsonly = $hash->{"attrsonly"} || 0;
      @attrs = @{$hash->{"attrs"}} if defined($hash->{"attrs"});
    }
  else
    {
      ($basedn, @attrs) = @_;
      $attrsonly = 0;
    }
  $scope = Mozilla::LDAP::Utils::str2Scope("BASE");

  return $self->search($basedn, $scope, "(objectclass=*)", $attrsonly, @attrs);
}


#############################################################################
# Compare an attribute value against a DN in the server (without having to
# do a search first).
#
sub compare
{
  my $self = shift;
  my ($dn, $attr, $value);

  if (ref $_[$[] eq "HASH")
    {
      my $hash = shift;

      $dn = $hash->{"dn"} if defined($hash->{"dn"});
      $attr = $hash->{"attr"} if defined($hash->{"attr"});
      $value = $hash->{"value"} if defined($hash->{"value"});
    }
  else
    {
      ($dn, $attr, $value) = @_;
    }

  return ldap_compare_s($self->{"ld"}, $dn, $attr, $value) ==
    LDAP_COMPARE_TRUE;
}


#############################################################################
# Get an entry from the search, either the first entry, or the next entry,
# depending on the call order.
#
sub nextEntry
{
  my ($self) = shift;
  my (%entry, @ocorder, @vals);
  my ($attr, $lcattr, $obj, $ldentry, $berv, $dn, $count);
  my $ber = \$berv;

  # I use the object directly, to avoid setting the "change" flags
  $obj = tie %entry, $self->{"entryclass"};

  $self->{"dn"} = "";
  if ($self->{"ldfe"} == 1)
    {
      return "" unless defined($self->{"ldres"});

      $self->{"ldfe"} = 0;
      $ldentry = ldap_first_entry($self->{"ld"}, $self->{"ldres"});
      $self->{"ldentry"} = $ldentry;
    }
  else
    {
      return "" unless defined($self->{"ldentry"});

      $ldentry = ldap_next_entry($self->{"ld"}, $self->{"ldentry"}); 
      $self->{"ldentry"} = $ldentry;
    }
  if (! $ldentry)
    {
      if (defined($self->{"ldres"}))
	{
	  ldap_msgfree($self->{"ldres"});
	  undef $self->{"ldres"};
	}

      return "";
    }

  $dn = ldap_get_dn($self->{"ld"}, $self->{"ldentry"});
  $obj->{"_oc_numattr_"} = 0;
  $obj->{"_oc_keyidx_"} = 0;
  $obj->{"dn"} = $dn;
  $self->{"dn"} = $dn;

  $attr = ldap_first_attribute($self->{"ld"}, $self->{"ldentry"}, $ber);
  return (bless \%entry, $self->{"entryclass"}) unless $attr;

  $lcattr = lc $attr;
  @vals = ldap_get_values_len($self->{"ld"}, $self->{"ldentry"}, $attr);
  $obj->{$lcattr} = [@vals];
  push(@ocorder, $lcattr);

  $count = 1;
  while ($attr = ldap_next_attribute($self->{"ld"},
				     $self->{"ldentry"}, $ber))
    {
      $lcattr = lc $attr;
      @vals = ldap_get_values_len($self->{"ld"}, $self->{"ldentry"}, $attr);
      $obj->{$lcattr} = [@vals];
      push(@ocorder, $lcattr);
      $count++;
    }

  $obj->{"_oc_order_"} = \@ocorder;
  $obj->{"_oc_numattr_"} = $count;

  ldap_ber_free($ber, 0) if $ber;

  return bless \%entry, $self->{"entryclass"};
}

# This is deprecated...
*entry = \*nextEntry;


#############################################################################
# Close the connection to the LDAP server.
#
sub close
{
  my $self = shift;

  ldap_unbind_s($self->{"ld"}) if defined($self->{"ld"});
  if (defined($self->{"ldres"}))
    {
      ldap_msgfree($self->{"ldres"});
      undef $self->{"ldres"};
    }
  undef $self->{"ld"} if defined($self->{"ld"});

  return 1;
}


#############################################################################
# Delete an object.
#
sub delete
{
  my ($self, $id) = @_;
  my $ret = LDAP_SUCCESS;
  my $dn = $id;

  if (UNIVERSAL::isa($id, 'Mozilla::LDAP::Entry'))
    {
      $dn = $id->getDN();
    }
  else
    {
      $dn = $self->{"dn"} unless (defined($dn) && ($dn ne ""));
    }

  $dn = Mozilla::LDAP::Utils::normalizeDN($dn);
  $ret = ldap_delete_s($self->{"ld"}, $dn) if ($dn ne "");

  return (($ret == LDAP_SUCCESS) ? 1 : 0);
}


#############################################################################
# Add an object.
#
sub add
{
  my ($self, $entry) = @_;
  my %ent;
  my ($key, $val);
  my ($ret, $gotcha) = (1, 0);

  if (UNIVERSAL::isa($entry, 'Mozilla::LDAP::Entry'))
    {
      foreach $key (@{$entry->{"_oc_order_"}})
	{
	  next if (($key eq "dn") || ($key =~ /^_.+_$/));
          next if $entry->{"_${key}_deleted_"};
	  $ent{$key} = { "ab" => $entry->{$key} };
	  $gotcha++;
	  $entry->attrClean($key);
	}
    }
  elsif  (ref $entry eq 'HASH')
    {
      foreach $key (keys(%{$entry}))
	{
	  next if (($key eq "dn") || ($key =~ /^_.+_$/));
	  $ent{$key} = { "ab" => $entry->{$key} };
	  $gotcha++;
	}
    }
  else
    {
      # We can't handle this, so let's just return.
      return 0;
    }

  if ($gotcha > 0 )
    {
      $ret = ldap_add_s($self->{"ld"}, $entry->{"dn"}, \%ent);
      return (($ret == LDAP_SUCCESS) ? 1 : 0);
    }

  return 0;
}


#############################################################################
# Modify the RDN, and update the entry accordingly. Note that the last
# two arguments (DN and "delete") are optional. The last (optional) argument
# is a flag, which if set to TRUE (the default), will cause the corresponding
# attribute value to be removed from the entry.
#
sub modifyRDN
{
  my $self = shift;
  my ($rdn, $dn, $del, @vals);
  my $ret = LDAP_SUCCESS;

  if (ref $_[$[] eq "HASH")
    {
      my $hash = shift;

      $rdn = $hash->{"rdn"} if defined($hash->{"rdn"});
      $dn = $hash->{"dn"} if defined($hash->{"dn"});
      $del = $hash->{"delete"} if defined($hash->{"delete"});
    }
  else
    {
      ($rdn, $dn, $del) = @_;
    }

  $del = 1 unless (defined($del) && ($del ne ""));
  $dn = $self->{"dn"} unless (defined($dn) && ($dn ne ""));

  @vals = ldap_explode_dn($dn, 0);
  if (lc($vals[$[]) ne lc($rdn))
    {
      $ret = ldap_modrdn2_s($self->{"ld"}, $dn, $rdn, $del);
      if ($ret == LDAP_SUCCESS)
	{
	  shift(@vals);
	  unshift(@vals, ($rdn));
	  $self->{"dn"} = join(@vals);
	}
    }

  return (($ret == LDAP_SUCCESS) ? 1 : 0);
}


#############################################################################
# Update an object. NOTE: I'd like to clean up my change tracking tags here,
# so that we can call update() again with the same entry.
#
sub update
{
  my ($self, $entry) = @_;
  my ($vals, @add, @remove, %mod, %new);
  my ($key, $val);
  my $ret = LDAP_SUCCESS;
  local $_;

  foreach $key (@{$entry->{"_oc_order_"}})
    {
      next if (($key eq "dn") || ($key =~ /^_.+_$/));

      $vals = defined($entry->{$key}) ?
                $entry->{$key}        :
                [ ];

      if (defined($entry->{"_${key}_deleted_"}))
        {
          $mod{$key} = { "db", [] };
	  undef @{$entry->{$key}};
        }
      elsif (defined($entry->{"_${key}_modified_"}))
        {
          @remove = ();
          undef %new;
          grep(($new{$_} = 1), @{$vals});
          if (defined($entry->{"_${key}_save_"}))
            {
              foreach (@{$entry->{"_${key}_save_"}})
                {
                  if (! $new{$_})
                    {
                      push(@remove, $_);
                    }
                  $new{$_} = 0;
                }
            }

          @add = ();
          foreach (@{$vals})
            {
              push(@add, $_) if ($new{$_} == 1);
            }

          if ((scalar(@remove) + scalar(@add)) < scalar(@{$vals}))
            {
              $mod{$key}{"db"} = [ @remove ] if ($#remove >= $[);
              $mod{$key}{"ab"} = [ @add ] if ($#add >= $[);
            }
          else
            {
              $mod{$key}{"rb"} = [ @{$vals} ];
            }
        }
      $entry->attrClean($key);
    }

  # This is here for debug purposes only...
  if ($main::LDAP_DEBUG)
    {
      my $op;

      foreach $key (keys(%mod))
	{
	  print "Working on $key\n";
	  foreach $op (keys %{$mod{$key}})
	    {
	      print "\tDoing operation: $op\n";
	      foreach $val (@{$mod{$key}{$op}})
		{
		  print "\t\t$val\n";
		}
	    }
	}
    }

  $ret = ldap_modify_s($self->{"ld"}, $entry->{"dn"}, \%mod)
    if %mod;

  return (($ret == LDAP_SUCCESS) ? 1 : 0);
}


#############################################################################
# Set the rebind procedure. We also provide a neat default rebind procedure,
# which takes three arguments (DN, password, and the auth method). This is an
# extension to the LDAP SDK, which I think should be there. It was also
# needed to get this to work on Win/NT...
#
sub setRebindProc
{
  my ($self, $proc) = @_;

  # Should we try to reinitialize the connection?
  die "No LDAP connection" unless defined($self->{"ld"});

  ldap_set_rebind_proc($self->{"ld"}, $proc);
}

sub setDefaultRebindProc
{
  my ($self, $dn, $pswd, $auth) = @_;

  $auth = LDAP_AUTH_SIMPLE unless defined($auth);
  die "No LDAP connection"
    unless defined($self->{"ld"});

  ldap_set_default_rebind_proc($self->{"ld"}, $dn, $pswd, $auth);
}


#############################################################################
# Do a simple authentication, so that we can rebind as another user.
#
sub simpleAuth
{
  my ($self, $dn, $pswd) = @_;
  my $ret;

  $ret = ldap_simple_bind_s($self->{"ld"}, $dn, $pswd);

  return (($ret == LDAP_SUCCESS) ? 1 : 0);
}


#############################################################################
# Set arbitrary option (this is flaky, can only handle "int" options ...)
#
sub setOption
{
  my $self = shift;
  my ($option, $value, $ret);

  if (ref $_[$[] eq "HASH")
    {
      my $hash = shift;

      $option = $hash->{"option"};
      $value = $hash->{"value"};
    }
  else
    {
      ($option, $value) = @_;
    }

  $ret = ldap_set_option($self->{"ld"}, $option, $value);
  return (($ret == LDAP_SUCCESS) ? 1 : 0);
}

sub getOption
{
  my ($self, $option) = @_;
  my ($ret, $value);

  $ret = ldap_get_option($self->{"ld"}, $option, $value);
  return (($ret == LDAP_SUCCESS) ? $value : undef);
}


#############################################################################
# Set/get LDAP protocol version
#
sub setVersion
{
  my ($self, $ver) = @_;
  my $ret = LDAP_SUCCESS;

  if ($ver eq "1")
    {
      $self->{"version"} = LDAP_VERSION1;
    }
  elsif ($ver eq "2")
    {
      $self->{"version"} = LDAP_VERSION2;
    }
  else
    {
      $self->{"version"} = LDAP_VERSION3;
    }

  if ($self->{"version"} ne LDAP_VERSION2)
    {
      $ret = ldap_set_option($self->{"ld"}, LDAP_OPT_PROTOCOL_VERSION,
                             $self->{"version"});
      return (($ret == LDAP_SUCCESS) ? 1 : 0);
    }

  return 1;
}

sub getVersion
{
  return $_[0]->{"version"};
}


#############################################################################
# Set sizelimit, convenience wrapper.
#
sub setSizelimit
{
  my ($self, $limit) = @_;
  my $ret;

  $ret = $self->setOption(LDAP_OPT_SIZELIMIT, $limit);
  return (($ret == LDAP_SUCCESS) ? 1 : 0);
}

sub getSizelimit
{
  my $self = shift;
  my ($ret, $limit);

  $ret = ldap_get_option($self->{"ld"}, LDAP_OPT_SIZELIMIT, $limit);
  return (($ret == LDAP_SUCCESS) ? $limit : undef);
}


#############################################################################
# Install NSPR I/O, threading, and DNS functions so they will be used by
# the LDAP * handle (ld)
sub installNSPR
{
  my $arg = shift;
  my $shared = shift || 0;
  my $ret;

  if (ref $arg)
    {
      $arg->close();
      $arg->{"usenspr"} = 1;
      $arg->init();
    }
  else
    {
      $ret = prldap_install_routines(0, $shared);
    }

  return (($ret == LDAP_SUCCESS) ? 1 : 0);
}


#############################################################################
# Set the NSPR I/O timeout (in milliseconds). This can only be used after
# you have installed the NSPR layer (using installNSPR).
#
sub setNSPRTimeout
{
  my $arg = shift;
  my $timeout = shift || 0;
  my $ret;

  if (ref $arg)
    {
      return 0 unless defined($arg->{"usenspr"});
      $ret = prldap_set_session_option($arg->{"ld"}, 0,
                                       PRLDAP_OPT_IO_MAX_TIMEOUT,
                                       $timeout);
    }
  else
    {
      $ret = prldap_set_session_option(0, 0,
                                       PRLDAP_OPT_IO_MAX_TIMEOUT,
                                       $timeout);
    }

  return (($ret == LDAP_SUCCESS) ? 1 : 0);
}


#############################################################################
# SearchIter allows PerLDAP to support asynchronous searching - that is, to
# support having a Conn doing two or more simultaneous searches.  Objects
# of the class SearchIter should not be created directly, but should only
# be created by calling the Conn->async_search method (see below).  The
# nextEntry method is used to iterate over the search results and works
# just like the Conn method of the same name.  If search result
# processing is aborted before all of the search results have been
# returned, the abandon method should be called to close the connection
# to allow the server and client to reclaim resources.
#
{
  package SearchIter;

  import Mozilla::LDAP::API qw(:api :ssl :apiv3 :constant); # Direct access to C API

  # arguments to new() are the Conn object used to invoke the search
  # and the msgid returned from the ldap_search* call
  sub new {
	my $that = shift;
	my ($conn, $msgid, $timeout) = @_;
	my $class = ref($that) || $that;
    if (!$timeout) {
	  ldap_get_option($conn->getLD(), LDAP_OPT_TIMELIMIT(), \$timeout);
	  if (!$timeout) {
		  $timeout = 30; # 30 seconds
	  }
	}
	my $self = { conn => $conn, msgid => $msgid, timeout => $timeout };
	bless $self, $class;
	return $self;
  }

  # just returns the error code from the underlying Conn
  sub getErrorCode {
	my $self = shift;
	return $self->{conn}->getErrorCode();
  }

  # this function returns the next Entry
  sub nextEntry {
	my $self = shift;
	my $timeout = shift;
	my ($rc, $ld, $res);
	my (%entry, $obj, $berv);
	my $ber = \$berv;

	return "" unless $self->{msgid};
	if ($timeout) {
	  $self->{timeout} = $timeout; # change timeout
	} else {
	  $timeout = $self->{timeout}; # use pre configured one
	}

	# I use the object directly, to avoid setting the "change" flags
	$obj = tie %entry, 'Mozilla::LDAP::Entry';

	$ld = $self->{conn}->getLD();
	$rc = ldap_result($ld, $self->{msgid}, 0, $timeout, $res);
	if ($rc == -1) { # error
	  print "Error getting ldap result for msgid ", $self->{msgid}, "\n";
	  undef $self->{msgid};
	} elsif ($rc == 0) { # timeout
	  print "Timeout getting ldap result for msgid ", $self->{msgid}, "\n";
	} elsif ($rc == LDAP_RES_SEARCH_RESULT()) { # done - get result
#	  print "Search done, got result for msgid ", $self->{msgid}, "\n" if $verbose;
	  undef $self->{msgid};
	} elsif ($rc == LDAP_RES_SEARCH_REFERENCE()) { # referral?
	  print "Got a referral as a search result\n";
	} else { # regular entry search result
	  my $dn = ldap_get_dn($ld, $res);
	  $self->{dn} = $dn; # keep last DN that was read
	  $self->{res} = $res; # keep last res that was read
#	  print "Got $dn as next entry for msgid ", $self->{msgid}, "\n" if $verbose;
	  $obj->{"_oc_numattr_"} = 0;
	  $obj->{"_oc_keyidx_"} = 0;
	  $obj->{"dn"} = $dn;
	  my $attr = ldap_first_attribute($ld, $res, $ber);
	  return (bless \%entry, 'Mozilla::LDAP::Entry') unless $attr;

	  my $lcattr = lc $attr;
	  my @vals = ldap_get_values_len($ld, $res, $attr);
	  $obj->{$lcattr} = [@vals];
	  my @ocorder;
	  push(@ocorder, $lcattr);

	  my $count = 1;
	  while ($attr = ldap_next_attribute($ld, $res, $ber)) {
		$lcattr = lc $attr;
		@vals = ldap_get_values_len($ld, $res, $attr);
		$obj->{$lcattr} = [@vals];
		push(@ocorder, $lcattr);
		$count++;
	  }

	  $obj->{"_oc_order_"} = \@ocorder;
	  $obj->{"_oc_numattr_"} = $count;

	  ldap_ber_free($ber, 0) if $ber;
	  ldap_msgfree($res) if $res;

	  return bless \%entry, 'Mozilla::LDAP::Entry';
	}

	ldap_msgfree($res) if $res;
	return ""; # search failed
  }

  # use this method when it is desired to abort search result processing
  # before all of the results have been returned from the server
  sub abandon {
	my $self = shift;
	ldap_abandon($self->{conn}->getLD(), $self->{msgid});
	undef $self->{msgid};
  }
}

#############################################################################
# This starts an asynchronous search.  It returns a SearchIter
# use the SearchIter->nextEntry method to get the next entry
# you can have multiple async searches going at once, so you can do
# nested searches, for example
# use SearchIter->getErrorCode() to see if the search had errors
#
sub async_search
{
  my $self = shift;
  my ($basedn, $scope, $filter, $attrsonly, $attrs, $msgid, $iter);

  if (ref $_[$[] eq "HASH")
    {
      my $hash = shift;

      $basedn = $hash->{"base"} || "";
      $scope = Mozilla::LDAP::Utils::str2Scope($hash->{"scope"});
      $filter = $hash->{"filter"} || "(objectclass=*)";
      $attrsonly = $hash->{"attrsonly"} || undef;
      $attrs = $hash->{"attrs"} || undef;
    }
  else
    {
      my @rest;

      ($basedn, $scope, $filter, $attrsonly, @rest) = @_;
      $scope = Mozilla::LDAP::Utils::str2Scope($scope);
      if (ref($rest[0]) eq "ARRAY")
        {
          $attrs = $rest[0];
        }
      elsif (scalar(@rest) > 0)
        {
          $attrs = \@rest;
        }
      else
        {
          $attrs = undef;
        }
    }
  $filter = "(objectclass=*)" if ($filter =~ /^ALL$/i);

  if (ldap_is_ldap_url($filter))
    {
      $msgid = ldap_url_search($self->{"ld"}, $filter, $attrsonly);
    }
  else
    {
      $msgid = ldap_search($self->{"ld"}, $basedn, $scope, $filter,
                           defined($attrs) ? $attrs : 0,
                           defined($attrsonly) ? $attrsonly : 0)
	}
  $iter = new SearchIter($self, $msgid);
  return $iter;
}

#############################################################################
# Mandatory TRUE return value.
#
1;


#############################################################################
# POD documentation...
#
__END__

=head1 NAME

  Mozilla::LDAP::Conn - Object Oriented API for the LDAP SDK.

=head1 SYNOPSIS

  use Mozilla::LDAP::Conn;
  use Mozilla::LDAP::Utils;

=head1 ABSTRACT

This package is the main API for using our Perl Object Oriented LDAP
module. Even though it's certainly possible, and sometimes even necessary,
to call the native LDAP C SDK functions, we strongly recommend you use
these object classes.

It's not required to use our Mozilla::LDAP::Utils.pm package, but it's
convenient and good for portability if you use as much as you can from
that package as well. This implies using the LdapConf package as well,
even though you usually don't need to use it directly.

You should read this document in combination with the Mozilla::LDAP::Entry
document. Both modules depend on each other heavily.

=head1 DESCRIPTION

First, this is not ment to be a crash course in how LDAP works, if you
have no experience with LDAP, I suggest you read some of the literature
that's available out there. The LDAP Deployment Book from Netscape, or the
LDAP C SDK documentation are good starting points.

This object class basically tracks and manages the LDAP connection, it's
current status, and the current search operation (if any). Every time you
call the B<search> method of an object instance, you'll reset it's
internal state. It depends heavily on the ::Entry class, which are used to
retrieve, modify and update a single entry.

The B<search> and B<nextEntry> methods returns Mozilla::LDAP::Entry
objects, or an appropriately subclass of it. You also have to instantiate
(and modify) a new ::Entry object when you want to add new entries to an LDAP
server. Alternatively, the add() method will also take a hash array as
argument, to make it easy to create new LDAP entries.

To assure that changes to an entry are updated properly, we strongly
recommend you use the native methods of the ::Entry object class. Even
though you can modify certain elements directly, it could cause changes
not to be committed to the LDAP server. If there's something missing from
the API, please let us know, or even fix it yourself.

=head1 SOME PERLDAP/OO BASICS

An entry consist of a DN, and a hash array of pointers to attribute
values. Each attribute value (except the DN) is an array, but you have to
remember the hash array in the entry stores pointers to the array, not the
array. So, to access the first CN value of an entry, you'd do

    $cn = $entry->{cn}[0];

To set the CN attribute to a completely new array of values, you'd do

    $entry->{cn} = [ "Leif Hedstrom", "The Swede" ];

As long as you remember this, and try to use native Mozilla::LDAP::Entry
methods, this package will take care of most the work. Once you master
this, working with LDAP in Perl is surprisingly easy.

We already mentioned DN, which stands for Distinguished Name. Every entry
on an LDAP server must have a DN, and it's always guaranteed to be unique
within your database. Some typical DNs are

    uid=leif,ou=people,o=netscape.com
    cn=gene-staff,ou=mailGroup,o=netscape.com
    dc=data,dc=netscape,dc=com

There's also a term called RDN, which stands for Relative Distinguished
Name. In the above examples, C<uid=leif>, C<cn=gene-staff> and C<dc=data>
are all RDNs. One particular property for a RDN is that they must be
unique within it's sub-tree. Hence, there can only be one user with
C<uid=leif> within the C<ou=people> tree, there can never be a name
conflict.

=head1 CREATING A NEW OBJECT INSTANCE

Before you can do anything with PerLDAP, you'll need to instantiate at
least one Mozilla::LDAP::Conn object, and connect it to an LDAP server. As
you probably guessed already, this is done with the B<new> method:

    $conn = Mozilla::LDAP::Conn->new("ldap", "389", $bind, $pswd, $cert, $ver);
    die "Couldn't connect to LDAP server ldap" unless  $conn;

The arguments are: Host name, port number, and optionally a bind-DN, it's
password, and a certificate. A recent addition is the LDAP protocol version,
which is by default LDAP v3. If there is no bind-DN, the connection will
be bound as the anonymous user. If the certificate file is specified, the
connection will be over SSL, and you should then probably connect to port
636. You have to check that the object was created properly, and take
proper actions if you couldn't get a connection.

There's one convenient alternative call method to this function. Instead of
providing each individual argument, you can provide one hash array
(actually, a pointer to a hash). For example:

    %ld = Mozilla::LDAP::Utils::ldapArgs();
    $conn = Mozilla::LDAP::Conn->new(\%ld);

The components of the hash are:

    $ld->{"host"}
    $ld->{"port"}
    $ld->{"base"}
    $ld->{"bind"}
    $ld->{"pswd"}
    $ld->{"cert"}
    $ld->{"vers"}

and (not used in the B<new> method)

    $ld->{"scope"}

New for PerLDAP v1.5 and later are the following:

    $ld->{"nspr"}
    $ld->{"timeout"}
    $ld->{"callback"}
    $ld->{"entryclass"}

The B<nspr> flag (1/0) indicates that we wish to use the NSPR layer for
the LDAP connection. This obviously only works if PerLDAP has been compiled
with NSPR support and libraries. The default is for NSPR to be disabled.

For an NSPR enabled connection, you can also provide an optional timeout
parameter, which will be used during the lifetime of the connection. This
includes the initial setup and connection to the LDAP server. You can change
this parameter later using the B<setNSPRTimeout()> method.

During the bind process, you can provide a callback function to be called
when the asynchronus bind has completed. The callback should take two
arguments, a reference to the ::Conn object ("self") and a result structure
as returned by the call to B<ldap_result()>.

Finally, you can optionally specify what class the different methods
should use when instantiating B<Entry> result objects. The default is
Mozilla::LDAP::Entry.

Once a connection is established, the package will take care of the
rest. If for some reason the connection is lost, the object should
reconnect on it's own, automatically. [Note: This doesn't work
now... ]. You can use the Mozilla::LDAP:Conn object for any number of
operations, but since everything is currently done synchronously, you can
only have one operation active at any single time. You can of course have
multiple Mozilla::LDAP::Conn instanced active at the same time.

=head1 PERFORMING LDAP SEARCHES

We assume that you are familiar with the LDAP filter syntax already, all
searches performed by this object class uses these filters. You should
also be familiar with LDAP URLs, and LDAP object classes. There are some
of the few things you actually must know about LDAP. Perhaps the simples
filter is

    (uid=leif)

This matches all entries with the UID set to "leif". Normally that
would only match one entry, but there is no guarantee for that. To find
everyone with the name "leif", you'd instead do

    (cn=*leif*)

A more complicated search involves logic operators. To find all mail
groups owned by "leif" (or actually his DN), you could do

    (&(objectclass=mailGroup)(owner=uid=leif,ou=people,o=netscape))

The I<owner> attribute is what's called a DN attribute, so to match on it
we have to specify the entire DN in the filter above. We could of course
also do a sub string "wild card" match, but it's less efficient, and
requires indexes to perform reasonably well.

Ok, now we are prepared to actually do a real search on the LDAP server:

    $base = "o=netscape.com";
    $conn = Mozilla::LDAP::Conn->new("ldap", "389", "", ""); die "No LDAP
    connection" unless $conn;

    $entry = $conn->search($base, "subtree", "(uid=leif)");
    if (! $entry)
      { # handle this event, no entries found, dude!
      }
    else
      {
        while ($entry)
          {
            $entry->printLDIF();
            $entry = $conn->nextEntry();
          }
      }

This is in fact a poor mans implementation of the I<ldapsearch> command
line utility. The B<search> method returns an Mozilla::LDAP::Entry
object (or derived subclass),
which holds the first entry from the search, if any. To get the second and
subsequent entries you call the B<entry> method, until there are no more
entries. The B<printLDIF> method is a convenient function, requesting the
entry to print itself on STDOUT, in LDIF format.

The arguments to the B<search> methods are the I<LDAP Base-DN>, the
I<scope> of the search ("base", "one" or "sub"), and the actual LDAP
I<filter>. The entry return contains the DN, and all attribute values. To
access a specific attribute value, you just have to use the hash array:

    $cn = $entry->{cn}[0];

Since many LDAP attributes can have more than one value, value of the hash
array is another array (or actually a pointer to an array). In many cases
you can just assume the value is in the first slot (indexed by [0]), but
for some attributes you have to support multiple values. To find out how
many values a specific attribute has, you'd call the B<size> method:

    $numVals = $entry->size("objectclass");

One caveat: Many LDAP attributes are case insensitive, but the methods in
the Mozilla::LDAP::Entry package are not aware of this. Hence, if you
compare values with case sensitivity, you can experience weird
behavior. If you know an attribute is CIS (Case Insensitive), make sure
you do case insensitive string comparisons.

Unfortunately some methods in this package can't do this, and by default
will do case sensitive comparisons. We are working on this, and in a
future release some of the methods will handle this more gracefully. As an
extension (for LDAP v3.0) we could also use schema discovery for handling
this even better.

There is an alternative search method, to use LDAP URLs instead of a
filter string. This can be used to easily parse and process URLs, which is
a compact way of storing a "link" to some specific LDAP information. To
process such a search, you use the B<searchURL> method:

    $entry->searchURL("ldap:///o=netscape.com??sub?(uid=leif)");

As it turns out, the B<search> method also supports LDAP URL searches. If
the search filter looks like a proper URL, we will actually do an URL
search instead. This is for backward compatibility, and for ease of use.

To achieve better performance and use less memory, you can limit your
search to only retrieve certain attributes. With the LDAP URLs you specify
this as an optional parameter, and with the B<search> method you add two
more options, like

    $entry = $conn->search($base, "sub", $filter, 0, ("mail", "cn"));

The last argument specifies an array of attributes to retrieve, the fewer
the attributes, the faster the search will be. The second to last argument
is a boolean value indicating if we should retrieve only the attribute
names (and no values). In most cases you want this to be FALSE, to
retrieve both the attribute names, and all their values. To do this with
the B<searchURL> method, add a second argument, which should be 0 or 1.

=head1 PERFORMING ASYNCHRONOUS SEARCHES

Conn also supports an async_search method that takes the same arguments
as the search method but returns an instance of SearchIter instead
of Entry.  As its name implies, the SearchIter is used to iterate
through the search results.  The nextEntry method works just like
the nextEntry method of Conn.  The abandon method should be called
if search result processing is aborted before the last result is
received, to allow the client and server to release resources.
Example:

	$iter = $conn->async_search($base, $scope, $filter, ...);
    if ($rc = $iter->getResultCode()) {
	    # process error condition
	} else {
	    while (my $entry = $iter->nextEntry) {
			# process entry
            if (some abort condition) {
                $iter->abandon;
                last;
            }
        }
    }

=head1 MODIFYING AND CREATING NEW LDAP ENTRIES

Once you have an LDAP entry, either from a search, or created directly to
get a new empty object, you are ready to modify it. If you are creating a
new entry, the first thing to set it it's DN, like

    $entry = $conn->newEntry();
    $entry->setDN("uid=leif,ou=people,o=netscape.com");

alternatively you can still use the B<new> method on the Entry class, like

    $entry = Mozilla::LDAP::Entry->new();

You should not do this for an existing LDAP entry, changing the RDN (or
DN) for such an entry must be done with B<modifyRDN>. To populate (or
modify) some other attributes, we can do

    $entry->{objectclass} = [ "top", "person", "inetOrgPerson" ];
    $entry->{cn} = [ "Leif Hedstrom" ];
    $entry->{mail} = [ "leif@netscape.com" ];

Once you are done modifying your LDAP entry, call the B<update> method
from the Mozilla::LDAP::Conn object instance:

    $conn->update($entry);

Or, if you are creating an entirely new LDAP entry, you must call the
B<add> method:

    $conn->add($entry);

If all comes to worse, and you have to remove an entry again from the LDAP
server, just call the B<delete> method, like

    $conn->delete($entry->getDN());

You can't use native Perl functions like push() and splice() on attribute
values, since they won't update the ::Entry instance state properly.
Instead use one of the methods provided by the Mozilla::LDAP::Entry
object class, for instance

    $entry->addValue("cn", "The Swede");
    $entry->removeValue("mailAlternateAddress", "leif@mcom.com");
    $entry->remove("seeAlso");

These methods return a TRUE or FALSE value, depending on the outcome
of the operation. If there was no value to remove, or a value already
exists, we return FALSE, otherwise TRUE. To check if an attribute has a
certain value, use the B<hasValue> method, like

    if ($entry->hasValue("mail", "leif@netscape.com")) {
        # Do something
    }

There is a similar method, B<matchValue>, which takes a regular
expression to match against, instead of the entire string. For more
information this and other methods in the Entry class, see below.
    
=head1 OBJECT CLASS METHODS

We have already described the fundamentals of this class earlier. This is
a summary of all available methods which you can use. Be careful not to
use any undocumented features or heaviour, since the internals in this
module is likely to change.

=head2 Searching and updating entries

=over 13

=item B<add>

Add a new entry to the LDAP server. Make sure you use the B<new> method
for the Mozilla::LDAP::Entry object, to create a proper entry.

=item B<browse>

Searches for an LDAP entry, but sets some default values to begin with,
such as scope=BASE, filter=(objectclass=*) and so on.  Much like B<search>
except for these defaults.  Requires a DN value
as an argument. An optional second argument is an array of which
attributes to return from the entry.  Note that this does not support the
"attributesOnly" flag.

    $secondEntry = $conn->browse($entry->getDN());

=item B<close>

Close the LDAP connection, and clean up the object. If you don't
call this directly, the destructor for the object instance will do the job
for you.

=item B<compare>

Compares an attribute and value to a given DN without first doing a
search.  Requires three arguments: a DN, the attribute name, and the value
of the attribute. Returns TRUE if the attribute/value compared ok.

    print "not" unless $conn->compare($entry->getDN(), "cn", "Big Swede");
    print "ok";

=item B<delete>

This will delete the current entry, or possibly an entry as specified with
the optional argument. You can use this function to delete any entry you
like, by passing it an explicit DN. If you don't pass it this argument,
B<delete> defaults to delete the current entry, from the last call to
B<search> or B<entry>. I'd recommend doing a delete with the explicit DN,
like

    $conn->delete($entry->getDN());

=item B<modifyRDN>

This will rename the specified LDAP entry, by modifying it's RDN. For
example, assuming you have a DN of

    uid=leif, ou=people, dc=netscape, dc=com

and you wish to rename to

    uid=fiel, ou=people, dc=netscape, dc=com

you'd do something like

    $rdn = "uid=fiel";
    $conn->modifyRDN($rdn, $entry->getDN());

Note that this can only be done on the RDN, you could not change say
C<ou=people> to be C<ou=hackers> in the example above. To do that, you have
to add a new entry (a copy of the old one), and then remove the old
entry.

The last argument is a boolean (0 or 1), which indicates if the old RDN
value should be removed from the entry. The default is TRUE ("1").

=item B<new>

This creates and initialized a new LDAP connection and object. The
required arguments are host name, port number, bind DN and the bind
password. An optional argument is a certificate (public key), which causes
the LDAP connection to be established over an SSL channel. Currently we do
not support Client Authentication, so you still have to use the simple
authentication method (i.e. with a password).

A typical usage could be something like

    %ld = Mozilla::LDAP::Utils::ldapArgs();
    $conn = Mozilla::LDAP::Conn->new(\%ld);

Also, remember that if you use SSL, the port is (usually) 636.

=item B<newEntry>

This will create an empty Mozilla::LDAP::Entry object, which is properly
tied into the appropriate objectclass. Use this method instead of manually
creating new Entry objects, or at least make sure that you use the "tie"
function when creating the entry. This function takes no arguments, and
returns a pointer to an ::Entry object. For instance

    $entry = $conn->newEntry();

or

    $entry = Mozilla::LDAP::Conn->newEntry();

=item B<nextEntry>

This method will return the next entry from the search result, and can
therefore only be called after a succesful search has been initiated. If
there are no more entries to retrieve, it returns nothing (empty string).

=item B<search>

The B<search> method is the main entry point into this module. It requires
at least three arguments: The Base DN, the scope, and the search
strings. Two more optional arguments can be given, the first specifies if
only attribute names should be returned (TRUE or FALSE). The second
argument is a list (array) of attributes to return.

The last option is very important for performance. If you are only
interested in say the "mail" and "mailHost" attributes, specifying this in
the search will signficantly reduce the search time. An example of an
efficient search is

    @attr = ("cn", "uid", "mail");
    $filter = "(uid=*)";
    $entry = $conn->search($base, $scope, $filter, 0, @attr);
    while ($entry) {
        # do something
        $entry = $conn->nextEntry();
    }

=item B<searchURL>

This is almost identical to B<search>, except this function takes only two
arguments, an LDAP URL and an optional flag to specify if we only want the
attribute names to be returned (and no values). This function isn't very
useful, since the B<search> method will actually honor properly formed
LDAP URL's, and use it if appropriate.

=item B<simpleAuth>

This method will rebind the LDAP connection using new credentials (i.e. a
new user-DN and password). To rebind "anonymously", just don't pass a DN
and password, and it will default to binding as the unprivleged user. For
example:

    $user = "leif";
    $password = "secret";
    $conn = Mozilla::LDAP::Conn->new($host, $port);	# Anonymous bind
    die "Could't connect to LDAP server $host" unless $conn;

    $entry = $conn->search($base, $scope, "(uid=$user)", 0, (uid));
    exit (-1) unless $entry;

    $ret = $conn->simpleAuth($entry->getDN(), $password);
    exit (-1) unless $ret;

    $ret = $conn->simpleAuth();		# Bind as anon again.

=item B<update>

After modifying an Ldap::Entry entry (see below), use the B<update>
method to commit changes to the LDAP server. Only attributes that has been
changed will be updated, assuming you have used the appropriate methods in
the Entry object. For instance, do not use B<push> or B<splice> to
modify an entry, the B<update> will not recognize such changes.

To change the CN value for an entry, you could do

    $entry->{cn} = ["Leif Hedstrom"];
    $conn->update($entry);

=back

=head2 Other methods

=over 13

=item B<getErrorCode>

Return the error code (numeric) from the last LDAP API function
call. Remember that this can only be called I<after> the successful
creation of a new :Conn object instance. A typical usage could be

    if (! $opt_n) {
        $conn->modifyRDN($rdn, $entry->getDN());
        $conn->printError() if $conn->getErrorCode();
    }

Which will report any error message as generated by the call to
B<modifyRDN>. Some LDAP functions return extra error information, which
can be retrieved like:

   $err = getErrorCode(\$matched, \$string);


$matched will then contain the portion of the matched DN (if applicable to
the error code), and $string will contain any additional error string
returned by the LDAP server.

=item B<getErrorString>

Very much like B<getErrorCode>, but return a string with a human readable
error message. This can then be used to print a good error message on the
console.

=item B<getLD>

Return the (internal) LDAP* connection handle, which you can use
(carefully) to call the native LDAP API functions. You shouldn't have to
use this in most cases, unless of course our OO layer is seriously flawed.

=item B<getRes>

Just like B<getLD>, except it returns the internal LDAP return message
structure. Again, use this very carefully, and be aware that this might
break in future releases of PerLDAP. These two methods can be used to call
some useful API functions, like 

    $cld = $conn->getLD();
    $res = $conn->getRes();
    $count = Mozilla::LDAP::API::ldap_count_entries($cld, $res);

=item B<isURL>

Returns TRUE or FALSE if the given argument is a properly formed URL.

=item B<printError>

Print the last error message on standard output.

=item B<setRebindProc>

Tell the LDAP SDK to call the provided Perl function when it has to follow
referrals. The Perl function should return an array of three elements, the
new Bind DN, password and authentication method. A typical usage is

    sub rebindProc {
        return ("uid=ldapadmin", "secret", LDAP_AUTH_SIMPLE);
    }

    $ld->setRebindProc(\&rebindProc);

=item B<setDefaultRebindProc>

This is very much like the previous function, except instead of specifying
the function to use, you give it the DN, password and Auth method. Then
we'll use a default rebind procedure (internal in C) to handle the rebind
credentials. This was a solution for the Windows/NT problem/bugs we have
with rebind procedures written in Perl.

=item B<setVersion>

Change the LDAP protocol version on the already initialized connection.
The default is LDAP v3 (new for PerLDAP v1.5!), but you can downgrade
the connection to LDAP v2 if necessary using this function. Example:

    $conn->setVersion(2);
   

=item B<getVersion>

Return the protocol version currently in used by the connection.

=item B<setSizelimit>

Set the sizelimit on a connection, to limit the maximum number of
entries that we want to retrieve. For example:

   $conn->setSizelimit(10);

=item B<getSizelimit>

Get the current sizelimit on a connection (if any).

=item B<setOption>

Set an (integer) LDAP option.

=item B<getOption>

Get an (integer) LDAP option.

=item B<installNSPR>

Install NSPR I/O, threading, and DNS functions so they will be used by
'ld'.

Pass a non-zero value for the 'shared' parameter if you plan to use
this LDAP * handle from more than one thread. This is highly unlikely
since PerLDAP is asynchronous.

=item B<setNSPRTimeout>

Set the TCP timeout value, in millisecond, for the NSPR enabled connection.
It's an error to call this before calling installNSPR(), unless you
created the new connection object with the B<nspr> option.

This method can also be invoked as a class method, and it will then apply
to all new connections created. Like

    Mozilla::LDAP::Conn->installNSPR(1);
    Mozilla::LDAP::Conn->setNSPRTimeout(1000);

=back

=head1 EXAMPLES

There are plenty of examples to look at, in the examples directory. We are
adding more examples every day (almost).

=head1 INSTALLATION

Installing this package is part of the Makefile supplied in the
package. See the installation procedures which are part of this package.

=head1 AVAILABILITY

This package can be retrieved from a number of places, including:

    http://www.mozilla.org/directory/
    Your local CPAN server

=head1 CREDITS

Most of this code was developed by Leif Hedstrom, Netscape Communications
Corporation. 

=head1 BUGS

None. :)

=head1 SEE ALSO

L<Mozilla::LDAP::Entry>, L<LDAP::Mozilla:Utils> L<LDAP::Mozilla:API> and
of course L<Perl>.

=cut
