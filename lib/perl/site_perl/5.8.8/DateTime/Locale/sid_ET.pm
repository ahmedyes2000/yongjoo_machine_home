###########################################################################
#
# This file is auto-generated by the Perl DateTime Suite locale
# generator (0.05).  This code generator comes with the
# DateTime::Locale distribution in the tools/ directory, and is called
# generate-from-cldr.
#
# This file as generated from the CLDR XML locale data.  See the
# LICENSE.cldr file included in this distribution for license details.
#
# This file was generated from the source file sid_ET.xml
# The source file version number was 1.36, generated on
# 2009/05/05 23:06:40.
#
# Do not edit this file directly.
#
###########################################################################

package DateTime::Locale::sid_ET;

use strict;
use warnings;
use utf8;

use base 'DateTime::Locale::sid';

sub cldr_version { return "1\.7\.1" }

{
    my $first_day_of_week = "6";
    sub first_day_of_week { return $first_day_of_week }
}

1;

__END__


=pod

=encoding utf8

=head1 NAME

DateTime::Locale::sid_ET

=head1 SYNOPSIS

  use DateTime;

  my $dt = DateTime->now( locale => 'sid_ET' );
  print $dt->month_name();

=head1 DESCRIPTION

This is the DateTime locale package for Sidamo Ethiopia.

=head1 DATA

This locale inherits from the L<DateTime::Locale::sid> locale.

It contains the following data.

=head2 Days

=head3 Wide (format)

  Sanyo
  Maakisanyo
  Roowe
  Hamuse
  Arbe
  Qidaame
  Sambata

=head3 Abbreviated (format)

  San
  Mak
  Row
  Ham
  Arb
  Qid
  Sam

=head3 Narrow (format)

  S
  M
  R
  H
  A
  Q
  S

=head3 Wide (stand-alone)

  Sanyo
  Maakisanyo
  Roowe
  Hamuse
  Arbe
  Qidaame
  Sambata

=head3 Abbreviated (stand-alone)

  San
  Mak
  Row
  Ham
  Arb
  Qid
  Sam

=head3 Narrow (stand-alone)

  S
  M
  R
  H
  A
  Q
  S

=head2 Months

=head3 Wide (format)

  January
  February
  March
  April
  May
  June
  July
  August
  September
  October
  November
  December

=head3 Abbreviated (format)

  Jan
  Feb
  Mar
  Apr
  May
  Jun
  Jul
  Aug
  Sep
  Oct
  Nov
  Dec

=head3 Narrow (format)

  J
  F
  M
  A
  M
  J
  J
  A
  S
  O
  N
  D

=head3 Wide (stand-alone)

  January
  February
  March
  April
  May
  June
  July
  August
  September
  October
  November
  December

=head3 Abbreviated (stand-alone)

  Jan
  Feb
  Mar
  Apr
  May
  Jun
  Jul
  Aug
  Sep
  Oct
  Nov
  Dec

=head3 Narrow (stand-alone)

  J
  F
  M
  A
  M
  J
  J
  A
  S
  O
  N
  D

=head2 Quarters

=head3 Wide (format)

  Q1
  Q2
  Q3
  Q4

=head3 Abbreviated (format)

  Q1
  Q2
  Q3
  Q4

=head3 Narrow (format)

  1
  2
  3
  4

=head3 Wide (stand-alone)

  Q1
  Q2
  Q3
  Q4

=head3 Abbreviated (stand-alone)

  Q1
  Q2
  Q3
  Q4

=head3 Narrow (stand-alone)

  1
  2
  3
  4

=head2 Eras

=head3 Wide

  BCE
  CE

=head3 Abbreviated

  YIA
  YIG

=head3 Narrow

  YIA
  YIG

=head2 Date Formats

=head3 Full

   2008-02-05T18:30:30 = Maakisanyo, February 05, 2008
   1995-12-22T09:05:02 = Arbe, December 22, 1995
  -0010-09-15T04:44:23 = Qidaame, September 15, -10

=head3 Long

   2008-02-05T18:30:30 = 05 February 2008
   1995-12-22T09:05:02 = 22 December 1995
  -0010-09-15T04:44:23 = 15 September -10

=head3 Medium

   2008-02-05T18:30:30 = 05-Feb-2008
   1995-12-22T09:05:02 = 22-Dec-1995
  -0010-09-15T04:44:23 = 15-Sep--10

=head3 Short

   2008-02-05T18:30:30 = 05/02/08
   1995-12-22T09:05:02 = 22/12/95
  -0010-09-15T04:44:23 = 15/09/10

=head3 Default

   2008-02-05T18:30:30 = 05-Feb-2008
   1995-12-22T09:05:02 = 22-Dec-1995
  -0010-09-15T04:44:23 = 15-Sep--10

=head2 Time Formats

=head3 Full

   2008-02-05T18:30:30 = 6:30:30 hawwaro UTC
   1995-12-22T09:05:02 = 9:05:02 soodo UTC
  -0010-09-15T04:44:23 = 4:44:23 soodo UTC

=head3 Long

   2008-02-05T18:30:30 = 6:30:30 hawwaro UTC
   1995-12-22T09:05:02 = 9:05:02 soodo UTC
  -0010-09-15T04:44:23 = 4:44:23 soodo UTC

=head3 Medium

   2008-02-05T18:30:30 = 6:30:30 hawwaro
   1995-12-22T09:05:02 = 9:05:02 soodo
  -0010-09-15T04:44:23 = 4:44:23 soodo

=head3 Short

   2008-02-05T18:30:30 = 6:30 hawwaro
   1995-12-22T09:05:02 = 9:05 soodo
  -0010-09-15T04:44:23 = 4:44 soodo

=head3 Default

   2008-02-05T18:30:30 = 6:30:30 hawwaro
   1995-12-22T09:05:02 = 9:05:02 soodo
  -0010-09-15T04:44:23 = 4:44:23 soodo

=head2 Datetime Formats

=head3 Full

   2008-02-05T18:30:30 = Maakisanyo, February 05, 2008 6:30:30 hawwaro UTC
   1995-12-22T09:05:02 = Arbe, December 22, 1995 9:05:02 soodo UTC
  -0010-09-15T04:44:23 = Qidaame, September 15, -10 4:44:23 soodo UTC

=head3 Long

   2008-02-05T18:30:30 = 05 February 2008 6:30:30 hawwaro UTC
   1995-12-22T09:05:02 = 22 December 1995 9:05:02 soodo UTC
  -0010-09-15T04:44:23 = 15 September -10 4:44:23 soodo UTC

=head3 Medium

   2008-02-05T18:30:30 = 05-Feb-2008 6:30:30 hawwaro
   1995-12-22T09:05:02 = 22-Dec-1995 9:05:02 soodo
  -0010-09-15T04:44:23 = 15-Sep--10 4:44:23 soodo

=head3 Short

   2008-02-05T18:30:30 = 05/02/08 6:30 hawwaro
   1995-12-22T09:05:02 = 22/12/95 9:05 soodo
  -0010-09-15T04:44:23 = 15/09/10 4:44 soodo

=head3 Default

   2008-02-05T18:30:30 = 05-Feb-2008 6:30:30 hawwaro
   1995-12-22T09:05:02 = 22-Dec-1995 9:05:02 soodo
  -0010-09-15T04:44:23 = 15-Sep--10 4:44:23 soodo

=head2 Available Formats

=head3 EEEd (d EEE)

   2008-02-05T18:30:30 = 5 Mak
   1995-12-22T09:05:02 = 22 Arb
  -0010-09-15T04:44:23 = 15 Qid

=head3 Hm (H:mm)

   2008-02-05T18:30:30 = 18:30
   1995-12-22T09:05:02 = 9:05
  -0010-09-15T04:44:23 = 4:44

=head3 Hms (H:mm:ss)

   2008-02-05T18:30:30 = 18:30:30
   1995-12-22T09:05:02 = 9:05:02
  -0010-09-15T04:44:23 = 4:44:23

=head3 M (L)

   2008-02-05T18:30:30 = 2
   1995-12-22T09:05:02 = 12
  -0010-09-15T04:44:23 = 9

=head3 MEd (E, M-d)

   2008-02-05T18:30:30 = Mak, 2-5
   1995-12-22T09:05:02 = Arb, 12-22
  -0010-09-15T04:44:23 = Qid, 9-15

=head3 MMM (LLL)

   2008-02-05T18:30:30 = Feb
   1995-12-22T09:05:02 = Dec
  -0010-09-15T04:44:23 = Sep

=head3 MMMEd (E MMM d)

   2008-02-05T18:30:30 = Mak Feb 5
   1995-12-22T09:05:02 = Arb Dec 22
  -0010-09-15T04:44:23 = Qid Sep 15

=head3 MMMMEd (E MMMM d)

   2008-02-05T18:30:30 = Mak February 5
   1995-12-22T09:05:02 = Arb December 22
  -0010-09-15T04:44:23 = Qid September 15

=head3 MMMMd (MMMM d)

   2008-02-05T18:30:30 = February 5
   1995-12-22T09:05:02 = December 22
  -0010-09-15T04:44:23 = September 15

=head3 MMMMdd (dd MMMM)

   2008-02-05T18:30:30 = 05 February
   1995-12-22T09:05:02 = 22 December
  -0010-09-15T04:44:23 = 15 September

=head3 MMMd (MMM d)

   2008-02-05T18:30:30 = Feb 5
   1995-12-22T09:05:02 = Dec 22
  -0010-09-15T04:44:23 = Sep 15

=head3 MMdd (dd/MM)

   2008-02-05T18:30:30 = 05/02
   1995-12-22T09:05:02 = 22/12
  -0010-09-15T04:44:23 = 15/09

=head3 Md (M-d)

   2008-02-05T18:30:30 = 2-5
   1995-12-22T09:05:02 = 12-22
  -0010-09-15T04:44:23 = 9-15

=head3 d (d)

   2008-02-05T18:30:30 = 5
   1995-12-22T09:05:02 = 22
  -0010-09-15T04:44:23 = 15

=head3 hm (h:mm a)

   2008-02-05T18:30:30 = 6:30 hawwaro
   1995-12-22T09:05:02 = 9:05 soodo
  -0010-09-15T04:44:23 = 4:44 soodo

=head3 hms (h:mm:ss a)

   2008-02-05T18:30:30 = 6:30:30 hawwaro
   1995-12-22T09:05:02 = 9:05:02 soodo
  -0010-09-15T04:44:23 = 4:44:23 soodo

=head3 ms (mm:ss)

   2008-02-05T18:30:30 = 30:30
   1995-12-22T09:05:02 = 05:02
  -0010-09-15T04:44:23 = 44:23

=head3 y (y)

   2008-02-05T18:30:30 = 2008
   1995-12-22T09:05:02 = 1995
  -0010-09-15T04:44:23 = -10

=head3 yM (y-M)

   2008-02-05T18:30:30 = 2008-2
   1995-12-22T09:05:02 = 1995-12
  -0010-09-15T04:44:23 = -10-9

=head3 yMEd (EEE, y-M-d)

   2008-02-05T18:30:30 = Mak, 2008-2-5
   1995-12-22T09:05:02 = Arb, 1995-12-22
  -0010-09-15T04:44:23 = Qid, -10-9-15

=head3 yMMM (y MMM)

   2008-02-05T18:30:30 = 2008 Feb
   1995-12-22T09:05:02 = 1995 Dec
  -0010-09-15T04:44:23 = -10 Sep

=head3 yMMMEd (EEE, y MMM d)

   2008-02-05T18:30:30 = Mak, 2008 Feb 5
   1995-12-22T09:05:02 = Arb, 1995 Dec 22
  -0010-09-15T04:44:23 = Qid, -10 Sep 15

=head3 yMMMM (y MMMM)

   2008-02-05T18:30:30 = 2008 February
   1995-12-22T09:05:02 = 1995 December
  -0010-09-15T04:44:23 = -10 September

=head3 yQ (y Q)

   2008-02-05T18:30:30 = 2008 1
   1995-12-22T09:05:02 = 1995 4
  -0010-09-15T04:44:23 = -10 3

=head3 yQQQ (y QQQ)

   2008-02-05T18:30:30 = 2008 Q1
   1995-12-22T09:05:02 = 1995 Q4
  -0010-09-15T04:44:23 = -10 Q3

=head3 yyMM (MM/yy)

   2008-02-05T18:30:30 = 02/08
   1995-12-22T09:05:02 = 12/95
  -0010-09-15T04:44:23 = 09/10

=head3 yyQ (Q yy)

   2008-02-05T18:30:30 = 1 08
   1995-12-22T09:05:02 = 4 95
  -0010-09-15T04:44:23 = 3 10

=head3 yyyyMMMM (MMMM y)

   2008-02-05T18:30:30 = February 2008
   1995-12-22T09:05:02 = December 1995
  -0010-09-15T04:44:23 = September -10

=head2 Miscellaneous

=head3 Prefers 24 hour time?

No

=head3 Local first day of the week

Qidaame


=head1 SUPPORT

See L<DateTime::Locale>.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT

Copyright (c) 2008 David Rolsky. All rights reserved. This program is
free software; you can redistribute it and/or modify it under the same
terms as Perl itself.

This module was generated from data provided by the CLDR project, see
the LICENSE.cldr in this distribution for details on the CLDR data's
license.

=cut
