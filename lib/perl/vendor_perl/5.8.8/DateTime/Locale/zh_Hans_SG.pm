###########################################################################
#
# This file is auto-generated by the Perl DateTime Suite time locale
# generator (0.04).  This code generator comes with the
# DateTime::Locale distribution in the tools/ directory, and is called
# generate_from_cldr.
#
# This file as generated from the CLDR XML locale data.  See the
# LICENSE.cldr file included in this distribution for license details.
#
# This file was generated from the source file zh_Hans_SG.xml.
# The source file version number was 1.46, generated on
# 2007/07/19 22:31:40.
#
# Do not edit this file directly.
#
###########################################################################

package DateTime::Locale::zh_Hans_SG;

use strict;

BEGIN
{
    if ( $] >= 5.006 )
    {
        require utf8; utf8->import;
    }
}

use DateTime::Locale::zh;

@DateTime::Locale::zh_Hans_SG::ISA = qw(DateTime::Locale::zh);

my $date_parts_order = "dmy";


sub full_date_format               { "\%d\ \%B\ \%\{ce_year\}" }
sub long_date_format               { "\%d\ \%b\ \%\{ce_year\}" }
sub medium_date_format             { "\%d\-\%b\-\%y" }
sub short_date_format              { "\%d\/\%m\/\%y" }
sub full_time_format               { "\%p\ \%l\:\%M\:\%S" }
sub long_time_format               { "\%p\ \%l\:\%M\:\%S\ \%\{time_zone_long_name\}" }
sub medium_time_format             { "\%p\ \%l\:\%M" }
sub short_time_format              { "\%p\ \%l\:\%M" }
sub date_parts_order               { $date_parts_order }



1;

