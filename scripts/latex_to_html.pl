use strict; 
use warnings; 
# use feature 'unicode_strings';
# use utf8;

use List::MoreUtils 'none';
# use Switch;
use Getopt::Long;

sub main 
{ 
    # my $week = 24;

    # switch($week) {
    # 	case 24 {
    # 	    my @wantchapters = (13..16);
    # 	}
    # 	case 25 {
    # 	    my @wantchapters = (17..22);
    # 	}
    # }

    # my ($chpstart, $chpend) = @ARGV;

    # Parse command line
    # my %args;
    # GetOptions(\%args,
    # 	       "startchapter=s",
    # 	       "stopchapter=s",
    # 	) or die "Invalid arguments!";
    # die "Missing -startchapter!" unless $args{startchapter};
    # die "Missing -stopchapter!" unless $args{stopchapter};

    # my $startchapter = $args{startchapter};
    # my $stopchapter = $args{stopchapter};

    ########################################
    # Variables for HTML header for this week's reading

    if(@ARGV < 1){
	print("Usage: $0 WEEKNUM\n");
	die;
    }
    # my $weeknum = 28;
    my $weeknum = $ARGV[0];

    # print("WEEKNUM: $weeknum\n");
    # exit

    my $startchapter;
    my $stopchapter;
    my $readingstr;
    my $GoogleDrivelink;
    my $whichbook;

    if( $weeknum eq 34 ){
	$startchapter = 1;
	$stopchapter = 6;
	$readingstr = "Aug 17–23 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1aTn0SUuUCepuhcJ4kf24g0QKh5EOzfve/view?usp=sharing";
	$whichbook = 10
    } elsif( $weeknum eq 33 ){
	$startchapter = 53;
	$stopchapter = 63;
	$readingstr = "Aug 10–16 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1QpuwVkuQt5rnqFS81eYOr-hYUHfyk7TP/view?usp=sharing";
	$whichbook = 9
    } elsif( $weeknum eq 32 ){
	$startchapter = 43;
	$stopchapter = 52;
	$readingstr = "Aug 3–9 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1kEPQ6mY1gX3KyWyAt4Kan5n64YClwR9n/view?usp=sharing";
	$whichbook = 9
    } elsif( $weeknum eq 31 ){
	$startchapter = 39;
	$stopchapter = 42;
	$readingstr = "July 27–Aug 2 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1O0roXdJxEQNcuuCvvkdrZF8Bln89URaS/view?usp=sharing";
	$whichbook = 9
    } elsif( $weeknum eq 30 ){
	$startchapter = 36;
	$stopchapter = 38;
	$readingstr = "July 20–26 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1zPZ4PEbuA3kOZCVH---mZGI_SqOz09bt/view?usp=sharing";
	$whichbook = 9
    } elsif( $weeknum eq 29 ){
	$startchapter = 32;
	$stopchapter = 35;
	$readingstr = "July 13–19 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1XWLseGzvap3YxmE7U9GV-JZtXGgI0vHu/view?usp=sharing";
	$whichbook = 9
    } elsif( $weeknum eq 28 ){
	$startchapter = 30;
	$stopchapter = 31;
	$readingstr = "July 6–12 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1E3BXZCO7CnZbLYcmj83l7RZ6BSCxppG3/view?usp=sharing";
	$whichbook = 9
    } elsif($weeknum == 27){
	$startchapter = 23;
	$stopchapter = 29;
	$readingstr = "June 29–July 5 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1-h6MIaaG6r7kUhgAlxfd42WJ2cqpIGEI/view?usp=sharing";
	$whichbook = 9
    } elsif ($weeknum == 26){
	$startchapter = 17;
	$stopchapter = 22;
	$readingstr = "June 22–28 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/10ZujvpmwmWV3nfqhthvjfjMf2LSp8cMx/view?usp=sharing";
	$whichbook = 9
    } elsif ($weeknum == 25){
	$startchapter = 13;
	$stopchapter = 16;
	$readingstr = "June 15–21 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1rHFdRQasZJEmIrc5Iw1fM3IBtPNKSdVO/view?usp=sharing";
	$whichbook = 9
    } elsif ($weeknum == 24){
	$startchapter = 8;
	$stopchapter = 12;
	$readingstr = "June 8–14 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1dP5Hz--e7HuHCGS58U1WmOHatPGV2U8c/view?usp=sharing";
	$whichbook = 9
    } elsif ($weeknum == 23){
	$startchapter = 5;
	$stopchapter = 7;
	$readingstr = "June 1–7 (Week ${weeknum})";
	$GoogleDrivelink = "https://drive.google.com/file/d/1k8jQYEh76CdU6M9jTNwCOnpVmm0zOVCD/view?usp=sharing";
	$whichbook = 9
    } else {
	die "Couldn't locate the week number (${weeknum}) you're talking about!\n";
    }

    # INFO
    print("Weeknum        : ${weeknum}\n");
    print("startchapter   : ${startchapter}\n");
    print("stopchapter    : ${stopchapter}\n");
    print("readingstr     : ${readingstr}\n");
    print("GoogleDrivelink: ${GoogleDrivelink}\n");

    my $upcasebook = "YUCK";
    my $booknum = "-99";
    my $bombook = "NOTABOOK";
    my $infil = "/NO/FILE";

    if ($whichbook eq 9) {
	$upcasebook = "ALMA";
	$booknum = "09";
	$bombook = 'Alma';
	$infil = '/SPENCEdata/Research/kids_book_of_mormon__geneve_1564/books/09_alma.tex'; 
    }
    elsif ($whichbook eq 10){
	$upcasebook = "HELAMAN";
	$booknum = "10";
	$bombook = 'Helaman';
	$infil = '/SPENCEdata/Research/kids_book_of_mormon__geneve_1564/books/10_helaman.tex'; 
    } else {
	die "Couldn't figure out which book!\n";
    }

    my $h3weekstr = "Week ${weeknum}: ${bombook} ${startchapter}–${stopchapter}";
    my $weekminusone = ${weeknum}-1;

    # Other variables
    my $curchapter = -1;
    my $curverse = -1;
    my @wantchapters = (${startchapter}..${stopchapter});
    my @gotchapters = ();
    my $headfil = '/SPENCEdata/Research/kids_book_of_mormon__geneve_1564/scripts/blogentry_header.html'; 
    my $utfil = "/SPENCEdata/Research/kids_book_of_mormon__geneve_1564/OUT/kids_bom_selection__${weeknum}__${bombook}_${startchapter}-${stopchapter}.html"; 

    my $holdoverstring = "";	# (sometimes) junk variable
    my $addholdover = 0;

    # For footnotes
    my $havefootnotes = 0;
    my @footnotes = ();
    my @footalph = ("a".."z");
    my $footcounter = 0;
    my $totfootcounter = 0;

    print "Getting $bombook chapters ${startchapter}--${stopchapter}\n\n";
    print "outputfile: $utfil\n";
    open(utFH, '>', $utfil) or die $!;
      
    # Write header to outputfile
    open(headerFH, $headfil) or die $!;
    while(my $String = <headerFH>) 
    { 
        if($String =~ /Week BLAH/) { 
	    $String =~ s/Week BLAH: BLAH/$h3weekstr/g;
	}

        if($String =~ /DATERANGEBLAH/) { 
	    $String =~ s/DATERANGEBLAH/${readingstr}/g;
	    $String =~ s/WEEKMINUSONE/${weekminusone}/g;
	}
	
        if($String =~ /TOPWEEKBLAH/) { 
	    $String =~ s/TOPWEEKBLAH/TOPWEEK${weeknum}/g;
	}


        if($String =~ /INSERTGOOGDRIVELINKHERE/) { 
	    $String =~ s/INSERTGOOGDRIVELINKHERE/${GoogleDrivelink}/g;
        } 

	# Write to utFH
	# print "HEADER:  $String\n";
	print utFH $String;

    }
    print "Closing headerfile\n";
    close(headerFH); 

    ########################################
    # WORK WITH .TEX FILE
    print "maininputfile : $infil\n";

    # Get chapters we are going to do, make tags
    my $jumptostr = 'Jump to: ';

    open(inFH, $infil) or die("Infil $infil not found"); 
    my $isfirst = 1;
    while(my $String = <inFH>) 
    { 

	# 0. Gather all chapters wanted
        if($String =~ /^%Chapter (\d+)/) { 

	    if ( $1 ~~ @wantchapters ) {
		push @gotchapters, $1;
		# print "Current chapter: $bombook $1\n";

		if ($isfirst eq 1) {
		    $jumptostr = $jumptostr . " <a href=\"#${booknum}_${upcasebook}_$1\"><b>${bombook} ${1}</b></a>";
		    $isfirst = 0;
		} else {
		    $jumptostr = $jumptostr . " <a href=\"#${booknum}_${upcasebook}_$1\"><b> ${1}</b></a>";
		}
	    }

        } 

    }
    print "gotchapters: @gotchapters\n";     # Foo Bar Moo
    print utFH "<div dir=\"ltr\" style=\"text-align: left;\" trbidi=\"on\">\n";
    print utFH "$jumptostr\n";
    print utFH "</div>\n\n";
    close(inFH); 

    # Write chapters and verses to outputfile
    open(inFH, $infil) or die("Infil $infil not found"); 
    while(my $String = <inFH>) 
    { 

	# 0. Gather all chapters wanted
        if($String =~ /^%Chapter (\d+)/) { 
            # print "Found $String\n"; 
	    push @gotchapters, $1;
	    # print "gotchapters: @gotchapters\n";     # Foo Bar Moo

	    $curchapter = $1;

	    # Reset footnote counter
	    $footcounter = 0;

	    if ( $1 ~~ @wantchapters ) {
		print "Current chapter: $bombook $1\n";
	    }

        } 

	if ( none { $_ eq $curchapter } @wantchapters ) {
	    # Do stuff
	    next;
	}  

	# if not ( $1 ~~ @wantchapters ) {
	#     next;
	# }
	

	# 1. Replace this regexp
	# "^\\bverse.*
	# "
	# with
	# ""
	# That is, skip this line!
        if($String =~ /^\\bverse/) { 
	    # print "Found a bverse\n";
	    next;
        } 

        if($String =~ /^\\bchapter/) { 
            # print "Found a bchapter string\n"; 
	    next;
        } 

	# 2. Replace
	# "^%Alma \([0-9]+\):\([0-9]+\)
	# "
	# with
	# "<!-- Alma \1:\2 -->
	# \2 "
        if($String =~ /^%$bombook (\d+):(\d+)/) { 
            # print "Found zis: $String\n"; 
	    $String = "<!-- Alma $1:$2 -->\n<b>$2</b>";
	    $holdoverstring = $String;
	    $addholdover = 1;
	    $curverse = $2;
	    next;
        } # else {
	#     $holdoverstring = "";
	# }

        if($String =~ /^%\s/) { 
	    print("Found comment line: '${String}'. Skip!");
	    next;
	}

	# 3. Replace "^\([0-9]+\) \(.*\)"
	# with
	# "<div dir="ltr" style="text-align: left;" trbidi="on">
	#  <font><b>\1</b> \2</font>
	# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>"

	# 4. Replace "^Chapter \([0-9]+\)"
	# with
	# "<div dir="ltr" style="text-align: left;" trbidi="on">
	#   <a href="#09_ALMA_\1"><b><font size="5">Alma \1</font></b></a>
	# </div>"
	$String =~ s/^%Chapter (\d+)/<br \/><div dir="ltr" style="text-align: left;" trbidi="on">\n  <a id="${booknum}_${upcasebook}_$1"><b><font size="5">$bombook $1<\/font><\/b><\/a> <a href="#TOPWEEK${weeknum}">(go to top)<\/a>\n<\/div>/g;

	# 5. Replace "---" with "—"
	$String =~ s/---/—/g;

	# 6. Regex-replace "\footnote{.*}" with ""
        if($String =~ /\\footnote\{.*}/) { 
	    $havefootnotes = 1;

	    # Create the tag
	    my $foottag = "${booknum}_${upcasebook}_${curchapter}_${curverse}_foot$footalph[${footcounter}]";
	    my $foottagfull = "<a id=\"" . $foottag . "\"><sup>$footalph[${footcounter}]<\/sup><\/a>";

	    # Get the footnote
	    (my $footnote = $String) =~ s/.*\\footnote\{(.*)}.*/$1/g;

	    # Add tag
	    $footnote = $foottagfull . $footnote;

	    push @footnotes, $footnote;
	    print("Got a footnote: $footnotes[$#footnotes]");

	    # Add href to verse
	    
	    # Replace footnote text with foottag
	    $String =~ s/\\footnote\{.*}/<a href=\"#${foottag}\"><sup>$footalph[${footcounter}]<\/sup><\/a>/g;

	    # print("$String");

	    $footcounter = $footcounter + 1;
	    $totfootcounter = $totfootcounter + 1;

	}

	# OLD; just junk footnote
	# $String =~ s/\\footnote{.*}//g;

	# 7. Replace "``" with "&ldquo;"
	$String =~ s/``/&ldquo;/g;

	# 8. Replace "''" with "&rdquo;"
	$String =~ s/''/&rdquo;/g;

	# 9. Replace "\lq" with "&lsquo;"
	$String =~ s/\\lq\s/&lsquo;/g;

	# 10. Replace "\rq" with "&rsquo;"
	$String =~ s/\\rq\s/&rsquo;/g;

	# Write to utFH
	if ($addholdover eq 1) {
	    $String = "$holdoverstring $String<br />";
	    $addholdover = 0;
	} 
	print utFH "${String}\n";
    } 

    if ($havefootnotes eq 1) {

	print("Adding ${totfootcounter} footnotes to html output:\n");

	print utFH "<br />\n";
	print utFH "<br />\n";
	print utFH "<b>Footnotes</b><br />\n";

	foreach (@footnotes) {
	    print utFH "$_<br />\n";
	}

    }

    # print "Closing inputfile : $infil\n";
    print "Closing inputfile\n";
    close(inFH); 
    print "Closing outputfile $utfil\n";
    close(utFH); 
} 
main(); 
