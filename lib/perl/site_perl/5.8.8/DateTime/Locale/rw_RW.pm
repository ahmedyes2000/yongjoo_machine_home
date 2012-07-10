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
# This file was generated from the source file rw_RW.xml
# The source file version number was 1.15, generated on
# 2009/05/05 23:06:39.
#
# Do not edit this file directly.
#
###########################################################################

package DateTime::Locale::rw_RW;

use strict;
use warnings;
use utf8;

use base 'DateTime::Locale::rw';

sub cldr_version { return "1\.7\.1" }

{
    my $first_day_of_week = "1";
    sub first_day_of_week { return $first_day_of_week }
}

1;

__END__


=pod

=encoding utf8

=head1 NAME

DateTime::Locale::rw_RW

=head1 SYNOPSIS

  use DateTime;

  my $dt = DateTime->now( locale => 'rw_RW' );
  print $dt->month_name();

=head1 DESCRIPTION

This is the DateTime locale package for Kinyarwanda Rwanda.

=head1 DATA

This locale inherits from the L<DateTime::Locale::rw> locale.

It contains the following data.

=head2 Days

=head3 Wide (format)

  Kuwa mbere
  Kuwa kabiri
  Kuwa gatatu
  Kuwa kane
  Kuwa gatanu
  Kuwa gatandatu
  Ku cyumweru

=head3 Abbreviated (format)

  mbe.
  kab.
  gtu.
  kan.
  gnu.
  gnd.
  cyu.

=head3 Narrow (format)

  2
  3
  4
  5
  6
  7
  1

=head3 Wide (stand-alone)

  Kuwa mbere
  Kuwa kabiri
  Kuwa gatatu
  Kuwa kane
  Kuwa gatanu
  Kuwa gatandatu
  Ku cyumweru

=head3 Abbreviated (stand-alone)

  mbe.
  kab.
  gtu.
  kan.
  gnu.
  gnd.
  cyu.

=head3 Narrow (stand-alone)

  2
  3
  4
  5
  6
  7
  1

=head2 Months

=head3 Wide (format)

  Mutarama
  Gashyantare
  Werurwe
  Mata
  Gicuransi
  Kamena
  Nyakanga
  Kanama
  Nzeli
  Ukwakira
  Ugushyingo
  Ukuboza

=head3 Abbreviated (format)

  mut.
  gas.
  wer.
  mat.
  gic.
  kam.
  nya.
  kan.
  nze.
  ukw.
  ugu.
  uku.

=head3 Narrow (format)

  1
  2
  3
  4
  5
  6
  7
  8
  9
  10
  11
  12

=head3 Wide (stand-alone)

  Mutarama
  Gashyantare
  Werurwe
  Mata
  Gicuransi
  Kamena
  Nyakanga
  Kanama
  Nzeli
  Ukwakira
  Ugushyingo
  Ukuboza

=head3 Abbreviated (stand-alone)

  mut.
  gas.
  wer.
  mat.
  gic.
  kam.
  nya.
  kan.
  nze.
  ukw.
  ugu.
  uku.

=head3 Narrow (stand-alone)

  1
  2
  3
  4
  5
  6
  7
  8
  9
  10
  11
  12

=head2 Quarters

=head3 Wide (format)

  igihembwe cya mbere
  igihembwe cya kabiri
  igihembwe cya gatatu
  igihembwe cya kane

=head3 Abbreviated (format)

  I1
  I2
  I3
  I4

=head3 Narrow (format)

  1
  2
  3
  4

=head3 Wide (stand-alone)

  igihembwe cya mbere
  igihembwe cya kabiri
  igihembwe cya gatatu
  igihembwe cya kane

=head3 Abbreviated (stand-alone)

  I1
  I2
  I3
  I4

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

  BCE
  CE

=head3 Narrow

  BCE
  CE

=head2 Date Formats

=head3 Full

   2008-02-05T18:30:30 = Kuwa kabiri, 2008 Gashyantare 05
   1995-12-22T09:05:02 = Kuwa gatanu, 1995 Ukuboza 22
  -0010-09-15T04:44:23 = Kuwa gatandatu, -10 Nzeli 15

=head3 Long

   2008-02-05T18:30:30 = 2008 Gashyantare 5
   1995-12-22T09:05:02 = 1995 Ukuboza 22
  -0010-09-15T04:44:23 = -10 Nzeli 15

=head3 Medium

   2008-02-05T18:30:30 = 2008 gas. 5
   1995-12-22T09:05:02 = 1995 uku. 22
  -0010-09-15T04:44:23 = -10 nze. 15

=head3 Short

   2008-02-05T18:30:30 = 08/02/05
   1995-12-22T09:05:02 = 95/12/22
  -0010-09-15T04:44:23 = 10/09/15

=head3 Default

   2008-02-05T18:30:30 = 2008 gas. 5
   1995-12-22T09:05:02 = 1995 uku. 22
  -0010-09-15T04:44:23 = -10 nze. 15

=head2 Time Formats

=head3 Full

   2008-02-05T18:30:30 = 18:30:30 UTC
   1995-12-22T09:05:02 = 09:05:02 UTC
  -0010-09-15T04:44:23 = 04:44:23 UTC

=head3 Long

   2008-02-05T18:30:30 = 18:30:30 UTC
   1995-12-22T09:05:02 = 09:05:02 UTC
  -0010-09-15T04:44:23 = 04:44:23 UTC

=head3 Medium

   2008-02-05T18:30:30 = 18:30:30
   1995-12-22T09:05:02 = 09:05:02
  -0010-09-15T04:44:23 = 04:44:23

=head3 Short

   2008-02-05T18:30:30 = 18:30
   1995-12-22T09:05:02 = 09:05
  -0010-09-15T04:44:23 = 04:44

=head3 Default

   2008-02-05T18:30:30 = 18:30:30
   1995-12-22T09:05:02 = 09:05:02
  -0010-09-15T04:44:23 = 04:44:23

=head2 Datetime Formats

=head3 Full

   2008-02-05T18:30:30 = Kuwa kabiri, 2008 Gashyantare 05 18:30:30 UTC
   1995-12-22T09:05:02 = Kuwa gatanu, 1995 Ukuboza 22 09:05:02 UTC
  -0010-09-15T04:44:23 = Kuwa gatandatu, -10 Nzeli 15 04:44:23 UTC

=head3 Long

   2008-02-05T18:30:30 = 2008 Gashyantare 5 18:30:30 UTC
   1995-12-22T09:05:02 = 1995 Ukuboza 22 09:05:02 UTC
  -0010-09-15T04:44:23 = -10 Nzeli 15 04:44:23 UTC

=head3 Medium

   2008-02-05T18:30:30 = 2008 gas. 5 18:30:30
   1995-12-22T09:05:02 = 1995 uku. 22 09:05:02
  -0010-09-15T04:44:23 = -10 nze. 15 04:44:23

=head3 Short

   2008-02-05T18:30:30 = 08/02/05 18:30
   1995-12-22T09:05:02 = 95/12/22 09:05
  -0010-09-15T04:44:23 = 10/09/15 04:44

=head3 Default

   2008-02-05T18:30:30 = 2008 gas. 5 18:30:30
   1995-12-22T09:05:02 = 1995 uku. 22 09:05:02
  -0010-09-15T04:44:23 = -10 nze. 15 04:44:23

=head2 Available Formats

=head3 EEEd (d EEE)

   2008-02-05T18:30:30 = 5 kab.
   1995-12-22T09:05:02 = 22 gnu.
  -0010-09-15T04:44:23 = 15 gnd.

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

   2008-02-05T18:30:30 = kab., 2-5
   1995-12-22T09:05:02 = gnu., 12-22
  -0010-09-15T04:44:23 = gnd., 9-15

=head3 MMM (LLL)

   2008-02-05T18:30:30 = gas.
   1995-12-22T09:05:02 = uku.
  -0010-09-15T04:44:23 = nze.

=head3 MMMEd (E MMM d)

   2008-02-05T18:30:30 = kab. gas. 5
   1995-12-22T09:05:02 = gnu. uku. 22
  -0010-09-15T04:44:23 = gnd. nze. 15

=head3 MMMMEd (E MMMM d)

   2008-02-05T18:30:30 = kab. Gashyantare 5
   1995-12-22T09:05:02 = gnu. Ukuboza 22
  -0010-09-15T04:44:23 = gnd. Nzeli 15

=head3 MMMMd (MMMM d)

   2008-02-05T18:30:30 = Gashyantare 5
   1995-12-22T09:05:02 = Ukuboza 22
  -0010-09-15T04:44:23 = Nzeli 15

=head3 MMMd (MMM d)

   2008-02-05T18:30:30 = gas. 5
   1995-12-22T09:05:02 = uku. 22
  -0010-09-15T04:44:23 = nze. 15

=head3 Md (M-d)

   2008-02-05T18:30:30 = 2-5
   1995-12-22T09:05:02 = 12-22
  -0010-09-15T04:44:23 = 9-15

=head3 d (d)

   2008-02-05T18:30:30 = 5
   1995-12-22T09:05:02 = 22
  -0010-09-15T04:44:23 = 15

=head3 hm (h:mm a)

   2008-02-05T18:30:30 = 6:30 PM
   1995-12-22T09:05:02 = 9:05 AM
  -0010-09-15T04:44:23 = 4:44 AM

=head3 hms (h:mm:ss a)

   2008-02-05T18:30:30 = 6:30:30 PM
   1995-12-22T09:05:02 = 9:05:02 AM
  -0010-09-15T04:44:23 = 4:44:23 AM

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

   2008-02-05T18:30:30 = kab., 2008-2-5
   1995-12-22T09:05:02 = gnu., 1995-12-22
  -0010-09-15T04:44:23 = gnd., -10-9-15

=head3 yMMM (y MMM)

   2008-02-05T18:30:30 = 2008 gas.
   1995-12-22T09:05:02 = 1995 uku.
  -0010-09-15T04:44:23 = -10 nze.

=head3 yMMMEd (EEE, y MMM d)

   2008-02-05T18:30:30 = kab., 2008 gas. 5
   1995-12-22T09:05:02 = gnu., 1995 uku. 22
  -0010-09-15T04:44:23 = gnd., -10 nze. 15

=head3 yMMMM (y MMMM)

   2008-02-05T18:30:30 = 2008 Gashyantare
   1995-12-22T09:05:02 = 1995 Ukuboza
  -0010-09-15T04:44:23 = -10 Nzeli

=head3 yQ (y Q)

   2008-02-05T18:30:30 = 2008 1
   1995-12-22T09:05:02 = 1995 4
  -0010-09-15T04:44:23 = -10 3

=head3 yQQQ (y QQQ)

   2008-02-05T18:30:30 = 2008 I1
   1995-12-22T09:05:02 = 1995 I4
  -0010-09-15T04:44:23 = -10 I3

=head3 yyQ (Q yy)

   2008-02-05T18:30:30 = 1 08
   1995-12-22T09:05:02 = 4 95
  -0010-09-15T04:44:23 = 3 10

=head2 Miscellaneous

=head3 Prefers 24 hour time?

Yes

=head3 Local first day of the week

Kuwa mbere


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
