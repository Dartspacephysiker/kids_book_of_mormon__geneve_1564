# ;; This buffer is for text that is not saved, and for Lisp evaluation.
# ;; To create a file, visit it with C-x C-f and enter text in its buffer.

# TODO: Auto-generate links at top of document

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

    my %args;
    GetOptions(\%args,
	       "startchapter=s",
	       "stopchapter=s",
	) or die "Invalid arguments!";
    die "Missing -startchapter!" unless $args{startchapter};
    die "Missing -stopchapter!" unless $args{stopchapter};

    my $startchapter = $args{startchapter};
    my $stopchapter = $args{stopchapter};

    my $curchapter = -1;
    my @wantchapters = (${startchapter}..${stopchapter});
    my @gotchapters = ();
    my $upcasebook = "ALMA";
    my $booknum = "09";
    my $bombook = 'Alma';
    my $infil = '/SPENCEdata/Research/kids_book_of_mormon__geneve_1564/books/09_alma.tex'; 
    my $utfil = '/SPENCEdata/Research/kids_book_of_mormon__geneve_1564/kids_bom_selection.html'; 

    print "Getting $bombook chapters ${startchapter}--${stopchapter}\n\n";
    print "inputfile : $infil\n";
    open(inFH, $infil) or die("Infil $infil not found"); 
    print "outputfile: $utfil\n";
    open(utFH, '>', $utfil) or die $!;
      
    while(my $String = <inFH>) 
    { 

	# 0. Gather all chapters wanted
        if($String =~ /^%Chapter (\d+)/) { 
            # print "Found $String\n"; 
	    push @gotchapters, $1;
	    # print "gotchapters: @gotchapters\n";     # Foo Bar Moo

	    $curchapter = $1;

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
	    $String = "<!-- Alma $1:$2 -->\n<b>$2</b>"
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
	$String =~ s/^%Chapter (\d+)/<div dir="ltr" style="text-align: left;" trbidi="on">\n  <a href="#${booknum}_${upcasebook}_$1"><b><font size="5">$upcasebook $1<\/font><\/b><\/a>\n<\/div>/g;

	# 5. Replace "---" with "—"
	$String =~ s/---/—/g;

	# 6. Regex-replace "\footnote{.*}" with ""

	# 7. Replace "``" with "&ldquo;"
	$String =~ s/``/&ldquo/g;

	# 8. Replace "''" with "&rdquo;"
	$String =~ s/''/&rdquo/g;

	# 9. Replace "\lq" with "&lsquo;"
	$String =~ s/\\lq /&lsquo/g;

	# 10. Replace "\rq" with "&rsquo;"
	$String =~ s/\\rq /&rsquo/g;

	# Write to utFH
	print utFH "$String\n";
    } 
    # print "Closing inputfile : $infil\n";
    print "Closing inputfile\n";
    close(inFH); 
    print "Closing outputfile\n";
    close(utFH); 
} 
main(); 


# <div dir="ltr" style="text-align: left;" trbidi="on">
#   <b><font size="5">Chapter 17</font></b>
# </div>
# <div dir="ltr" style="text-align: left;" trbidi="on">
#   <font><b>1</b> And Alma went southward from the land of Gideon, toward the land
#     of Manti. Along the way, to his great surprise he met the sons of Mosiah,
#     who were journeying toward the land of Zarahemla.</font>
# </div>


# <div dir="ltr" style="text-align: left;" trbidi="on">
# <a href="#09_ALMA_17">Alma 17</a>
# </div>
# <div dir="ltr" style="text-align: left;" trbidi="on">
# <a href="#09_ALMA_18">Alma 18</a>
# </div>
# <div dir="ltr" style="text-align: left;" trbidi="on">
# <a href="#09_ALMA_19">Alma 19</a>
# </div>
# <div dir="ltr" style="text-align: left;" trbidi="on">
# <a href="#09_ALMA_20">Alma 20</a>
# </div>
# <div dir="ltr" style="text-align: left;" trbidi="on">
# <a href="#09_ALMA_21">Alma 21</a>
# </div>
# <div dir="ltr" style="text-align: left;" trbidi="on">
# <a href="#09_ALMA_22">Alma 22</a>
# </div>


# EXAMPLE: ALMA 17 AND ALMA 18

# <div dir="ltr" style="text-align: left;" trbidi="on">
#   <a id="09_ALMA_17"><b><font size="5">Alma 17</font></b></a>
# </div>
# <!-- Alma 17:1 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>1</b> And Alma went southward from the land of Gideon, toward the land of Manti. Along the way, to his great surprise he met the sons of Mosiah, who were journeying toward the land of Zarahemla.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:2 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>2</b> Now, these sons of Mosiah were with Alma when the angel first appeared to him. It filled Alma with joy to see his brothers. He was even more filled with joy, because they were still his brothers in the Lord. They had become strong in the truth. They were people with healthy and strong minds, and they had studied the scriptures very hard so that they could know the word of God.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:3 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>3</b> But this isn't all. They had prayed and fasted very much, and so they had the spirit of prophecy, and the spirit of revelation. When they taught, they taught with power and authority from God.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:4 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>4</b> They had been teaching the word of God for fourteen years among the Lamanites. They had been very successful in bringing many to know the truth. The power of their words led many people to go to the altar of God, to call on God's name and to confess their sins to God.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:5 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>5</b> Here is the story of what happened to them during their journeys. They had many problems and trials. They had suffered very much, both their bodies and their minds. They suffered hunger, thirst, and weariness, and they worked very hard to have God's spirit with them.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:6 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>6</b> This is how their journeys began: They left their father, Mosiah, in the first year of the judges. They had refused to take over the kingdom, even though their father and the people wanted them to.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:7 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>7</b> They left the land of Zarahemla with their swords, spears, bows, arrows, and slings. They took these things with them so that they could get food while they were in the wilderness.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:8 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>8</b> And so they left into the wilderness with some people they had chosen. They planned to go to the land of Nephi, to preach the word of God to the Lamanites.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:9 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>9</b> And they journeyed for many days in the wilderness. They fasted and prayed often, asking the Lord to grant them some of his Spirit to go with them and stay with them, so that they could be tools in God's hands to teach their relatives, the Lamanites, the truth, and help them understand that the traditions of their ancestors were wrong.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:10 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>10</b> And the Lord did grant them his Spirit. He said to them, &ldquo;Be comforted.&rdquo; And they were comforted.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:11 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>11</b> The Lord also said to them: &ldquo;Go among the Lamanites, your family, and spread my word. Be patient when you suffer and have problems, and show them a good example of being my disciples. I will use you to bring salvation to many people.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:12 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>12</b> So the hearts of Mosiah's sons and the people that were with them were encouraged. They journeyed onward to the Lamanites to declare the word of God to them.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:13 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>13</b> When they arrived in the land of the Lamanites they went their separate ways, trusting in the Lord that they would meet again when they finished their work. They felt that it was a great work that they had decided to do.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:14 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>14</b> And it certainly was great. They had decided to preach the word of God to a wild, hardened, ferocious people—a people who loved to murder, rob, and plunder the Nephites. Their hearts were set on gold and silver, and on precious stones. They tried to get these things by murdering and stealing, so that they would not have to work with their own hands.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:15 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>15</b> They were a very lazy people, and many of them worshipped idols. God's curse had come upon them because of the traditions of their ancestors. But still, the Lord had promised them great things if they would repent.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:16 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>16</b> And this is why the sons of Mosiah had taken on this work. They wanted to help the Lamanites repent, and learn about the plan of redemption.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:17 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>17</b> So they went their separate ways and went out among the Lamanites with the word and power of God, every person on their own.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:18 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>18</b> Ammon was their leader; he was the one who had taken care of them. He left them after he had blessed each of them in their duties, and shared the word of God with them. And then they each journeyed into different parts of the land.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:19 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>19</b> Ammon went to the land of Ishmael. It was named after the sons of Ishmael, who also became Lamanites.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:20 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>20</b> When Ammon entered the land of Ishmael, the Lamanites captured him and tied him up. This is what they did to all the Nephites they captured: They carried them to their king, and it was up to the king to decide whether to kill them, or make them slaves, or throw them into prison, or throw them out of the land. The king did what he pleased with them.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:21 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>21</b> And so Ammon was carried to the king who was over the land of Ishmael. His name was Lamoni, and he was a descendant of Ishmael.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:22 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>22</b> The king asked Ammon if he wanted to live in the land of the Lamanites, among his people.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:23 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>23</b> Ammon said to him: &ldquo;Yes, I do want to live among this people for a while—maybe until the day I die.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:24 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>24</b> This pleased king Lamoni very much. He had the people untie Ammon, and he wanted Ammon to marry one of his daughters.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:25 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>25</b> But Ammon said to him: &ldquo;No, I will be your servant instead.&rdquo; So Ammon became one of king Lamoni's servants. He was put with the servants whose duty was to watch king Lamoni's flocks.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:26 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>26</b> One day, after he had been working for the king for three days, he was with the Lamanite servants as they went to water the flocks at the watering place, which was called the waters of Sebus.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:27 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>27</b> And as they were driving their flocks to the watering place, another group of Lamanites who had been there watering their flocks stood up and scattered the flocks of Ammon and the king's servants in every direction.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:28 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>28</b> The king's servants began to complain and worry. They said: &ldquo;Now the king is going to kill us, just like he did the other servants, because their flocks were scattered by these evil men.&rdquo; They began to cry bitterly and to say: &ldquo;Look, our flocks are already scattered!&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:29 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>29</b> They cried because they were afraid they would be killed. When Ammon saw this his heart swelled with joy &ldquo;because,&rdquo; he though to himself, &ldquo;now I can show the power that is in me to my fellow servants. I can gather the flocks of the king, and win the hearts of my fellow servants, and get them to believe my words.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:30 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>30</b> This is what Alma thought when he saw these servants that he called his brothers worrying and crying.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:31 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>31</b> So he comforted them with his words. He said: &ldquo;My brothers, take courage. Let us go look for the flocks, and gather them up and bring them back to the water. We will save the king's flocks, and he will not kill us.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:32 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>32</b> So they went searching for the flocks. They followed Ammon and rushed out to get ahead of the king's flocks, and brought them together again at the water.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:33 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>33</b> Those men came again to scatter their flocks, but Ammon said to his brothers: &ldquo;Surround the flocks so that they do not run away. I will go and defend us from these men who are trying to scatter them.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:34 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>34</b> So they did what Ammon said, and he went out to fight the men that were standing by the waters of Sebus. There were many of them. </font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:35 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>35</b> They were not afraid of Ammon. They thought that any of them could easily kill him, because they did not know that the Lord had promised Mosiah that he would save his sons from danger. They didn't know anything about the Lord. They loved to have bad things happen to their brothers; this is why they came to scatter the king's flocks.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:36 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>36</b> But Ammon came forward and began to throw stones at them with his sling. He threw the stones with power, and killed some of them. This greatly surprised them. Then they became angry because he had killed their friends and brothers, and now they were going to kill him. Since they could not hit him with their stones, they came toward him with clubs to kill him.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:37 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>37</b> But every time a man lifted a club to hit Ammon, Ammon cut that man's arm off with his sword. He stopped them from hitting them by cutting into their arms with his sword. This amazed them, and they started to run away from Ammon. Even though there were many of them, he made them run away because of his strength.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:38 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>38</b> Six of them had been killed by Ammon's sling, but the only person Ammon killed with his sword was their leader. And he cut off the arm of everyone who tried to hit him, and there were many of them.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 17:39 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>39</b> When he had driven them away, he went back and they watered the king's flocks. Then they brought them back to the king's pasture. They went to the king, carrying the arms that Ammon had cut off of those men who had tried to kill Ammon. They brought them to the king to show him evidence of what had happened.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <div dir="ltr" style="text-align: left;" trbidi="on">
# <a id="09_ALMA_18"><b><font size="5">Alma 18</font></b></a>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:1 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>1</b> King Lamoni made his servants come forward and tell everything that they had seen. </font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:2 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>2</b> They all testified about what they had seen, how Ammon had been faithful and preserved the king's flocks, and how he had great power when he fought with those who tried to kill him. This amazed the king, and he said: &ldquo;He is surely more than a man. Isn't he the Great Spirit who sends out punishment on this people, because they are murderers?&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:3 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>3</b> They answered the king, and said: &ldquo;We don't know whether he is a man or the Great Spirit. But we do know this: the king's enemies cannot kill him. They cannot scatter the king's flocks when he is with us because he is very strong, and an expert with his sword and sling. We know that he is a friend to the king. And, O king, we do not believe that a man can be so powerful, because we know he cannot be killed.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:4 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>4</b> When the king heard these words, he said to them: &ldquo;Now I know that it is the Great Spirit. He has come down to save your lives, so that I would not kill you like I did your brothers. This is the Great Spirit that our ancestors spoke about.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:5 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>5</b> This was the tradition that Lamoni believed. He had been taught by his parents that there is a Great Spirit. And even though they believed in a Great Spirit, they also believed that anything they did was right. But now Lamoni began to be very worried that he had done wrong by killing his servants.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:6 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>6</b> He had killed many of them because those men had scattered their flocks at the watering place. And because the flocks were scattered, they were killed.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:7 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>7</b> It was common among the Lamanites to stand by the waters of Sebus and scatter people's flocks. They did this to drive away flocks into their own land so that they could steal them.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:8 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>8</b> And king Lamoni asked his servants: &ldquo;Where is this man who has so much power?&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:9 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>9</b> They said to him: &ldquo;He is out feeding your horses.&rdquo; Now, before the servants had gone to water the flocks, the king had commanded them to get his horses and chariots ready so that they could take him to the land of Nephi. He was going there because his father, who was the king over all the land, had announced a great feast.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:10 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>10</b> And when king Lamoni heard that Ammon was preparing his horses and chariots, he was even more amazed by Ammon's faithfulness. He said: &ldquo;Among all my servants, there has never been one as faithful as this man. He remembers to do everything that I command.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:11 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>11</b> I am sure that this is the Great Spirit. I would like him to come in and speak with me, but I do not dare to ask.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:12 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>12</b> And after Ammon had gotten the horses and chariots ready for the king and his servants, he went to the king. He saw that the king's mood had changed, and he was about to leave.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:13 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>13</b> But one of the king's servants said to him, &ldquo;Rabbanah&rdquo; (which means &ldquo;powerful or great king&rdquo;; they considered their queens and kings to be powerful). He said, &ldquo;Rabbanah, the king wants you to stay.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:14 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>14</b> So Ammon turned to the king, and said to him: &ldquo;What would you like me to do for you, O king?&rdquo; But the king did not answer him for an hour, because he did not know what he should say to him.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:15 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>15</b> And Ammon said to him again: &ldquo;What can I do for you?&rdquo; But the king did not answer him.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:16 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>16</b> Ammon was filled with the Spirit of God, and he knew the king's thoughts. He said to him: &ldquo;Are you surprised because I defended your servants and flocks, and killed seven people with my sling and sword, and cut off the arms of the others?</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:17 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>17</b> What is it? Why are you so amazed? I am a man, and I am your servant. Anything you want me to do that is right, I will do it.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:18 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>18</b> Now when the king heard this, he was again amazed, because he could see that Alma knew his thoughts. But now king Lamoni did open his mouth. He said: &ldquo;Who are you? Are you the Great Spirit, who knows all things?&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:19 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>19</b> Ammon answered him and said: &ldquo;No, I am not.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:20 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>20</b> The king asked: &ldquo;How do you know my thoughts? You can speak boldly, and tell me these things. Also tell me how you had power to kill and cut the arms off my relatives who scattered my flocks.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:21 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>21</b> If you will tell me about these things, I will give you anything that you want. If it was needed I would guard you with my armies, but I know that you are more powerful than all of them. But tell me anything you want and I will give it to you.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:22 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>22</b> Ammon was wise, but also harmless, so he said to Lamoni: &ldquo;Will you listen to me and do what I ask, if I tell you how I had power to do these things? This is what I want from you.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:23 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>23</b> The king answered: &ldquo;Yes, I will believe all your words.&rdquo; So Alma tricked the king into believing his words.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:24 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>24</b> Ammon began to speak boldly to the king. He said: &ldquo;Do you believe that there is a God?&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:25 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>25</b> The king answered: &ldquo;I don't know what that means.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:26 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>26</b> Then Ammon said: &ldquo;Do you believe that there is a Great Spirit?&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:27 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>27</b> And the king said: &ldquo;Yes.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:28 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>28</b> Ammon said: &ldquo;This is God. Do you believe that this Great Spirit, who is God, created all things in heaven and on earth?&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:29 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>29</b> And the king said: &ldquo;Yes, I believe that the Great Spirit created all things that are on the earth, but I do not know what is in the heavens.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:30 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>30</b> And Ammon said to him: &ldquo;The heavens is a place where God and all of God's holy angels live.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:31 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>31</b> And king Lamoni asked: &ldquo;Is it above the earth?&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:32 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>32</b> Ammon said: &ldquo;Yes, and God looks down upon all of humankind, and God knows all of their thoughts and desires, because they were created by God's hand from the beginning.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:33 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>33</b> And king Lamoni said: &ldquo;I believe everything that you have said. Are you sent from God?&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:34 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>34</b> Ammon said to him: &ldquo;I am only a human. Humans were created in the beginning in God's image. And I am called by God's Holy Spirit to teach these things to this people, so that they can learn about what is right and true.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:35 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>35</b> And a part of God's Spirit lives in me. And the more I have faith in God and want to do what is right, the more that Spirit gives me knowledge, and also power.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:36 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>36</b> Now, when Ammon had said this, he started telling about the creation of the world and the creation of Eve and Adam. Ammon told the king everything about the fall of humankind. He quoted the records of the people and the holy scriptures, and showed them to the king. The scriptures had been spoken by the prophets, since the time that their mother and father, Sariah and Lehi, had left Jerusalem.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:37 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>37</b> Ammon also told the king and his servants about the travels of their ancestors in the wilderness, how they had suffered from hunger and thirst, and worked very hard, and so forth.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:38 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>38</b> He also told them about how Laman, Lemuel, and the daughters and sons of Ishmael, had rebelled against Sariah and Lehi. He explained to them all the records and scriptures that had been kept and written from the time Sariah and Lehi left Jerusalem down to the present time.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:39 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>39</b> But this is not all he did. He also explained to them the plan of redemption, which had been prepared since before the world existed. He also told them how Christ would come. He told them about all of the things that the Lord had done.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:40 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>40</b> And after he had finished telling all of these things, and explaining them to the king, the king believed what Ammon had said.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:41 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>41</b> And he began to cry out to the Lord, saying: &ldquo;O Lord, have mercy. Just as you have been very merciful to the people of Nephi, please be merciful to me and my people.&rdquo;</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:42 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>42</b> And when he had said this, he fell to the ground as if he were dead.</font>
# </div><div dir="ltr" style="text-align: left;" trbidi="on"><font><br /></font></div>
# <!-- Alma 18:43 -->
# <div dir="ltr" style="text-align: left;" trbidi="on">
#  <font><b>43</b> His servants took him and carried him to his wife, and laid him on a bed. He lay there as if he were dead for two days and two nights, and his wife, daughters, and sons cried over him and were very sad. This was the custom of the Lamanites, and they were very sad that he had died.</font>
