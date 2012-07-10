
#
# GENERATED WITH PDL::PP! Don't modify!
#
package PDL::Graphics::PLplot;

@EXPORT_OK  = qw( PL_PARSE_PARTIAL PL_PARSE_FULL PL_PARSE_QUIET PL_PARSE_NODELETE PL_PARSE_SHOWALL PL_PARSE_OVERRIDE PL_PARSE_NOPROGRAM PL_PARSE_NODASH PL_PARSE_SKIP DRAW_LINEX DRAW_LINEY DRAW_LINEXY MAG_COLOR BASE_CONT TOP_CONT SURF_CONT DRAW_SIDES FACETED MESH PLK_BackSpace PLK_Tab PLK_Linefeed PLK_Return PLK_Escape PLK_Delete PLK_Clear PLK_Pause PLK_Scroll_Lock PLK_Home PLK_Left PLK_Up PLK_Right PLK_Down PLK_Prior PLK_Next PLK_End PLK_Begin PLK_Select PLK_Print PLK_Execute PLK_Insert PLK_Undo PLK_Redo PLK_Menu PLK_Find PLK_Cancel PLK_Help PLK_Break PLK_Mode_switch PLK_script_switch PLK_Num_Lock PLK_KP_Space PLK_KP_Tab PLK_KP_Enter PLK_KP_F1 PLK_KP_F2 PLK_KP_F3 PLK_KP_F4 PLK_KP_Equal PLK_KP_Multiply PLK_KP_Add PLK_KP_Separator PLK_KP_Subtract PLK_KP_Decimal PLK_KP_Divide PLK_KP_0 PLK_KP_1 PLK_KP_2 PLK_KP_3 PLK_KP_4 PLK_KP_5 PLK_KP_6 PLK_KP_7 PLK_KP_8 PLK_KP_9 PLK_F1 PLK_F2 PLK_F3 PLK_F4 PLK_F5 PLK_F6 PLK_F7 PLK_F8 PLK_F9 PLK_F10 PLK_F11 PLK_L1 PLK_F12 PLK_L2 PLK_F13 PLK_L3 PLK_F14 PLK_L4 PLK_F15 PLK_L5 PLK_F16 PLK_L6 PLK_F17 PLK_L7 PLK_F18 PLK_L8 PLK_F19 PLK_L9 PLK_F20 PLK_L10 PLK_F21 PLK_R1 PLK_F22 PLK_R2 PLK_F23 PLK_R3 PLK_F24 PLK_R4 PLK_F25 PLK_R5 PLK_F26 PLK_R6 PLK_F27 PLK_R7 PLK_F28 PLK_R8 PLK_F29 PLK_R9 PLK_F30 PLK_R10 PLK_F31 PLK_R11 PLK_F32 PLK_R12 PLK_R13 PLK_F33 PLK_F34 PLK_R14 PLK_F35 PLK_R15 PLK_Shift_L PLK_Shift_R PLK_Control_L PLK_Control_R PLK_Caps_Lock PLK_Shift_Lock PLK_Meta_L PLK_Meta_R PLK_Alt_L PLK_Alt_R PLK_Super_L PLK_Super_R PLK_Hyper_L PLK_Hyper_R GRID_CSA GRID_DTLI GRID_NNI GRID_NNIDW GRID_NNLI GRID_NNAIDW PDL::PP pladv PDL::PP plarrows PDL::PP plaxes PDL::PP plbin  plbop PDL::PP plbox PDL::PP plbox3  plclear PDL::PP plcol0 PDL::PP plcol1 PDL::PP plcpstrm PDL::PP pldid2pc PDL::PP pldip2dc  plend  plend1 PDL::PP plenv PDL::PP plenv0  pleop PDL::PP plerrx PDL::PP plerry  plfamadv PDL::PP plfill3  plflush PDL::PP plfont PDL::PP plfontld PDL::PP plgchr PDL::PP plgcol0 PDL::PP plgcolbg PDL::PP plgcompression PDL::PP plgdidev PDL::PP plgdiori PDL::PP plgdiplt PDL::PP plgfam  plgfnam PDL::PP plglevel PDL::PP plgpage  plgra PDL::PP plgspa PDL::PP plgxax PDL::PP plgyax PDL::PP plgzax PDL::PP plhls  plinit PDL::PP pljoin  pllab PDL::PP pllightsource PDL::PP pllsty PDL::PP plmtex PDL::PP plpat PDL::PP plprec PDL::PP plpsty PDL::PP plptex  plreplot PDL::PP plrgb PDL::PP plrgb1 PDL::PP plschr PDL::PP plscmap0n PDL::PP plscmap1n PDL::PP plscmap0 PDL::PP plscmap1 PDL::PP plscol0 PDL::PP plscolbg PDL::PP plscolor PDL::PP plscompression  plsdev PDL::PP plsdidev PDL::PP plsdimap PDL::PP plsdiori PDL::PP plsdiplt PDL::PP plsdiplz PDL::PP pl_setcontlabelparam PDL::PP pl_setcontlabelformat PDL::PP plsfam  plsfnam PDL::PP plsmaj PDL::PP plsmin PDL::PP plsori PDL::PP plspage PDL::PP plspause PDL::PP plsstrm PDL::PP plssub PDL::PP plssym PDL::PP plstar PDL::PP plstart PDL::PP plstripa PDL::PP plstripd PDL::PP plsvpa PDL::PP plsxax PDL::PP plsxwin PDL::PP plsyax PDL::PP plszax  pltext PDL::PP plvasp PDL::PP plvpas PDL::PP plvpor  plvsta PDL::PP plw3d PDL::PP plwid PDL::PP plwind  plsetopt PDL::PP plP_gpixmm PDL::PP plline PDL::PP plcolorpoints PDL::PP plsmem PDL::PP plfbox PDL::PP plParseOpts PDL::PP plpoin PDL::PP plpoin3 PDL::PP plline3 PDL::PP plpoly3 PDL::PP plhist PDL::PP plfill PDL::PP plsym PDL::PP plsurf3d PDL::PP plstyl pltr0 pltr1 pltr2 PDL::PP plAllocGrid plFreeGrid PDL::PP plAlloc2dGrid plFree2dGrid PDL::PP init_pltr PDL::PP plmap PDL::PP plmeridians PDL::PP plshades PDL::PP plcont PDL::PP plmesh PDL::PP plmeshc PDL::PP plot3d PDL::PP plot3dc PDL::PP plscmap1l PDL::PP plshade1 PDL::PP plimage plxormod plGetCursor plgstrm plgdev plmkstrm plgver PDL::PP plstripc PDL::PP plgriddata PDL::PP plvect PDL::PP plsvect );
%EXPORT_TAGS = (Func=>[@EXPORT_OK]);

use PDL::Core;
use PDL::Exporter;
use DynaLoader;



   
   @ISA    = ( 'PDL::Exporter','DynaLoader' );
   push @PDL::Core::PP, __PACKAGE__;
   bootstrap PDL::Graphics::PLplot ;




=head1 NAME

PDL::Graphics::PLplot - Object-oriented interface from perl/PDL to the PLPLOT plotting library

=head1 SYNOPSIS

  use PDL;
  use PDL::Graphics::PLplot;

  my $pl = PDL::Graphics::PLplot->new (DEV => "png", FILE => "test.png");
  my $x  = sequence(10);
  my $y  = $x**2;
  $pl->xyplot($x, $y);
  $pl->close;

For more information on PLplot, see

 http://www.plplot.org/

Also see the test file, F<t/plplot.pl> in this distribution for some working examples.

=head1 DESCRIPTION

This is the PDL interface to the PLplot graphics library.  It is
designed to be simple and light weight with a familiar 'perlish'
Object Oriented interface.

=head1 OPTIONS

The following options are supported.  Most options can be used
with any function.  A few are only supported on the call to 'new'.

=head2 Options used upon creation of a PLplot object (with 'new'):

=head3 BACKGROUND

Set the color for index 0, the plot background

=head3 DEV

Set the output device type.  To see a list of allowed types, try:

  PDL::Graphics::PLplot->new();

=for example

   PDL::Graphics::PLplot->new(DEV => 'png', FILE => 'test.png');

=head3 FILE

Set the output file or display.  For file output devices, sets
the output file name.  For graphical displays (like C<'xwin'>) sets
the name of the display, eg (C<'hostname.foobar.com:0'>)

=for example

   PDL::Graphics::PLplot->new(DEV => 'png',  FILE => 'test.png');
   PDL::Graphics::PLplot->new(DEV => 'xwin', FILE => ':0');

=head3 OPTS

Set plotting options.  See the PLplot documentation for the complete
listing of available options.  The value of C<'OPTS'> must be a hash
reference, whose keys are the names of the options.  For instance, to obtain
PostScript fonts with the ps output device, use:

=for example

   PDL::Graphics::PLplot->new(DEV => 'ps', OPTS => {drvopt => 'text=1'});

=head3 MEM

This option is used in conjunction with C<< DEV => 'mem' >>.  This option
takes as input a PDL image and allows one to 'decorate' it using PLplot.
The 'decorated' PDL image can then be written to an image file using,
for example, L<PDL::IO::Pic|PDL::IO::Pic>.  This option may not be available if
plplot does not include the 'mem' driver.

=for example

  # read in Earth image and draw an equator.
  my $pl = PDL::Graphics::PLplot->new (MEM => $earth, DEV => 'mem');
  my $x  = pdl(-180, 180);
  my $y  = zeroes(2);
  $pl->xyplot($x, $y,
              BOX => [-180,180,-90,90],
              VIEWPORT => [0.0, 1.0, 0.0, 1.0],
              XBOX => '', YBOX => '',
              PLOTTYPE => 'LINE');
  $pl->close;

=head3 FRAMECOLOR

Set color index 1, the frame color

=head3 JUST

A flag used to specify equal scale on the axes.  If this is
not specified, the default is to scale the axes to fit best on
the page.

=for example

  PDL::Graphics::PLplot->new(DEV => 'png',  FILE => 'test.png', JUST => 1);

=head3 ORIENTATION

The orientation of the plot:

  0 --   0 degrees (landscape mode)
  1 --  90 degrees (portrait mode)
  2 -- 180 degrees (seascape mode)
  3 -- 270 degrees (upside-down mode)

Intermediate values (0.2) are acceptable if you are feeling daring.

=for example

  # portrait orientation
  PDL::Graphics::PLplot->new(DEV => 'png',  FILE => 'test.png', ORIENTATION => 1);

=head3 PAGESIZE

Set the size in pixels of the output page.

=for example

  # PNG 500 by 600 pixels
  PDL::Graphics::PLplot->new(DEV => 'png',  FILE => 'test.png', PAGESIZE => [500,600]);

=head3 SUBPAGES

Set the number of sub pages in the plot, [$nx, $ny]

=for example

  # PNG 300 by 600 pixels
  # Two subpages stacked on top of one another.
  PDL::Graphics::PLplot->new(DEV => 'png',  FILE => 'test.png', PAGESIZE => [300,600],
                                              SUBPAGES => [1,2]);

=head2 Options used after initialization (after 'new')

=head3 BOX

Set the plotting box in world coordinates.  Used to explicitly
set the size of the plotting area.

=for example

 my $pl = PDL::Graphics::PLplot->new(DEV => 'png',  FILE => 'test.png');
 $pl->xyplot ($x, $y, BOX => [0,100,0,200]);

=head3 CHARSIZE

Set the size of text in multiples of the default size.
C<< CHARSIZE => 1.5 >> gives characters 1.5 times the normal size.

=head3 COLOR

Set the current color for plotting and character drawing.
Colors are specified not as color indices but as RGB triples.
Some pre-defined triples are included:

  BLACK        GREEN        WHEAT        BLUE
  RED          AQUAMARINE   GREY         BLUEVIOLET
  YELLOW       PINK         BROWN        CYAN
  TURQUOISE    MAGENTA      SALMON       WHITE

=for example

 # These two are equivalent:
 $pl->xyplot ($x, $y, COLOR => 'YELLOW');
 $pl->xyplot ($x, $y, COLOR => [0,255,0]);

=head3 LINEWIDTH

Set the line width for plotting.  Values range from 1 to a device dependent maximum.

=head3 LINESTYLE

Set the line style for plotting.  Pre-defined line styles use values 1 to 8, one being
a solid line, 2-8 being various dashed patterns.

=head3 MAJTICKSIZE

Set the length of major ticks as a fraction of the default setting.
One (default) means leave these ticks the normal size.

=head3 MINTICKSIZE

Set the length of minor ticks (and error bar terminals) as a fraction of the default setting.
One (default) means leave these ticks the normal size.

=head3 NXSUB

The number of minor tick marks between each major tick mark on the X axis.
Specify zero (default) to let PLplot compute this automatically.

=head3 NYSUB

The number of minor tick marks between each major tick mark on the Y axis.
Specify zero (default) to let PLplot compute this automatically.

=head3 PALETTE

Load pre-defined color map 1 color ranges.  Currently, values include:

  RAINBOW   -- from Red to Violet through the spectrum
  REVERSERAINBOW   -- Violet through Red
  GREYSCALE -- from black to white via grey.
  REVERSEGREYSCALE -- from white to black via grey.
  GREENRED  -- from green to red
  REDGREEN  -- from red to green

=for example

 # Plot x/y points with the z axis in color
 $pl->xyplot ($x, $y, PALETTE => 'RAINBOW', PLOTTYPE => 'POINTS', COLORMAP => $z);

=head3 PLOTTYPE

Specify which type of XY plot is desired:

  LINE       -- A line
  POINTS     -- A bunch of symbols
  LINEPOINTS -- both

=head3 SUBPAGE

Set which subpage to plot on.  Subpages are numbered 1 to N.
A zero can be specified meaning 'advance to the next subpage' (just a call to
L<pladv()|/pladv>).

=for example

  my $pl = PDL::Graphics::PLplot->new(DEV      => 'png',
                                        FILE     => 'test.png',
                                        SUBPAGES => [1,2]);
  $pl->xyplot ($x, $y, SUBPAGE => 1);
  $pl->xyplot ($a, $b, SUBPAGE => 2);


=head3 SYMBOL

Specify which symbol to use when plotting C<< PLOTTYPE => 'POINTS' >>.
A large variety of symbols are available, see:
http://plplot.sourceforge.net/examples-data/demo07/x07.*.png, where * is 01 - 17.

=head3 SYMBOLSIZE

Specify the size of symbols plotted in multiples of the default size (1).
Value are real numbers from 0 to large.

=head3 TEXTPOSITION

Specify the placement of text.  Either relative to border, specified as:

 [$side, $disp, $pos, $just]

Where

  side = 't', 'b', 'l', or 'r' for top, bottom, left and right
  disp is the number of character heights out from the edge
  pos  is the position along the edge of the viewport, from 0 to 1.
  just tells where the reference point of the string is: 0 = left, 1 = right, 0.5 = center.

or inside the plot window, specified as:

 [$x, $y, $dx, $dy, $just]

Where

  x  = x coordinate of reference point of string.
  y  = y coordinate of reference point of string.
  dx   Together with dy, this specifies the inclination of the string.
       The baseline of the string is parallel to a line joining (x, y) to (x+dx, y+dy).
  dy   Together with dx, this specifies the inclination of the string.
  just Specifies the position of the string relative to its reference point.
       If just=0, the reference point is at the left and if just=1,
       it is at the right of the string. Other values of just give
       intermediate justifications.

=for example

 # Plot text on top of plot
 $pl->text ("Top label",  TEXTPOSITION => ['t', 4.0, 0.5, 0.5]);

 # Plot text in plotting area
 $pl->text ("Line label", TEXTPOSITION => [50, 60, 5, 5, 0.5]);

=head3 TITLE

Add a title on top of a plot.

=for example

 # Plot text on top of plot
 $pl->xyplot ($x, $y, TITLE => 'X vs. Y');

=head3 VIEWPORT

Set the location of the plotting window on the page.
Takes a four element array ref specifying:

 xmin -- The coordinate of the left-hand edge of the viewport. (0 to 1)
 xmax -- The coordinate of the right-hand edge of the viewport. (0 to 1)
 ymin -- The coordinate of the bottom edge of the viewport. (0 to 1)
 ymax -- The coordinate of the top edge of the viewport. (0 to 1)

=for example

 # Make a small plotting window in the lower left of the page
 $pl->xyplot ($x, $y, VIEWPORT => [0.1, 0.5, 0.1, 0.5]);

 # Also useful in creating color keys:
 $pl->xyplot   ($x, $y, PALETTE => 'RAINBOW', PLOTTYPE => 'POINTS', COLORMAP => $z);
 $pl->colorkey ($z, 'v', VIEWPORT => [0.93, 0.96, 0.15, 0.85]);

=head3 XBOX

Specify how to label the X axis of the plot as a string of option letters:

  a: Draws axis, X-axis is horizontal line (y=0), and Y-axis is vertical line (x=0).
  b: Draws bottom (X) or left (Y) edge of frame.
  c: Draws top (X) or right (Y) edge of frame.
  f: Always use fixed point numeric labels.
  g: Draws a grid at the major tick interval.
  h: Draws a grid at the minor tick interval.
  i: Inverts tick marks, so they are drawn outwards, rather than inwards.
  l: Labels axis logarithmically. This only affects the labels, not the data,
     and so it is necessary to compute the logarithms of data points before
     passing them to any of the drawing routines.
  m: Writes numeric labels at major tick intervals in the
     unconventional location (above box for X, right of box for Y).
  n: Writes numeric labels at major tick intervals in the conventional location
     (below box for X, left of box for Y).
  s: Enables subticks between major ticks, only valid if t is also specified.
  t: Draws major ticks.

The default is C<'BCNST'> which draws lines around the plot, draws major and minor
ticks and labels major ticks.

=for example

 # plot two lines in a box with independent X axes labeled
 # differently on top and bottom
 $pl->xyplot($x1, $y, XBOX  => 'bnst',  # bottom line, bottom numbers, ticks, subticks
	              YBOX  => 'bnst'); # left line, left numbers, ticks, subticks
 $pl->xyplot($x2, $y, XBOX => 'cmst', # top line, top numbers, ticks, subticks
	              YBOX => 'cst',  # right line, ticks, subticks
	              BOX => [$x2->minmax, $y->minmax]);

=head3 XERRORBAR

Used only with L</xyplot>.  Draws horizontal error bars at all points (C<$x>, C<$y>) in the plot.
Specify a PDL containing the same number of points as C<$x> and C<$y>
which specifies the width of the error bar, which will be centered at (C<$x>, C<$y>).

=head3 XLAB

Specify a label for the X axis.

=head3 XTICK

Interval (in graph units/world coordinates) between major x axis tick marks.
Specify zero (default) to allow PLplot to compute this automatically.

=head3 YBOX

Specify how to label the Y axis of the plot as a string of option letters.
See L</XBOX>.

=head3 YERRORBAR

Used only for xyplot.  Draws vertical error bars at all points (C<$x>, C<$y>) in the plot.
Specify a PDL containing the same number of points as C<$x> and C<$y>
which specifies the width of the error bar, which will be centered at (C<$x>, C<$y>).

=head3 YLAB

Specify a label for the Y axis.

=head3 YTICK

Interval (in graph units/world coordinates) between major y axis tick marks.
Specify zero (default) to allow PLplot to compute this automatically.

=head3 ZRANGE

For L</xyplot> (when C<COLORMAP> is specified), for
L</shadeplot> and for L</colorkey>.
Normally, the range of the Z variable (color) is taken as
C<< $z->minmax >>.  If a different range is desired,
specify it in C<ZRANGE>, like so:

  $pl->shadeplot ($z, $nlevels, PALETTE => 'GREENRED', ZRANGE => [0,100]);

or

  $pl->xyplot ($x, $y, PALETTE  => 'RAINBOW', PLOTTYPE => 'POINTS',
	               COLORMAP => $z,        ZRANGE => [-90,-20]);
  $pl->colorkey  ($z, 'v', VIEWPORT => [0.93, 0.96, 0.13, 0.85],
                       ZRANGE => [-90,-20]);

=head1 FUNCTIONS

=head2 new

=for ref

Create an object representing a plot.

=for usage

 Arguments:
 none.

 Supported options:
 BACKGROUND
 DEV
 FILE
 FRAMECOLOR
 JUST
 PAGESIZE
 SUBPAGES

=for example

  my $pl = PDL::Graphics::PLplot->new(DEV => 'png',  FILE => 'test.png');


=head2 setparm

=for ref

Set options for a plot object.

=for usage

 Arguments:
 none.

 Supported options:
 All options except:

 BACKGROUND
 DEV
 FILE
 FRAMECOLOR
 JUST
 PAGESIZE
 SUBPAGES

 (These must be set in call to 'new'.)

=for example

  $pl->setparm (TEXTSIZE => 2);

=head2 xyplot

=for ref

Plot XY lines and/or points.  Also supports color scales for points.
This function works with bad values.  If a bad value is specified for
a points plot, it is omitted.  If a bad value is specified for a line
plot, the bad value makes a gap in the line.  This is useful for
drawing maps; for example C<$x> and C<$y> can be the continent boundary
latitude and longitude.

=for usage

 Arguments:
 $x, $y

 Supported options:
 All options except:

 BACKGROUND
 DEV
 FILE
 FRAMECOLOR
 JUST
 PAGESIZE
 SUBPAGES

 (These must be set in call to 'new'.)

=for example

  $pl->xyplot($x, $y, PLOTTYPE => 'POINTS', COLOR => 'BLUEVIOLET', SYMBOL => 1, SYMBOLSIZE => 4);
  $pl->xyplot($x, $y, PLOTTYPE => 'LINEPOINTS', COLOR => [50,230,30]);
  $pl->xyplot($x, $y, PALETTE => 'RAINBOW', PLOTTYPE => 'POINTS', COLORMAP => $z);


=head2 colorkey

=for ref

Plot a color key showing which color represents which value

=for usage

 Arguments:
 $range   : A PDL which tells the range of the color values
 $orientation : 'v' for vertical color key, 'h' for horizontal

 Supported options:
 All options except:

 BACKGROUND
 DEV
 FILE
 FRAMECOLOR
 JUST
 PAGESIZE
 SUBPAGES

 (These must be set in call to 'new'.)

=for example

  # Plot X vs. Y with Z shown by the color.  Then plot
  # vertical key to the right of the original plot.
  $pl->xyplot ($x, $y, PALETTE => 'RAINBOW', PLOTTYPE => 'POINTS', COLORMAP => $z);
  $pl->colorkey ($z, 'v', VIEWPORT => [0.93, 0.96, 0.15, 0.85]);


=head2 shadeplot

=for ref

Create a shaded contour plot of 2D PDL 'z' with 'nsteps' contour levels.
Linear scaling is used to map the coordinates of Z(X, Y) to world coordinates
via the L</BOX> option.

=for usage

 Arguments:
 $z : A 2D PDL which contains surface values at each XY coordinate.
 $nsteps : The number of contour levels requested for the plot.

 Supported options:
 All options except:

 BACKGROUND
 DEV
 FILE
 FRAMECOLOR
 JUST
 PAGESIZE
 SUBPAGES

 (These must be set in call to 'new'.)

=for example

  # vertical key to the right of the original plot.
  # The BOX must be specified to give real coordinate values to the $z array.
  $pl->shadeplot ($z, $nsteps, BOX => [-1, 1, -1, 1], PALETTE => 'RAINBOW', ZRANGE => [0,100]);
  $pl->colorkey  ($z, 'v', VIEWPORT => [0.93, 0.96, 0.15, 0.85], ZRANGE => [0,100]);

=head2 histogram

=for ref

Create a histogram of a 1-D variable.

=for usage

 Arguments:
 $x : A 1D PDL
 $nbins : The number of bins to use in the histogram.

 Supported options:
 All options except:

 BACKGROUND
 DEV
 FILE
 FRAMECOLOR
 JUST
 PAGESIZE
 SUBPAGES

 (These must be set in call to 'new'.)

=for example

  $pl->histogram ($x, $nbins, BOX => [$min, $max, 0, 100]);

=head2 text

=for ref

Write text on a plot.  Text can either be written
with respect to the borders or at an arbitrary location and angle
(see the L</TEXTPOSITION> entry).

=for usage

 Arguments:
 $t : The text.

 Supported options:
 All options except:

 BACKGROUND
 DEV
 FILE
 FRAMECOLOR
 JUST
 PAGESIZE
 SUBPAGES

 (These must be set in call to 'new'.)

=for example

  $pl->text("Count", COLOR => 'PINK',
	    TEXTPOSITION => ['t', 3, 0.5, 0.5]); # top, 3 units out, string ref. pt in
                                                 # center of string, middle of axis

=head2 close

=for ref

Close a PLplot object, writing out the file and cleaning up.

=for usage

Arguments:
None

Returns:
Nothing

This closing of the PLplot object can be done explicitly though the
'close' method.  Alternatively, a DESTROY block does an automatic
close whenever the PLplot object passes out of scope.

=for example

  $pl->close;

=cut

# pull in low level interface
use vars qw(%_constants %_actions);

# Colors (from rgb.txt) are stored as RGB triples
# with each value from 0-255
%_constants = (
	       BLACK      => [  0,  0,  0],
	       RED        => [240, 50, 50],
	       YELLOW     => [255,255,  0],
	       GREEN      => [  0,255,  0],
	       AQUAMARINE => [127,255,212],
	       PINK       => [255,192,203],
	       WHEAT      => [245,222,179],
	       GREY       => [190,190,190],
	       BROWN      => [165, 42, 42],
	       BLUE       => [  0,  0,255],
	       BLUEVIOLET => [138, 43,226],
	       CYAN       => [  0,255,255],
	       TURQUOISE  => [ 64,224,208],
	       MAGENTA    => [255,  0,255],
	       SALMON     => [250,128,114],
	       WHITE      => [255,255,255],
	      );

# a hash of subroutines to invoke when certain keywords are specified
# These are called with arg(0) = $self (the plot object)
#                   and arg(1) = value specified for keyword
%_actions =
  (


   # Set color for index 0, the plot background
   BACKGROUND => sub {
     my $self  = shift;
     my $color = _color(shift);
     $self->{COLORS}[0] = $color;
     plscolbg (@$color);
   },

   # set plotting box in world coordinates
   BOX        => sub {
     my $self  = shift;
     my $box   = shift;
     die "Box must be a ref to a four element array" unless (ref($box) =~ /ARRAY/ and @$box == 4);
     $self->{BOX} = $box;
   },

   CHARSIZE   => sub { my $self = shift;
                       $self->{CHARSIZE} = $_[0];
                       plschr   (0, $_[0]) },  # 0 - N

   COLOR =>
   # maintain color map, set to specified rgb triple
   sub {
     my $self  = shift;
     my $color = _color(shift);

     # init.
     $self->{COLORS} = [] unless exists($self->{COLORS});

     my @idx = @{$self->{COLORS}}; # map of color index (0-15) to RGB triples
     my $found = 0;
     for (my $i=2;$i<@idx;$i++) {  # map entries 0 and 1 are reserved for BACKGROUND and FRAMECOLOR
       if (_coloreq ($color, $idx[$i])) {
	 $self->{CURRENT_COLOR_IDX} = $i;
	 $found = 1;
	 plscol0 ($self->{CURRENT_COLOR_IDX}, @$color);
       }
     }
     return if ($found);

     die "Too many colors used! (max 15)" if (@{$self->{COLORS}} > 14);

     # add this color as index 2 or greater (entries 0 and 1 reserved)
     my $idx = (@{$self->{COLORS}} > 1) ? @{$self->{COLORS}} : 2;
     $self->{COLORS}[$idx]      = $color;
     $self->{CURRENT_COLOR_IDX} = $idx;
     plscol0 ($self->{CURRENT_COLOR_IDX}, @$color);
   },

   # set output device type
   DEV        => sub { plsdev   ($_[1]) },   # this must be specified with call to new!

   # set PDL to plot into (alternative to specifying DEV)
   MEM        => sub { my $self = shift;
		       my $pdl  = shift;
		       my $x    = $pdl->getdim(1);
		       my $y    = $pdl->getdim(2);
		       plsmem   ($x, $y, $pdl);
		     },

   # set output file
   FILE       => sub { plsfnam  ($_[1]) },   # this must be specified with call to new!

   # set color for index 1, the plot frame and text
   FRAMECOLOR =>
   # set color index 1, the frame color
   sub {
     my $self  = shift;
     my $color = _color(shift);
     $self->{COLORS}[1] = $color;
     plscol0 (1, @$color);
   },

   # Set flag for equal scale axes
   JUST => sub {
     my $self  = shift;
     my $just  = shift;
     die "JUST must be 0 or 1 (defaults to 0)" unless ($just == 0 or $just == 1);
     $self->{JUST} = $just;
   },

    LINEWIDTH  => sub {
      my $self = shift;
      my $wid  = shift;
      die "LINEWIDTH must range from 0 to LARGE8" unless ($wid >= 0);
      $self->{LINEWIDTH} = $wid;
    },

   LINESTYLE  => sub {
     my $self = shift;
     my $sty  = shift;
     die "LINESTYLE must range from 1 to 8" unless ($sty >= 1 and $sty <= 8);
     $self->{LINESTYLE} = $sty;
   },

   MAJTICKSIZE  => sub {
     my $self = shift;
     my $val  = shift;
     die "MAJTICKSIZE must be greater than or equal to zero"
       unless ($val >= 0);
     plsmaj (0, $val);
   },

   MINTICKSIZE  => sub {
     my $self = shift;
     my $val  = shift;
     die "MINTICKSIZE must be greater than or equal to zero"
       unless ($val >= 0);
     plsmin (0, $val);
   },

   NXSUB  => sub {
     my $self = shift;
     my $val  = shift;
     die "NXSUB must be an integer greater than or equal to zero"
       unless ($val >= 0 and int($val) == $val);
     $self->{NXSUB} = $val;
   },

   NYSUB  => sub {
     my $self = shift;
     my $val  = shift;
     die "NYSUB must be an integer greater than or equal to zero"
       unless ($val >= 0 and int($val) == $val);
     $self->{NYSUB} = $val;
   },

   # set driver options, example for ps driver, {text => 1} is accepted
   OPTS => sub {
     my $self = shift;
     my $opts = shift;

     foreach my $opt (keys %$opts) {
       plsetopt ($opt, $$opts{$opt});
     }
   },

   # set driver options, example for ps driver, {text => 1} is accepted
   ORIENTATION => sub {
     my $self   = shift;
     my $orient = shift;

     die "Orientation must be between 0 and 4" unless ($orient >= 0 and $orient <= 4);
     $self->{ORIENTATION} = $orient;
   },

   PAGESIZE   =>
     # set plot size in mm.  Only useful in call to 'new'
     sub {
       my $self = shift;
       my $dims = shift;

       die "plot size must be a 2 element array ref:  X size in pixels, Y size in pixels"
	 if ((ref($dims) !~ /ARRAY/) || @$dims != 2);
       $self->{PAGESIZE} = $dims;
     },

   PALETTE =>

   # load some pre-done color map 1 setups
   sub {
     my $self = shift;
     my $pal  = shift;

     my %legal = (REVERSERAINBOW => 1, REVERSEGREYSCALE => 1, REDGREEN => 1, RAINBOW => 1, GREYSCALE => 1, GREENRED => 1);
     if ($legal{$pal}) {
       $self->{PALETTE} = $pal;
       if      ($pal eq 'RAINBOW') {
	 plscmap1l (0, PDL->new(0,1), PDL->new(0,300), PDL->new(0.5, 0.5), PDL->new(1,1), PDL->new(0,0));
       } elsif ($pal eq 'REVERSERAINBOW') {
	 plscmap1l (0, PDL->new(0,1), PDL->new(270,-30), PDL->new(0.5, 0.5), PDL->new(1,1), PDL->new(0,0));
       } elsif ($pal eq 'GREYSCALE') {
	 plscmap1l (0, PDL->new(0,1), PDL->new(0,0),   PDL->new(0,1), PDL->new(0,0), PDL->new(0,0));
       } elsif ($pal eq 'REVERSEGREYSCALE') {
	 plscmap1l (0, PDL->new(0,1), PDL->new(0,0),   PDL->new(1,0), PDL->new(0,0), PDL->new(0,0));
       } elsif ($pal eq 'GREENRED') {
	 plscmap1l (0, PDL->new(0,1), PDL->new(120,0), PDL->new(0.5, 0.5), PDL->new(1,1), PDL->new(1,1));
       } elsif ($pal eq 'REDGREEN') {
	 plscmap1l (0, PDL->new(0,1), PDL->new(0,120), PDL->new(0.5, 0.5), PDL->new(1,1), PDL->new(1,1));
       }
     } else {
       die "Illegal palette name.  Legal names are: " . join (" ", keys %legal);
     }
   },

   PLOTTYPE =>
   # specify plot type (LINE, POINTS, LINEPOINTS)
   sub {
     my $self = shift;
     my $val  = shift;

     my %legal = (LINE => 1, POINTS => 1, LINEPOINTS => 1);
     if ($legal{$val}) {
       $self->{PLOTTYPE} = $val;
     } else {
       die "Illegal plot type.  Legal options are: " . join (" ", keys %legal);
     }
   },

   SUBPAGE =>
   # specify which subpage to plot on 1-N or 0 (meaning 'next')
   sub {
     my $self = shift;
     my $val  = shift;
     my $err  = "SUBPAGE = \$npage where \$npage = 1-N or 0 (for 'next subpage')";
     if ($val >= 0) {
       $self->{SUBPAGE} = $val;
     } else {
       die $err;
     }
   },

   SUBPAGES =>
   # specify number of sub pages [nx, ny]
   sub {
     my $self = shift;
     my $val  = shift;
     my $err  = "SUBPAGES = [\$nx, \$ny] where \$nx and \$ny are between 1 and 127";
     if (ref($val) =~ /ARRAY/ and @$val == 2) {
       my ($nx, $ny) = @$val;
       if ($nx > 0 and $nx < 128 and $ny > 0 and $ny < 128) {
	 $self->{SUBPAGES} = [$nx, $ny];
       } else {
	 die $err;
       }
     } else {
       die $err;
     }
   },

   SYMBOL =>
   # specify type of symbol to plot
   sub {
     my $self = shift;
     my $val  = shift;

     if ($val >= 0 && $val < 3000) {
       $self->{SYMBOL} = $val;
     } else {
       die "Illegal symbol number.  Legal symbols are between 0 and 3000";
     }
   },

   SYMBOLSIZE => sub {
     my ($self, $size) = @_;
     die "symbol size must be a real number from 0 to (large)" unless ($size >= 0);
     $self->{SYMBOLSIZE} = $size;
   },

   TEXTPOSITION =>
   # specify placement of text.  Either relative to border, specified as:
   # [$side, $disp, $pos, $just]
   # or
   # inside plot window, specified as:
   # [$x, $y, $dx, $dy, $just] (see POD doc for details)
   sub {
     my $self = shift;
     my $val  = shift;

     die "TEXTPOSITION value must be an array ref with either:
          [$side, $disp, $pos, $just] or [$x, $y, $dx, $dy, $just]"
       unless ((ref($val) =~ /ARRAY/) and ((@$val == 4) || (@$val == 5)));

     if (@$val == 4) {
       $self->{TEXTMODE} = 'border';
     } else {
       $self->{TEXTMODE} = 'plot';
     }
     $self->{TEXTPOSITION} = $val;
   },

   # draw a title for the graph
   TITLE      => sub {
     my $self = shift;
     my $text = shift;
     $self->{TITLE} = $text;
   },

   # set the location of the plotting window on the page
   VIEWPORT => sub {
     my $self  = shift;
     my $vp    = shift;
     die "Viewport must be a ref to a four element array"
       unless (ref($vp) =~ /ARRAY/ and @$vp == 4);
     $self->{VIEWPORT} = $vp;
   },

   XBOX       =>
     # set X axis label options.  See pod for definitions.
     sub {
       my $self = shift;
       my $opts = lc shift;

       my @opts = split '', $opts;
       map { 'abcfghilmnst' =~ /$_/i || die "Illegal option $_.  Only abcfghilmnst permitted" } @opts;

       $self->{XBOX} = $opts;
     },

   # draw an X axis label for the graph
   XLAB       => sub {
     my $self = shift;
     my $text = shift;
     $self->{XLAB} = $text;
   },

   XTICK  => sub {
     my $self = shift;
     my $val  = shift;
     die "XTICK must be greater than or equal to zero"
       unless ($val >= 0);
     $self->{XTICK} = $val;
   },

   YBOX       =>
     # set Y axis label options.  See pod for definitions.
     sub {
       my $self = shift;
       my $opts = shift;

       my @opts = split '', $opts;
       map { 'abcfghilmnstv' =~ /$_/i || die "Illegal option $_.  Only abcfghilmnstv permitted" } @opts;

       $self->{YBOX} = $opts;
     },

   # draw an Y axis label for the graph
   YLAB       => sub {
     my $self = shift;
     my $text = shift;
     $self->{YLAB} = $text;
   },

   YTICK  => sub {
     my $self = shift;
     my $val  = shift;
     die "YTICK must be greater than or equal to zero"
       unless ($val >= 0);
     $self->{YTICK} = $val;
   },

   ZRANGE  => sub {
     my $self = shift;
     my $val  = shift;
     die "ZRANGE must be a perl array ref with min and max Z values"
       unless (ref($val) =~ /ARRAY/ && @$val == 2);
     $self->{ZRANGE} = $val;
   },

);


#
## Internal utility routines
#

# handle color as string in _constants hash or [r,g,b] triple
# Input:  either color name or [r,g,b] array ref
# Output: [r,g,b] array ref or exception
sub _color {
  my $c = shift;
  if      (ref($c) =~ /ARRAY/) {
    return $c;
  } elsif ($c = $_constants{$c}) {
    return $c;
  } else {
    die "Color $c not defined";
  }
}

# return 1 if input [r,g,b] triples are equal.
sub _coloreq {
  my ($a, $b) = @_;
  for (my $i=0;$i<3;$i++) { return 0 if ($$a[$i] != $$b[$i]); }
  return 1;
}

# Initialize plotting window given the world coordinate box and
# a 'justify' flag (for equal axis scales).
sub _setwindow {

  my $self = shift;

  # choose correct subwindow
  pladv ($self->{SUBPAGE}) if (exists ($self->{SUBPAGE}));
  delete ($self->{SUBPAGE});  # get rid of SUBPAGE so future plots will stay on same
                              # page unless user asks for specific page

  my $box  = $self->{BOX} || [0,1,0,1]; # default window

  sub MAX { ($_[0] > $_[1]) ? $_[0] : $_[1]; }

  # get subpage offsets from page left/bottom of image
  my ($spxmin, $spxmax, $spymin, $spymax) = (PDL->new(0),PDL->new(0),PDL->new(0),PDL->new(0));
  plgspa($spxmin, $spxmax, $spymin, $spymax);
  $spxmin = $spxmin->at(0);
  $spxmax = $spxmax->at(0);
  $spymin = $spymin->at(0);
  $spymax = $spymax->at(0);
  my $xsize = $spxmax - $spxmin;
  my $ysize = $spymax - $spymin;

  my @vp = @{$self->{VIEWPORT}};  # view port xmin, xmax, ymin, ymax in fraction of image size

  # if JUSTify is zero, set to the user specified (or default) VIEWPORT
  if ($self->{JUST} == 0) {
    plvpor(@vp);

  # compute viewport to allow the same scales for both axes
  } else {
    my $p_def = PDL->new(0);
    my $p_ht  = PDL->new(0);
    plgchr ($p_def, $p_ht);
    $p_def = $p_def->at(0);
    my $lb = 8.0 * $p_def;
    my $rb = 5.0 * $p_def;
    my $tb = 5.0 * $p_def;
    my $bb = 5.0 * $p_def;
    my $dx = $$box[1] - $$box[0];
    my $dy = $$box[3] - $$box[2];
    my $xscale = $dx / ($xsize - $lb - $rb);
    my $yscale = $dy / ($ysize - $tb - $bb);
    my $scale  = MAX($xscale, $yscale);
    my $vpxmin = MAX($lb, 0.5 * ($xsize - $dx / $scale));
    my $vpxmax = $vpxmin + ($dx / $scale);
    my $vpymin = MAX($bb, 0.5 * ($ysize - $dy / $scale));
    my $vpymax = $vpymin + ($dy / $scale);
    plsvpa($vpxmin, $vpxmax, $vpymin, $vpymax);
    $self->{VIEWPORT} = [$vpxmin/$xsize, $vpxmax/$xsize, $vpymin/$ysize, $vpymax/$ysize];
  }

  # set up world coords in window
  plwind (@$box);

}

# Add title and axis labels.
sub _drawlabels {

  my $self = shift;

  plcol0  (1); # set to frame color
  plmtex   (2.5, 0.5, 0.5, 't', $self->{TITLE}) if ($self->{TITLE});
  plmtex   (3.0, 0.5, 0.5, 'b', $self->{XLAB})  if ($self->{XLAB});
  plmtex   (3.5, 0.5, 0.5, 'l', $self->{YLAB})  if ($self->{YLAB});
  plcol0  ($self->{CURRENT_COLOR_IDX}); # set back

}


#
## user-visible routines
#

# This routine starts out a plot.  Generally one specifies
# DEV and FILE (device and output file name) as options.
sub new {
  my $type = shift;
  my $self = {};

  # set up object
  $self->{PLOTTYPE} = 'LINE';
  # $self->{CURRENT_COLOR_IDX} = 1;
  $self->{COLORS} = [];

  bless $self, $type;

  # set background and frame color first
  $self->setparm(BACKGROUND => 'WHITE',
		 FRAMECOLOR => 'BLACK');

  # set defaults, allow input options to override
  my %opts = (
	      COLOR      => 'BLACK',
	      XBOX       => 'BCNST',
	      YBOX       => 'BCNST',
	      JUST       => 0,
	      SUBPAGES   => [1,1],
	      VIEWPORT   => [0.1, 0.87, 0.13, 0.82],
	      SUBPAGE    => 0,
	      PAGESIZE   => [600, 500],
	      LINESTYLE  => 1,
              LINEWIDTH  => 0,
              SYMBOL     => 751, # a small square
	      NXSUB      => 0,
	      NYSUB      => 0,
	      ORIENTATION=> 0,
	      XTICK      => 0,
	      YTICK      => 0,
	      CHARSIZE   => 1,
	      @_);


  # apply options
  $self->setparm(%opts);

  # Do initial setup
  plspage (0, 0, @{$self->{PAGESIZE}}, 0, 0) if (defined($self->{PAGESIZE}));
  plssub (@{$self->{SUBPAGES}});
  plfontld (1); # extented symbol pages
  plscmap0n (16);   # set up color map 0 to 16 colors.  Is this needed?
  plscmap1n (128);  # set map 1 to 128 colors (should work for devices with 256 colors)
  plinit ();

  # set page orientation
  plsdiori ($self->{ORIENTATION});

  # set up plotting box
  $self->_setwindow;

  return $self;
}

# set parameters.  Called from user directly or from other routines.
sub setparm {
  my $self = shift;

  my %opts = @_;

  # apply all options
 OPTION:
  foreach my $o (keys %opts) {
    unless (exists($_actions{$o})) {
      warn "Illegal option $o, ignoring";
      next OPTION;
    }
    &{$_actions{$o}}($self, $opts{$o});
  }
}

# handle 2D plots
sub xyplot {
  my $self = shift;
  my $x    = shift;
  my $y    = shift;

  my %opts = @_;

  # only process COLORMAP entries once
  my $z = $opts{COLORMAP};
  delete ($opts{COLORMAP});

  # handle ERRORBAR options
  my $xeb = $opts{XERRORBAR};
  my $yeb = $opts{YERRORBAR};
  delete ($opts{XERRORBAR});
  delete ($opts{YERRORBAR});

  # apply options
  $self->setparm(%opts);

  unless (exists($self->{BOX})) {
    $self->{BOX} = [$x->minmax, $y->minmax];
  }

  # set up viewport, subpage, world coordinates
  $self->_setwindow;

  # draw labels
  $self->_drawlabels;

  # plot box
  plcol0  (1); # set to frame color
  plbox ($self->{XTICK}, $self->{NXSUB}, $self->{YTICK}, $self->{NYSUB},
	 $self->{XBOX}, $self->{YBOX}); # !!! note out of order call

  # set the color according to the color specified in the object
  # (we don't do this as an option, because then the frame might
  # get the color requested for the line/points
  plcol0  ($self->{CURRENT_COLOR_IDX});

  # set line style for plot only (not box)
  pllsty ($self->{LINESTYLE});

  # set line width for plot only (not box)
  plwid  ($self->{LINEWIDTH});

  # Plot lines if requested
  if  ($self->{PLOTTYPE} =~ /LINE/) {
    plline ($x, $y);
  }

  # set line width back
  plwid  (0);

  # plot points if requested
  if ($self->{PLOTTYPE} =~ /POINTS/) {
    my $c = $self->{SYMBOL};
    unless (defined($c)) {

      # the default for $c is a PDL of ones with shape
      # equal to $x with the first dimension removed
      my $z = PDL->zeroes($x->nelem);
      $c = PDL->ones($z->zcover) unless defined($c);
    }
    plssym   (0, $self->{SYMBOLSIZE}) if (defined($self->{SYMBOLSIZE}));

    if (defined($z)) {  # if a color range plot requested
      my ($min, $max) = exists ($self->{ZRANGE}) ? @{$self->{ZRANGE}} : $z->minmax;
      plcolorpoints ($x, $y, $z, $c, $min, $max);
    } else {
      plsym ($x, $y, $c);
    }
  }

  # Plot error bars, if requested
  if (defined($xeb)) {
    # horizontal (X) error bars
    plerrx ($x->nelem, $x - $xeb/2, $x + $xeb/2, $y);
  }

  if (defined($yeb)) {
    # vertical (Y) error bars
    plerry ($y->nelem, $x, $y - $yeb/2, $y + $yeb/2);
  }

}


# Draw a color key or wedge showing the scale of map1 colors
sub colorkey {
  my $self = shift;
  my $var  = shift;
  my $orientation = shift; # 'v' (for vertical) or 'h' (for horizontal)

  my %opts = @_;

  # apply options
  $self->setparm(%opts);

  # set up viewport, subpage, world coordinates
  $self->_setwindow;

  # draw labels
  $self->_drawlabels;

  my @box;

  plcol0  (1); # set to frame color

  my ($min, $max) = exists ($self->{ZRANGE}) ? @{$self->{ZRANGE}} : $var->minmax;

  # plot box
  if      ($orientation eq 'v') {
    # set world coordinates based on input variable
    @box = (0, 1, $min, $max);
    plwind (@box);
    plbox (0, 0, 0, 0, '', 'TM');  # !!! note out of order call
  } elsif ($orientation eq 'h') {
    @box = ($min, $max, 0, 1);
    plwind (@box);
    plbox (0, 0, 0, 0, 'TM', '');  # !!! note out of order call
  } else {
    die "Illegal orientation value: $orientation.  Should be 'v' (vertical) or 'h' (horizontal)";
  }

  # restore color setting
  plcol0  ($self->{CURRENT_COLOR_IDX});

  my $ncols = 128;  # set when PALETTE set
  if ($orientation eq 'v') {
    my $yinc = ($box[3] - $box[2])/$ncols;
    my $y0 = $box[2];
    for (my $i=0;$i<$ncols;$i++) {
      $y0 = $box[2] + ($i * $yinc);
      my $y1 = $y0 + $yinc;
      PDL::Graphics::PLplot::plcol1($i/$ncols);
      PDL::Graphics::PLplot::plfill (PDL->new($box[0],$box[1],$box[1],$box[0]),
				     PDL->new($y0,$y0,$y1,$y1));
    }
  } else {
    my $xinc = ($box[1] - $box[0])/$ncols;
    my $x0 = $box[0];
    for (my $i=0;$i<$ncols;$i++) {
      $x0 = $box[0] + ($i * $xinc);
      my $x1 = $x0 + $xinc;
      PDL::Graphics::PLplot::plcol1($i/$ncols);
      PDL::Graphics::PLplot::plfill (PDL->new($x0,$x0,$x1,$x1),
				     PDL->new($box[2],$box[3],$box[3],$box[2]));
    }
  }
}

# handle shade plots of gridded (2D) data
sub shadeplot {
  my $self   = shift;
  my $z      = shift;
  my $nsteps = shift;

  my %opts = @_;

  # apply options
  $self->setparm(%opts);

  my ($nx, $ny) = $z->dims;

  unless (exists($self->{BOX})) {
    $self->{BOX} = [0, $nx, 0, $ny];
  }

  # set up plotting box
  $self->_setwindow;

  # draw labels
  $self->_drawlabels;

  # plot box
  plcol0  (1); # set to frame color
  plbox ($self->{XTICK}, $self->{NXSUB}, $self->{YTICK}, $self->{NYSUB},
	 $self->{XBOX}, $self->{YBOX}); # !!! note out of order call

  my ($min, $max) = exists ($self->{ZRANGE}) ? @{$self->{ZRANGE}} : $z->minmax;
  my $clevel = ((PDL->sequence($nsteps)*(($max - $min)/($nsteps-1))) + $min);

  # may add as options later.  Now use constants
  my $fill_width = 2;
  my $cont_color = 0;
  my $cont_width = 0;

  my $rectangular = 1; # only false for non-linear coord mapping (not done yet in perl)

  # map X coords linearly to X range, Y coords linearly to Y range
  my $xmap = ((PDL->sequence($nx)*(($self->{BOX}[1] - $self->{BOX}[0])/($nx - 1))) + $self->{BOX}[0]);
  my $ymap = ((PDL->sequence($ny)*(($self->{BOX}[3] - $self->{BOX}[2])/($ny - 1))) + $self->{BOX}[2]);

  my $grid = plAllocGrid ($xmap, $ymap);

  plshades($z, @{$self->{BOX}}, $clevel, $fill_width,
           $cont_color, $cont_width, $rectangular,
	   0, \&pltr1, $grid);

  plFreeGrid ($grid);
}

# handle histograms
sub histogram {
  my $self   = shift;
  my $x      = shift;
  my $nbins  = shift;

  my %opts = @_;

  # apply options
  $self->setparm(%opts);

  my ($min, $max) = $x->minmax;

  unless (exists($self->{BOX})) {
    $self->{BOX} = [$min, $max, 0, $x->nelem]; # box probably too tall!
  }

  # set up plotting box
  $self->_setwindow;

  # draw labels
  $self->_drawlabels;

  # plot box
  plcol0  (1); # set to frame color
  plbox ($self->{XTICK}, $self->{NXSUB}, $self->{YTICK}, $self->{NYSUB},
	 $self->{XBOX}, $self->{YBOX}); # !!! note out of order call

  # set line style for plot only (not box)
  pllsty ($self->{LINESTYLE});

  # set line width for plot only (not box)
  plwid  ($self->{LINEWIDTH});

  # set color for histograms
  plcol0  ($self->{CURRENT_COLOR_IDX});

  plhist ($x, $min, $max, $nbins, 1);  # '1' is oldbins parm:  dont call plenv!

  # set line width back
  plwid  (0);

}

# Draw bar graphs
sub bargraph {
  my $self   = shift;
  my $labels = shift; # ref to perl list of labels for bars
  my $values = shift; # pdl of values for bars

  my %opts = @_;

  my $xmax = scalar(@$labels);

  # apply options
  $self->setparm(%opts);

  my ($ymin, $ymax) = $values->minmax;

  unless (exists($self->{BOX})) {
    $self->{BOX} = [0, $xmax, $ymin, $ymax]; # box probably too tall!
  }

  # set up plotting box
  $self->_setwindow;

  # draw labels
  $self->_drawlabels;

  # plot box
  plcol0  (1); # set to frame color
  plbox ($self->{XTICK}, $self->{NXSUB}, $self->{YTICK}, $self->{NYSUB},
	 'bc', $self->{YBOX}); # !!! note out of order call

  # plot labels
  plschr   (0, $self->{CHARSIZE} * 0.7); # use smaller characters
  my $pos = 0;
  my $maxlab = 20;  # max number of readable labels on x axis
  my $skip   = int($xmax/$maxlab) + 1;
  for (my $i=0;$i<$xmax;$i+=$skip) {
    my $lab = $$labels[$i];
    plmtex (0.2, ((0.5+$i)/$xmax), 1.0, "BV", $lab); # !!! out of order parms
  }

  plcol0  ($self->{CURRENT_COLOR_IDX}); # set back to line color

  # set line style for plot only (not box)
  pllsty ($self->{LINESTYLE});

  # set line width for plot only (not box)
  plwid  ($self->{LINEWIDTH});

  # draw bars
  plfbox (PDL->sequence($xmax)+0.5, $values);

  # set line width back
  plwid  (0);

}

# Add text to a plot
sub text {
  my $self = shift;
  my $text = shift;

  # apply options
  $self->setparm(@_);

  # set the color according to the color specified in the object
  plcol0  ($self->{CURRENT_COLOR_IDX});

  # plot either relative to border, or inside view port
  if      ($self->{TEXTMODE} eq 'border') {
    my ($side, $disp, $pos, $just) = @{$self->{TEXTPOSITION}};
    plmtex ($disp, $pos, $just, $side, $text); # !!! out of order parms
  } elsif ($self->{TEXTMODE} eq 'plot') {
    my ($x, $y, $dx, $dy, $just) = @{$self->{TEXTPOSITION}};
    plptex ($x, $y, $dx, $dy, $just, $text);
  }

}


# Explicitly close a plot and free the object
sub close {
  my $self = shift;
  plend1 ();
  return;
}






=head1 FUNCTIONS



=cut





=pod

The PDL low-level interface to the PLplot library closely mimics the C API.
Users are referred to the PLplot User's Manual, distributed with the source
PLplot tarball.  This manual is also available on-line at the PLplot web
site (L<http://www.plplot.org/>).

There are though two differences in way the functions are called.  The first
one is due to a limitation in the pp_def wrapper of PDL, which forces all
the non-piddle arguments to be at the end of the arguments list.  It is
the case of strings (C<char *>) arguments in the C API.  This affects the
following functions [shown below with their prototypes in PDL, with
arguments preceded by "(pdl)" are piddle-convertible; see the PLplot manual
for the meaning of the arguments]:

  plaxes ((pdl) x0, (pdl) y0, (pdl) xtick, (pdl) nxsub, (pdl) ytick,
          (pdl) nysub, (string) xopt, (string (yopt))
  plbox ((pdl) xtick, (pdl) nxsub, (pdl) ytick, (pdl) nysub,
         (string) xopt, (string) yopt)
  plbox3 ((pdl) xtick, (pdl) nsubx, (pdl) ytick, (pdl) nsuby,
          (pdl) ztick, (pdl) nsubz, (string) xopt, (string) xlabel,
	  (string) yopt, (string) ylabel, (string) zopt,
	  (string) zlabel)
  plmtex ((pdl) disp, (pdl) pos, (pdl) just, (string) side),
          (string) text);
  plstart ((pdl) nx, (pdl) ny, (string) devname);

The second notable different between the C and the PDL APIs is that many of
the PDL calls do not need arguments to specify the size of the the vectors
and/or matrices being passed.  This size parameters are deduced from the
size of the piddles, when possible.  For now, the following interfaces are
affected:

  plcont (f, kx, lx, ky, ly, clevel)
  plfill (x, y)
  plhist (data, datmin, datmax, nbin, oldwin)
  plline (x, y)
  plline3 (x, y, z)
  plpoly3 (x, y, z, draw, ifcc)
  plmesh (x, y, z, opt)
  plmeshc (x, y, z, opt, clevel)
  plot3d (x, y, z, opt, side)
  plpoin (x, y, code)
  plpoin3 (x, y, z, code)
  plscmap1l (itype, intensity, coord1, coord2, coord3, rev)
  plstyl (mark, space)
  plsym (x, y, code)

Some of the API functions implemented in PDL have other specificities in
comparison with the C API and will be discussed below.

=cut





=head2 pladv

=for sig

  Signature: (int page())


=for ref

info not available




=cut






*pladv = \&PDL::pladv;




=head2 plarrows

=for sig

  Signature: (double u(dima);double v(dima);double x(dima);double y(dima);int n();double scale();double dx();double dy())


=for ref

info not available




=cut






*plarrows = \&PDL::plarrows;




=head2 plaxes

=for sig

  Signature: (double xzero();double yzero();double xtick();int nxsub();double ytick();int nysub(); char *xopt;char *yopt)


=for ref

info not available




=cut






*plaxes = \&PDL::plaxes;




=head2 plbin

=for sig

  Signature: (int nbin();double x(dima);double y(dima);int center())


=for ref

info not available




=cut






*plbin = \&PDL::plbin;




=head2 plbox

=for sig

  Signature: (double xtick();int nxsub();double ytick();int nysub(); char *xopt;char *yopt)


=for ref

info not available




=cut






*plbox = \&PDL::plbox;




=head2 plbox3

=for sig

  Signature: (double xtick();int nsubx();double ytick();int nsuby();double ztick();int nsubz(); char *xopt;char *xlabel;char *yopt;char *ylabel;char *zopt;char *zlabel)


=for ref

info not available




=cut






*plbox3 = \&PDL::plbox3;




=head2 plcol0

=for sig

  Signature: (int icolzero())


=for ref

info not available




=cut






*plcol0 = \&PDL::plcol0;




=head2 plcol1

=for sig

  Signature: (double colone())


=for ref

info not available




=cut






*plcol1 = \&PDL::plcol1;




=head2 plcpstrm

=for sig

  Signature: (int iplsr();int flags())


=for ref

info not available




=cut






*plcpstrm = \&PDL::plcpstrm;




=head2 pldid2pc

=for sig

  Signature: (double xmin(dima);double ymin(dima);double xmax(dima);double ymax(dima))


=for ref

info not available




=cut






*pldid2pc = \&PDL::pldid2pc;




=head2 pldip2dc

=for sig

  Signature: (double xmin(dima);double ymin(dima);double xmax(dima);double ymax(dima))


=for ref

info not available




=cut






*pldip2dc = \&PDL::pldip2dc;




=head2 plenv

=for sig

  Signature: (double xmin();double xmax();double ymin();double ymax();int just();int axis())


=for ref

info not available




=cut






*plenv = \&PDL::plenv;




=head2 plenv0

=for sig

  Signature: (double xmin();double xmax();double ymin();double ymax();int just();int axis())


=for ref

info not available




=cut






*plenv0 = \&PDL::plenv0;




=head2 plerrx

=for sig

  Signature: (int n();double xmin(dima);double xmax(dima);double y(dima))


=for ref

info not available




=cut






*plerrx = \&PDL::plerrx;




=head2 plerry

=for sig

  Signature: (int n();double x(dima);double ymin(dima);double ymax(dima))


=for ref

info not available




=cut






*plerry = \&PDL::plerry;




=head2 plfill3

=for sig

  Signature: (int n();double x(dima);double y(dima);double z(dima))


=for ref

info not available




=cut






*plfill3 = \&PDL::plfill3;




=head2 plfont

=for sig

  Signature: (int ifont())


=for ref

info not available




=cut






*plfont = \&PDL::plfont;




=head2 plfontld

=for sig

  Signature: (int fnt())


=for ref

info not available




=cut






*plfontld = \&PDL::plfontld;




=head2 plgchr

=for sig

  Signature: (double [o]p_def(dima);double [o]p_ht(dima))


=for ref

info not available




=cut






*plgchr = \&PDL::plgchr;




=head2 plgcol0

=for sig

  Signature: (int [o]icolzero();int [o]r(dima);int [o]g(dima);int [o]b(dima))


=for ref

info not available




=cut






*plgcol0 = \&PDL::plgcol0;




=head2 plgcolbg

=for sig

  Signature: (int [o]r(dima);int [o]g(dima);int [o]b(dima))


=for ref

info not available




=cut






*plgcolbg = \&PDL::plgcolbg;




=head2 plgcompression

=for sig

  Signature: (int [o]compression(dima))


=for ref

info not available




=cut






*plgcompression = \&PDL::plgcompression;




=head2 plgdidev

=for sig

  Signature: (double [o]p_mar(dima);double [o]p_aspect(dima);double [o]p_jx(dima);double [o]p_jy(dima))


=for ref

info not available




=cut






*plgdidev = \&PDL::plgdidev;




=head2 plgdiori

=for sig

  Signature: (double [o]p_rot(dima))


=for ref

info not available




=cut






*plgdiori = \&PDL::plgdiori;




=head2 plgdiplt

=for sig

  Signature: (double [o]p_xmin(dima);double [o]p_ymin(dima);double [o]p_xmax(dima);double [o]p_ymax(dima))


=for ref

info not available




=cut






*plgdiplt = \&PDL::plgdiplt;




=head2 plgfam

=for sig

  Signature: (int [o]p_fam(dima);int [o]p_num(dima);int [o]p_bmax(dima))


=for ref

info not available




=cut






*plgfam = \&PDL::plgfam;




=head2 plglevel

=for sig

  Signature: (int [o]p_level(dima))


=for ref

info not available




=cut






*plglevel = \&PDL::plglevel;




=head2 plgpage

=for sig

  Signature: (double [o]p_xp(dima);double [o]p_yp(dima);int [o]p_xleng(dima);int [o]p_yleng(dima);int [o]p_xoff(dima);int [o]p_yoff(dima))


=for ref

info not available




=cut






*plgpage = \&PDL::plgpage;




=head2 plgspa

=for sig

  Signature: (double [o]xmin(dima);double [o]xmax(dima);double [o]ymin(dima);double [o]ymax(dima))


=for ref

info not available




=cut






*plgspa = \&PDL::plgspa;




=head2 plgxax

=for sig

  Signature: (int [o]p_digmax(dima);int [o]p_digits(dima))


=for ref

info not available




=cut






*plgxax = \&PDL::plgxax;




=head2 plgyax

=for sig

  Signature: (int [o]p_digmax(dima);int [o]p_digits(dima))


=for ref

info not available




=cut






*plgyax = \&PDL::plgyax;




=head2 plgzax

=for sig

  Signature: (int [o]p_digmax(dima);int [o]p_digits(dima))


=for ref

info not available




=cut






*plgzax = \&PDL::plgzax;




=head2 plhls

=for sig

  Signature: (double h();double l();double s())


=for ref

info not available




=cut






*plhls = \&PDL::plhls;




=head2 pljoin

=for sig

  Signature: (double xone();double yone();double xtwo();double ytwo())


=for ref

info not available




=cut






*pljoin = \&PDL::pljoin;




=head2 pllightsource

=for sig

  Signature: (double x();double y();double z())


=for ref

info not available




=cut






*pllightsource = \&PDL::pllightsource;




=head2 pllsty

=for sig

  Signature: (int lin())


=for ref

info not available




=cut






*pllsty = \&PDL::pllsty;




=head2 plmtex

=for sig

  Signature: (double disp();double pos();double just(); char *side;char *text)


=for ref

info not available




=cut






*plmtex = \&PDL::plmtex;




=head2 plpat

=for sig

  Signature: (int nlin();int inc(dima);int del(dima))


=for ref

info not available




=cut






*plpat = \&PDL::plpat;




=head2 plprec

=for sig

  Signature: (int setp();int prec())


=for ref

info not available




=cut






*plprec = \&PDL::plprec;




=head2 plpsty

=for sig

  Signature: (int patt())


=for ref

info not available




=cut






*plpsty = \&PDL::plpsty;




=head2 plptex

=for sig

  Signature: (double x();double y();double dx();double dy();double just(); char *text)


=for ref

info not available




=cut






*plptex = \&PDL::plptex;




=head2 plrgb

=for sig

  Signature: (double r();double g();double b())


=for ref

info not available




=cut






*plrgb = \&PDL::plrgb;




=head2 plrgb1

=for sig

  Signature: (int r();int g();int b())


=for ref

info not available




=cut






*plrgb1 = \&PDL::plrgb1;




=head2 plschr

=for sig

  Signature: (double def();double scale())


=for ref

info not available




=cut






*plschr = \&PDL::plschr;




=head2 plscmap0n

=for sig

  Signature: (int ncolzero())


=for ref

info not available




=cut






*plscmap0n = \&PDL::plscmap0n;




=head2 plscmap1n

=for sig

  Signature: (int ncolone())


=for ref

info not available




=cut






*plscmap1n = \&PDL::plscmap1n;




=head2 plscmap0

=for sig

  Signature: (int r(dima);int g(dima);int b(dima);int ncolzero())


=for ref

info not available




=cut






*plscmap0 = \&PDL::plscmap0;




=head2 plscmap1

=for sig

  Signature: (int r(dima);int g(dima);int b(dima);int ncolone())


=for ref

info not available




=cut






*plscmap1 = \&PDL::plscmap1;




=head2 plscol0

=for sig

  Signature: (int icolzero();int r();int g();int b())


=for ref

info not available




=cut






*plscol0 = \&PDL::plscol0;




=head2 plscolbg

=for sig

  Signature: (int r();int g();int b())


=for ref

info not available




=cut






*plscolbg = \&PDL::plscolbg;




=head2 plscolor

=for sig

  Signature: (int color())


=for ref

info not available




=cut






*plscolor = \&PDL::plscolor;




=head2 plscompression

=for sig

  Signature: (int compression())


=for ref

info not available




=cut






*plscompression = \&PDL::plscompression;




=head2 plsdidev

=for sig

  Signature: (double mar();double aspect();double jx();double jy())


=for ref

info not available




=cut






*plsdidev = \&PDL::plsdidev;




=head2 plsdimap

=for sig

  Signature: (int dimxmin();int dimxmax();int dimymin();int dimymax();double dimxpmm();double dimypmm())


=for ref

info not available




=cut






*plsdimap = \&PDL::plsdimap;




=head2 plsdiori

=for sig

  Signature: (double rot())


=for ref

info not available




=cut






*plsdiori = \&PDL::plsdiori;




=head2 plsdiplt

=for sig

  Signature: (double xmin();double ymin();double xmax();double ymax())


=for ref

info not available




=cut






*plsdiplt = \&PDL::plsdiplt;




=head2 plsdiplz

=for sig

  Signature: (double xmin();double ymin();double xmax();double ymax())


=for ref

info not available




=cut






*plsdiplz = \&PDL::plsdiplz;




=head2 pl_setcontlabelparam

=for sig

  Signature: (double offset();double size();double spacing();int active())


=for ref

info not available




=cut






*pl_setcontlabelparam = \&PDL::pl_setcontlabelparam;




=head2 pl_setcontlabelformat

=for sig

  Signature: (int lexp();int sigdig())


=for ref

info not available




=cut






*pl_setcontlabelformat = \&PDL::pl_setcontlabelformat;




=head2 plsfam

=for sig

  Signature: (int fam();int num();int bmax())


=for ref

info not available




=cut






*plsfam = \&PDL::plsfam;




=head2 plsmaj

=for sig

  Signature: (double def();double scale())


=for ref

info not available




=cut






*plsmaj = \&PDL::plsmaj;




=head2 plsmin

=for sig

  Signature: (double def();double scale())


=for ref

info not available




=cut






*plsmin = \&PDL::plsmin;




=head2 plsori

=for sig

  Signature: (int ori())


=for ref

info not available




=cut






*plsori = \&PDL::plsori;




=head2 plspage

=for sig

  Signature: (double xp();double yp();int xleng();int yleng();int xoff();int yoff())


=for ref

info not available




=cut






*plspage = \&PDL::plspage;




=head2 plspause

=for sig

  Signature: (int pause())


=for ref

info not available




=cut






*plspause = \&PDL::plspause;




=head2 plsstrm

=for sig

  Signature: (int strm())


=for ref

info not available




=cut






*plsstrm = \&PDL::plsstrm;




=head2 plssub

=for sig

  Signature: (int nx();int ny())


=for ref

info not available




=cut






*plssub = \&PDL::plssub;




=head2 plssym

=for sig

  Signature: (double def();double scale())


=for ref

info not available




=cut






*plssym = \&PDL::plssym;




=head2 plstar

=for sig

  Signature: (int nx();int ny())


=for ref

info not available




=cut






*plstar = \&PDL::plstar;




=head2 plstart

=for sig

  Signature: (int nx();int ny(); char *devname)


=for ref

info not available




=cut






*plstart = \&PDL::plstart;




=head2 plstripa

=for sig

  Signature: (int id();int pen();double x();double y())


=for ref

info not available




=cut






*plstripa = \&PDL::plstripa;




=head2 plstripd

=for sig

  Signature: (int id())


=for ref

info not available




=cut






*plstripd = \&PDL::plstripd;




=head2 plsvpa

=for sig

  Signature: (double xmin();double xmax();double ymin();double ymax())


=for ref

info not available




=cut






*plsvpa = \&PDL::plsvpa;




=head2 plsxax

=for sig

  Signature: (int digmax();int digits())


=for ref

info not available




=cut






*plsxax = \&PDL::plsxax;




=head2 plsxwin

=for sig

  Signature: (int window_id())


=for ref

info not available




=cut






*plsxwin = \&PDL::plsxwin;




=head2 plsyax

=for sig

  Signature: (int digmax();int digits())


=for ref

info not available




=cut






*plsyax = \&PDL::plsyax;




=head2 plszax

=for sig

  Signature: (int digmax();int digits())


=for ref

info not available




=cut






*plszax = \&PDL::plszax;




=head2 plvasp

=for sig

  Signature: (double aspect())


=for ref

info not available




=cut






*plvasp = \&PDL::plvasp;




=head2 plvpas

=for sig

  Signature: (double xmin();double xmax();double ymin();double ymax();double aspect())


=for ref

info not available




=cut






*plvpas = \&PDL::plvpas;




=head2 plvpor

=for sig

  Signature: (double xmin();double xmax();double ymin();double ymax())


=for ref

info not available




=cut






*plvpor = \&PDL::plvpor;




=head2 plw3d

=for sig

  Signature: (double basex();double basey();double height();double xminzero();double xmaxzero();double yminzero();double ymaxzero();double zminzero();double zmaxzero();double alt();double az())


=for ref

info not available




=cut






*plw3d = \&PDL::plw3d;




=head2 plwid

=for sig

  Signature: (int width())


=for ref

info not available




=cut






*plwid = \&PDL::plwid;




=head2 plwind

=for sig

  Signature: (double xmin();double xmax();double ymin();double ymax())


=for ref

info not available




=cut






*plwind = \&PDL::plwind;




=head2 plP_gpixmm

=for sig

  Signature: (double p_x(dima);double p_y(dima))


=for ref

info not available




=cut






*plP_gpixmm = \&PDL::plP_gpixmm;




=head2 plline

=for sig

  Signature: (x(n); y(n))


=for ref

info not available




=cut






*plline = \&PDL::plline;




=head2 plcolorpoints

=for sig

  Signature: (x(n); y(n); z(n); int sym(); minz(); maxz())


=for ref

info not available




=cut






*plcolorpoints = \&PDL::plcolorpoints;




=head2 plsmem

=for sig

  Signature: (int maxx();int maxy();image(3,x,y))


=for ref

info not available




=cut






*plsmem = \&PDL::plsmem;




=head2 plfbox

=for sig

  Signature: (xo(); yo())


=for ref

info not available




=cut






*plfbox = \&PDL::plfbox;




=head2 plParseOpts

=for sig

  Signature: (int [o] retval(); SV* argv; int mode)

=for ref

FIXME: documentation here!



=cut






*plParseOpts = \&PDL::plParseOpts;




=head2 plpoin

=for sig

  Signature: (x(n); y(n); int code())


=for ref

info not available




=cut






*plpoin = \&PDL::plpoin;




=head2 plpoin3

=for sig

  Signature: (x(n); y(n); z(n); int code())


=for ref

info not available




=cut






*plpoin3 = \&PDL::plpoin3;




=head2 plline3

=for sig

  Signature: (x(n); y(n); z(n))


=for ref

info not available




=cut






*plline3 = \&PDL::plline3;




=head2 plpoly3

=for sig

  Signature: (x(n); y(n); z(n); int draw(m); int ifcc())


=for ref

info not available




=cut






*plpoly3 = \&PDL::plpoly3;




=head2 plhist

=for sig

  Signature: (data(n); datmin(); datmax(); int nbin(); int oldwin())


=for ref

info not available




=cut






*plhist = \&PDL::plhist;




=head2 plfill

=for sig

  Signature: (x(n); y(n))


=for ref

info not available




=cut






*plfill = \&PDL::plfill;




=head2 plsym

=for sig

  Signature: (x(n); y(n); int code())


=for ref

info not available




=cut






*plsym = \&PDL::plsym;




=head2 plsurf3d

=for sig

  Signature: (x(nx); y(ny); z(nx,ny); int opt(); clevel(nlevel))


=for ref

info not available




=cut






*plsurf3d = \&PDL::plsurf3d;




=head2 plstyl

=for sig

  Signature: (int mark(nms); int space(nms))


=for ref

info not available




=cut






*plstyl = \&PDL::plstyl;




=head2 plAllocGrid

=for sig

  Signature: (double xg(nx); double yg(ny); int [o] grid())

=for ref

FIXME: documentation here!



=cut






*plAllocGrid = \&PDL::plAllocGrid;




=head2 plAlloc2dGrid

=for sig

  Signature: (double xg(nx,ny); double yg(nx,ny); int [o] grid())

=for ref

FIXME: documentation here!



=cut






*plAlloc2dGrid = \&PDL::plAlloc2dGrid;




=head2 init_pltr

=for sig

  Signature: (P(); C(); SV* p0; SV* p1; SV* p2)

=for ref

FIXME: documentation here!



=cut






*init_pltr = \&PDL::init_pltr;


init_pltr (\&pltr0, \&pltr1, \&pltr2);




=head2 plmap

=for sig

  Signature: (minlong(); maxlong(); minlat(); maxlat(); SV* mapform; char* type)


=for ref

info not available




=cut






*plmap = \&PDL::plmap;




=head2 plmeridians

=for sig

  Signature: (dlong(); dlat(); minlong(); maxlong(); minlat(); maxlat(); SV* mapform)


=for ref

info not available




=cut






*plmeridians = \&PDL::plmeridians;




=head2 plshades

=for sig

  Signature: (z(x,y); xmin(); xmax(); ymin(); ymax();
                  clevel(l); int fill_width(); int cont_color();
                  int cont_width(); int rectangular(); SV* defined; SV* pltr; SV* pltr_data)


=for ref

info not available




=cut






*plshades = \&PDL::plshades;




=head2 plcont

=for sig

  Signature: (f(nx,ny); int kx(); int lx(); int ky(); int ly(); clevel(nlevel); SV* pltr; SV* pltr_data)

=for ref

FIXME: documentation here!



=cut






*plcont = \&PDL::plcont;




=head2 plmesh

=for sig

  Signature: (x(nx); y(ny); z(nx,ny); int opt())

=for ref

FIXME: documentation here!



=cut






*plmesh = \&PDL::plmesh;




=head2 plmeshc

=for sig

  Signature: (x(nx); y(ny); z(nx,ny); int opt(); clevel(nlevel))

=for ref

FIXME: documentation here!



=cut






*plmeshc = \&PDL::plmeshc;




=head2 plot3d

=for sig

  Signature: (x(nx); y(ny); z(nx,ny); int opt(); int side())

=for ref

FIXME: documentation here!



=cut






*plot3d = \&PDL::plot3d;




=head2 plot3dc

=for sig

  Signature: (x(nx); y(ny); z(nx,ny); int opt(); clevel(nlevel))

=for ref

FIXME: documentation here!



=cut






*plot3dc = \&PDL::plot3dc;




=head2 plscmap1l

=for sig

  Signature: (int itype(); isty(n); coord1(n); coord2(n); coord3(n); int rev(nrev))

=for ref

FIXME: documentation here!



=cut






*plscmap1l = \&PDL::plscmap1l;




=head2 plshade1

=for sig

  Signature: (a(nx,ny); left(); right(); bottom(); top(); shade_min();shade_max(); sh_cmap(); sh_color(); sh_width();min_color(); min_width(); max_color(); max_width();rectangular(); SV* defined; SV* pltr; SV* pltr_data)

=for ref

FIXME: documentation here!



=cut






*plshade1 = \&PDL::plshade1;




=head2 plimage

=for sig

  Signature: (idata(nx,ny); xmin(); xmax(); ymin(); ymax();zmin(); zmax(); Dxmin(); Dxmax(); Dymin(); Dymax())


=for ref

info not available




=cut






*plimage = \&PDL::plimage;


=head2 plxormod

=for sig

  $status = plxormod ($mode)

=for ref

See the PLplot manual for reference.

=cut


=head2 plGetCursor

=for sig

  %gin = plGetCursor ()

=for ref

plGetCursor waits for graphics input event and translate to world
coordinates and returns a hash with the following keys:

    type:      of event (CURRENTLY UNUSED)
    state:     key or button mask
    keysym:    key selected
    button:    mouse button selected
    subwindow: subwindow (alias subpage, alias subplot) number
    string:    translated string
    pX, pY:    absolute device coordinates of pointer
    dX, dY:    relative device coordinates of pointer
    wX, wY:    world coordinates of pointer

Returns an empty hash if no translation to world coordinates is possible.

=cut


=head2 plgstrm

=for sig

  $strm = plgstrm ()

=for ref

Returns the number of the current output stream.

=cut


=head2 plgsdev

=for sig

  $driver = plgdev ()

=for ref

Returns the current driver name.

=cut


=head2 plmkstrm

=for sig

  $strm = plmkstrm ()

=for ref

Creates a new stream and makes it the default.  Returns the number of
the created stream.

=cut


=head2 plgver

=for sig

  $version = plgver ()

=for ref

See the PLplot manual for reference.

=cut




=head2 plstripc

=for sig

  Signature: (xmin(); xmax(); xjump(); ymin(); ymax();xlpos(); ylpos(); int y_ascl(); int acc();int colbox(); int collab();int colline(n); int styline(n);  int [o] id(); char* xspec; char* yspec; SV* legline;char* labx; char* laby; char* labtop)

=for ref

FIXME: documentation here!



=cut






*plstripc = \&PDL::plstripc;




=head2 plgriddata

=for sig

  Signature: (x(npts); y(npts); z(npts); xg(nptsx); yg(nptsy);int type(); data(); [o] zg(nptsx,nptsy))

=for ref

FIXME: documentation here!



=cut






*plgriddata = \&PDL::plgriddata;




=head2 plvect

=for sig

  Signature: (u(nx,ny); v(nx,ny); scale(); SV* pltr; SV* pltr_data)

=for ref

FIXME: documentation here!



=cut






*plvect = \&PDL::plvect;




=head2 plsvect

=for sig

  Signature: (arrowx(npts); arrowy(npts); int fill())


=for ref

info not available




=cut






*plsvect = \&PDL::plsvect;



=pod

=head1 AUTHORS

  Doug Hunt <dhunt@ucar.edu>
  Rafael Laboissiere <rlaboiss@users.sourceforge.net>

=head1 SEE ALSO

perl(1), PDL(1), L<http://www.plplot.org/>

=cut



;



# Exit with OK status

1;

		   