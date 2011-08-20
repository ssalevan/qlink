DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL auto_increment,
  `primary_ind` enum('Y','N') NOT NULL default 'Y',
  `staff_ind` enum('N','Y') NOT NULL default 'N',
  `user_id` int(11) NOT NULL default '0',
  `active` enum('N','Y') NOT NULL default 'N',
  `handle` char(10) NOT NULL default '',
  `create_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_access` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_update` datetime NOT NULL default '0000-00-00 00:00:00',
  `refresh` enum('N','Y') NOT NULL default 'N',
  PRIMARY KEY  (`account_id`),
  UNIQUE KEY `handle` (`handle`),
  KEY `user_id` (`user_id`),
  KEY `primary_ind` (`primary_ind`)
) TYPE=MyISAM AUTO_INCREMENT=863 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `articles`
-- 

DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `article_id` int(11) NOT NULL default '0',
  `next_id` int(11) NOT NULL default '0',
  `prev_id` int(11) NOT NULL default '0',
  `data` text,
  PRIMARY KEY  (`article_id`),
  KEY `next_id` (`next_id`,`prev_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `articles`
-- 

INSERT INTO `articles` VALUES (422994, 0, 0, ' THE ALL-NEW FUN GRAPHICS MACHINE!\n\n The new Fun Graphics Machine support\n area is making its debut here in the\n Graphics Support Group''s Messages and\n information section. The opening of\n this support area coincides withe the\n official introduction of V6.0 of this\n wonderful graphics manipulation,\n printing, and conversion utility for\n the C-64.\n\n This support area will now contain\n all of the program, documentation,\n utility and application files for the\n latest version of FGM that had been\n scattered amongst the Graphics Toolbox\n area files. Also included here is an\n FGM Support message board. Here''s the\n path to this new support area and a\n hint of what you''ll find there:\n\n Commodore Information Network\n  Computing Support Groups\n   Graphics\n    Messages and Information\n     The Fun Graphics Machine\n      About The Fun Graphics Machine\n      FGM Support Message Board\n      FGM Demos and Documentation\n      FGM Utilities & Applications\n      FGM User Created Applications\n\n And here is what you will find within:\n\n FGM SUPPORT MESSAGE BOARD: This\n section is the place where present\n and potential FGM users can find out\n the latest in what is new for the\n Fun Graphics Machine, and also to\n provide an area where you can find\n answers to questions or problems\n you might have encountered with FGM,\n and also to post any suggestions you\n might have for any improvements,\n additions, tips and tricks, or\n support files. RonH8 (Ron Hackley),\n the author and sole distributor of\n FGM, will be personally in charge of\n this board, so your questions or\n comments will be promptly answered!\n\n FGM SUPPORT LIBRARIES - This area\n actually consists of 3 separate\n sections, with each dealing with a\n different aspect of the FGM:\n\n FGM DEMOS AND DOCUMENTATION: This\n library contains the latest demo\n version of the Fun Graphics Machine\n (currently Version 6), along with\n complete documentation files, and\n any other support or upgrade files\n deemed helpful or necessary.\n\n FGM UTILITIES AND APPLICATIONS: This\n library contains files will add to\n the versatility and usefulness of\n FGM. These will be programs or other\n files that have either been created by\n RonH8 or officially approved by him.\n\n FGM USER CREATED APPLICATIONS: This\n library is the place to find or\n upload the latest in user-created\n applications, utilities, template\n and support files for the FGM.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (794811, 0, 0, ' THIS WEEK''S SPECIAL EVENTS\n\n Music Room Support Group conferences\n are held in PEOPLE CONNECTION''s Music\n chat. All other conferences held in\n the COMMODORE INFORMATION NETWORK''s\n Conference Center.\n\n NOTE: All events are Eastern time.\n\n-------------------------------------\n Friday, April 5\n\n 10:00 pm  General/Beginners'' Group -\n           Upgrading From C64?\n 11:59 pm  Late Night Programming\n           Forum (AUDITORIUM)\n--------------------------------------\n Saturday, April 6\n\n 9:00 pm   The Third Annual PIXIE\n           AWARDS! Come to the P³ople\n           Connection Auditorium and\n           see who will win 1990''s top\n           graphic arts awards!\n           (AUDITORIUM)\n 10:00 pm  Starving Artists'' Cafe -\n           Join the CIN Graphics Group\n           hosts in a toast to this\n           year''s Pixie Award winners\n           at our post-ceremony party!\n\n 11:59 pm  Game World Group - Late\n           Night Game Forum\n           (AUDITORIUM)\n--------------------------------------\n Sunday, April 7\n\n 9:00 pm  Graphics Group -\n          Supercharging GEOS: Learn\n          about exciting hardware and\n          software developments that\n          the People\n           Connection Auditorium and\n           see who will win 1990''s top\n           graphic arts awards!\n           (AUDITORIUM)\n 10:00 pm  Starving Artists'' Cafe -\n           Join the CIN Graphics Group\n           hosts in a toast to this\n           year''s Pixie Award winners\n           at our post-ceremony party!\n\n 11:59 pm  Game World Group - Late\n           Night Game Forum\n           (AUDITORIUM)\n--------------------------------------\n Sunday, April 7\n\n 9:00 pm  Graphics Group -\n          Supercharging GEOS: Learn\n          about exciting hardware and\n          software developments that\n          add powerful new features\n          and speed.\n--------------------------------------\n Monday, April 8\n\n 9:30 pm  Applications Group -\n          Favorite Word Processors\n--------------------------------------\n Wednesday, April 10\n\n 9:30 pm  CIN MUSIC ROOM-SIDFEST\n          MIAMI Planning - Ready for\n          June?\n--------------------------------------\n Thursday, April 11\n\n 9:30 pm  Game World Group - Bards\n          Tale Help Night\n 10:00 pm COMAL Conference - COMAL\n          News\n 11:00 pm Programmers'' Workshop -\n          Machine Language Workshop\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (818137, 0, 0, ' CIN REGULAR EVENTS SCHEDULE\n\n Music Room Support Group conferences\n are held in PEOPLE CONNECTION''s Music\n chat. All other conferences held in\n the COMMODORE INFORMATION NETWORK''s\n Conference Center.\n\n NOTE: All events are Eastern time.\n\n --------------------------------------\n EVERY NIGHT\n\n  7:00    MUSIC STUDIO\n  8:00    THE GAME ROOM\n  9:00    APPLICATIONS CHAT\n  9:00    BEGINNERS'' HELP ROOM\n  9:00    THE TELECOM CHAT/HELP ROOM\n 10:00    MUSIC HALL\n 10:00    STARVING ARTISTS'' CAFE\n 10:30    MUSIC STUDIO''S NAME THIS TUNE\n 11:00    MIDI STUDIO\n --------------------------------------\n FRIDAY\n\n  9:00    PROGRAMMING HELP ROOM\n 11:00    MUSIC STUDIO''s New this Week\n          The Latest SIDs\n --------------------------------------\n SATURDAY\n\n  9:00    PROGRAMMING HELP ROOM\n --------------------------------------\n SUNDAY\n\n  9:00    PROGRAMMING HELP ROOM\n --------------------------------------\n TUESDAY\n\n 10:00    CIN INFO ROOM\n          In People Connection public\n          room "CIN INFO"\n 11:00    MUSIC STUDIO''s New this Week\n          The Latest SIDs\n-­------------------------------------\n WEDNESDAY\n\n 10:00    CP/M HELP ROOM\n --------------------------------------\n THURSDAY\n\n 10:00    CIN INFO ROOM\n          In People Connection public\n          room "CIN INFO"\n --------------------------------------\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (0, 0, 0, 'Latest SIDs\n--------------------------------------\n WEDNESDAY\n\n 10:00    CP/M HELP ROOM\n --------------------------------------\n THURSDAY\n\n 10:00    CIN INFO ROOM\n          In People Connection public\n          room "CIN INFO"\n --------------------------------------\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (437948, 0, 0, 'NEW & IMPROVED OMEGA-Q!\r\n\r\n"Omega-Q," Q-Link''s ultimate utility program, has been redesigned and significantly improved to give you more control over the management of your disks than ever before! Introduced last month as part of "Discover CIN," the new "Omega-Q II" is as easy to use as Q-Link, and as powerful as a dozen other programs combined!\r\n\r\nThis downloadable program automatically dissolves ARC, Self-Dissolving ARC, Library, Lynx, Arkive and SID music files. "Omega-Q II" also lets you easily view and print text files, format disks, scratch/unscratch, lock/unlock, copy and boot files -- and much more!\r\n\r\nNew features include:\r\n\r\n* A greatly enhanced SEQ file reader that features word wrap and an option to ignore non-printable characters.\r\n\r\n* An improved SEQ file printer that rivals the best. Customize top, bottom, left and right margins, page length and width to tailor documents to your own printer and tastes. You can number pages and print one or two columns to a page.\r\n\r\n* The ability to read ASCII and format documents correctly.\r\n\r\n* "Hot keys" for all menus. Users familiar with "Omega-Q" just press the first letter of an option to select it!\r\n\r\n* A directory editor to completely reorder files on your disk. Alphabetize them, insert special separator lines, or quickly rename a file.\r\n\r\n* An F7 option for disk statistics.\r\n\r\n* The ability to dissolve multiple archives of any kind in one "batch."\r\n\r\n* The familiar Q-Link bell at the end of a dissolve batch, the ability to boot Q-Link directly, more customization menus, and lots of other extras!\r\n\r\nDownload the exciting, new version of "Omega-Q" in the "Omega-Q Center," located in CIN''s "Downloading Help" area.\r\n\r\nCopyright 1989 Quantum Computer Services, Inc.\r\n');
INSERT INTO `articles` VALUES (14001, 0, 0, ' ABOUT THE COMMODORE INFORMATION \r\n NETWORK \r\n\r\n The COMMODORE INFORMATION NETWORK \r\n offers a wide selection of Commodore- \r\n specific information and public \r\n domain software. This is the place to \r\n be if you want to explore how to get \r\n the most from your Commodore \r\n computer. \r\n\r\n To help bring people together to\r\n explore Commodore computing, CIN \r\n offers a variety of features such as \r\n the Computing and Hardware Support \r\n Groups and "News and Reference" as \r\n well as a host of other exciting \r\n areas. \r\n\r\n Come join us as we learn to expand \r\n our uses of Commodore computers into \r\n virtually every area of our lives. \r\n');
INSERT INTO `articles` VALUES (2291, 21557, 0, ' COMMODORE''S HEADQUARTERS \r\n\r\n * About Commodore''s Headquarters \r\n * News from Commodore \r\n * Questions and Answers \r\n * Product Information \r\n * Software From Commodore (+) \r\n * Service Centers \r\n * Commodore User Groups \r\n \r\n The Commodore''s Headquarters area, \r\n staffed by Commodore''s in-house \r\n telecommunications department, is \r\n your direct connection to Commodore. \r\n Each of the following seven areas \r\n will help you keep up-to-date on \r\n Commodore and Commodore computing. \r\n\r\n NEWS FROM COMMODORE \r\n\r\n This section brings you the latest \r\n press releases, show information and \r\n other news, direct from Commodore. \r\n\r\n QUESTIONS AND ANSWERS \r\n\r\n The "Questions and Answers" area \r\n provides direct support from \r\n Commodore. \r\n\r\n An expanded "Common Questions and \r\n Answers" section lists the answers to \r\n the most asked questions Commodore \r\n receives. The "Public Discussion \r\n Board" is used for general discussion \r\n with other Q-Link members allowing \r\n you to gain from the experience of \r\n others. \r\n');
INSERT INTO `articles` VALUES (21557, 0, 2291, ' The "Commodore''s Private \r\n Hotlines" section will get you an \r\n answer directly from Commodore, via \r\n E-mail, generally within two business \r\n days. \r\n\r\n PRODUCT INFORMATION \r\n\r\n To provide you with an easy way to \r\n compare current Commodore products, \r\n the "Product Information" area lists \r\n the specifications of Commodore''s \r\n most popular products. \r\n\r\n SOFTWARE FROM COMMODORE \r\n\r\n This area not only contains the \r\n C64/128 public domain educational \r\n software, but also the latest \r\n versions of utilities from \r\n Commodore''s engineers. \r\n\r\n SERVICE CENTERS \r\n\r\n The "Service Center Listings" section \r\n contains the complete list of all \r\n Commodore authorized service centers \r\n in the U.S. \r\n\r\n COMMODORE USER GROUPS\r\n \r\n The "Commodore User Groups" section \r\n contains alphabetical listings of  U.S. \r\n and Canadian Commodore User  Groups, \r\n arranged by order of state  or privince.\r\n');
INSERT INTO `articles` VALUES (449925, 0, 0, ' CONFERENCE CENTER\r\n\r\n ABOUT THE CONFERENCE CENTER\r\n\r\n The Conference Center is the location\r\n for all the conferences, formal and\r\n informal, held by groups within the\r\n COMMODORE INFORMATION NETWORK. The\r\n conference rooms located here are the\r\n same ones located in each individual\r\n support group, they are grouped\r\n together here for your convenience.\r\n\r\n NOTE: All times are listed in Eastern\r\n Time.\r\n\r\n The Conference Center has four\r\n areas:\r\n\r\n * Schedule of Conference Events\r\n * General/Beginners'' Group\r\n * Computing Support Conferences\r\n * Hardware Support Conferences\r\n\r\n SCHEDULE OF CONFERENCE EVENTS\r\n\r\n This area contains the complete\r\n schedule of the formal conferences.\r\n It contains the day, times and topic\r\n for each regularly scheduled\r\n conference held. You can also find\r\n the schedule of conferences in the\r\n Monthly UPDATE calendar.\r\n\r\n GENERAL/BEGINNERS'' GROUP\r\n\r\n This area contains the informal help\r\n room for the Beginners'' Group which\r\n meets  Sunday thru Thursday between 9\r\n p.m. and 11 p.m. and Saturdays\r\n between 9 p.m. and 1 a.m.  They also\r\n hold a weekly formal conference on\r\n Friday at 10 p.m.  Drop by if you\r\n have questions or just want to chat.\r\n\r\n COMPUTING SUPPORT CONFERENCES\r\n\r\n This area contains the conference\r\n rooms, both formal and informal, for\r\n the following Support Groups:\r\n\r\n     * Applications\r\n     * CP/M\r\n     * Graphics\r\n     * Games World\r\n     * Programmers'' Workshop\r\n     * Telecommunications\r\n\r\n HARDWARE SUPPORT CONFERENCES\r\n\r\n This area contains the conference\r\n rooms, both formal and informal, for\r\n the following Support Groups:\r\n\r\n     * C64 Hardware Support\r\n     * C128 Support\r\n     * Amiga Alliance\r\n     * PC/MS-Dos Support\r\n');
INSERT INTO `articles` VALUES (523003, 491789, 0, ' ABOUT THE SUPPORT GROUPS \r\n\r\n The CIN Support Groups are dedicated \r\n to all those people who own, use or \r\n are interested in Commodore \r\n computing. \r\n\r\n The "Computing Support Groups" \r\n specialize in specific areas of \r\n interest to Commodore enthusiasts \r\n while the "Hardware Support Groups" \r\n are more oriented towards seeing what \r\n the computers themselves can do and \r\n getting into the hardware of the \r\n systems. \r\n\r\n While each Support Group grows and \r\n changes to meet the needs of their \r\n members you''ll find several standard \r\n features in each group. \r\n\r\n NEWS AND EVENTS \r\n\r\n This area allows you to keep on top \r\n of the current news and events of the \r\n group. Included here is a schedule of \r\n the current month''s group \r\n conferences. \r\n\r\n MESSAGE BOARDS \r\n\r\n The message boards in each group is \r\n where Q-Link members can read and \r\n post messages. Many people find these \r\n extremely helpful in keeping up to \r\n date on the latest information  as \r\n well as getting help on that vexing \r\n problem. \r\n\r\n ARTICLES \r\n\r\n The articles section contains \r\n magazine-type articles dealing with a \r\n variety of topics. The SysOps write \r\n many of the articles, but feel free \r\n to contact the SysOp to see how YOUR \r\n article might be added to the area. \r\n\r\n SOFTWARE LIBRARIES \r\n\r\n This area is probably one of the most \r\n popular areas in each group. The area \r\n contains each group''s portion of the \r\n COMMODORE INFORMATION NETWORK''s \r\n Software Libraries. These libraries \r\n are one of the largest collections of \r\n public domain software available. \r\n\r\n ABOUT THE GROUP \r\n\r\n Here you can find specific \r\n information about each group and its \r\n SysOps. There is also an area where \r\n you can join the group. While the \r\n groups are open to everyone, the \r\n registered members often have a \r\n chance to receive special notices of \r\n upcoming events. \r\n\r\n LIBRARY HIGHLIGHTS \r\n\r\n This area has highlights of the \r\n group''s software libraries including \r\n downloadable listings of recent \r\n additions and lists of files which \r\n are recommended by the SysOps. \r\n');
INSERT INTO `articles` VALUES (491789, 0, 523003, ' WORKSHOP \r\n\r\n Several of the groups also have \r\n special workshop areas which provide \r\n a place to get help with your current \r\n projects as well as provide the group \r\n with an area where the members can \r\n start a group-wide project. \r\n');
INSERT INTO `articles` VALUES (523017, 461539, 0, ' THE COMPUTING SUPPORT GROUPS \r\n\r\n * General/Beginners Group \r\n * Aplications Group \r\n * CP/M \r\n * Graphics Group \r\n * Game World \r\n * Music Room \r\n * Programmers'' Workshop \r\n * Telecommunications \r\n\r\n\r\n GENERAL/BEGINNERS'' GROUP \r\n\r\n The "General/Beginners''" Group \r\n dedicates itself to helping people \r\n get started in Commodore computing. \r\n Hosted by QDL Laura and QDL Robert.\r\n\r\n APPLICATIONS GROUP \r\n\r\n The Applications Group explores ways \r\n to make your C64 or C128 work for \r\n you, whether it''s through word \r\n processing or balancing a check book, \r\n cataloging recipes or using spread \r\n sheets. \r\n\r\n CP/M \r\n\r\n The CP/M Group explores the world of \r\n CP/M on Commodore computers. This \r\n older operating system still demands \r\n respect and provides Commodore \r\n owners, specifically C128 owners, \r\n with a wealth of new opportunities to \r\n explore. \r\n\r\n GRAPHICS GROUP \r\n\r\n Creative talents gather in the \r\n Graphics Group to show everyone how \r\n to have fun with computer graphics. \r\n Animation, still life and other \r\n computer art is not only enjoyable \r\n but easy when you know the tricks you \r\n can learn here. \r\n\r\n GAME WORLD \r\n\r\n Many people first became interested \r\n in computers because the computers \r\n games were so much fun and so \r\n intriguing; they still are! The \r\n members of the Game World Group \r\n discuss and help each other with C64 \r\n and C128 games. \r\n\r\n MUSIC ROOM \r\n\r\n Whether it is music generated by the \r\n C64 or C128, or hooking up the \r\n computers to MIDIs, the Music Room \r\n Group is where you can learn all \r\n about computers and music. \r\n');
INSERT INTO `articles` VALUES (461539, 0, 523017, ' PROGRAMMERS'' WORKSHOP \r\n\r\n The Programmers'' Workshop Group is \r\n the place for C64 and C128 \r\n programmers to get help, explore new \r\n languages, and give and receive \r\n encouragement on that latest \r\n programming project. \r\n\r\n The Programmers'' Workshop is also the \r\n proud sponsor of the "COMAL TODAY" \r\n area. COMAL is one of the few Public \r\n Domain programming languages in the \r\n United States. "COMAL Today", hosted \r\n by Len Linsey, covers this exciting \r\n programming language from top to \r\n bottom. \r\n\r\n TELECOMMUNICATIONS \r\n\r\n Everyone here knows how much a modem \r\n adds to the the utility and fun of a \r\n computer. In the Telecommunications \r\n Group, you''ll find even more to do \r\n and more to enjoy, in this dawning \r\n age of telecommunications. \r\n');
INSERT INTO `articles` VALUES (443059, 0, 0, ' THE HARDWARE SUPPORT GROUPS\r\n\r\n * C-64\r\n * C-128 By Twin Cities 128\r\n * Amiga Alliance\r\n * PC/MS-DOS\r\n\r\n C-64\r\n\r\n The C-64 Support Group explores the\r\n C-64, how it works, and what types of\r\n hardware you can use with it.  They\r\n can provide a wealth of help in\r\n hooking up your new printer or trying\r\n to debug that custom interface you\r\n just built.\r\n\r\n C-128 BY TWIN CITIES 128\r\n\r\n Twin Cities 128 magazine provides 128\r\n owners across the U.S with hard-core\r\n help, information and news about the\r\n Commodore 128 computer.  By bringing\r\n their expertise online they represent\r\n one of the fastest growing resources\r\n available for the C-128.\r\n\r\n AMIGA ALLIANCE\r\n\r\n The Amiga line of computers is\r\n quickly gaining favor around the\r\n world.  The Amiga Alliance Group\r\n provides you with the opportunity to\r\n learn about these computers and to\r\n keep abreast of current information.\r\n It''s a fast paced Group for a fast\r\n paced computer.\r\n\r\n PC/MS-DOS\r\n\r\n With Commodore emergence into the\r\n world of MS-DOS with their PC-10/20,\r\n Colt and other new MS-DOS computers,\r\n the PC/MS-DOS group is now getting\r\n more attention than ever.  Let this\r\n group help show you how easy MS-DOS\r\n can really be.\r\n');
INSERT INTO `articles` VALUES (484758, 481595, 0, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 1 of 12       03/17/91\r\n\r\n General/Beginners'' Group\r\n (QDL Laura / QDL Tom)\r\n    About This Group\r\n       Welcome!\r\n       Members'' Guide to This Group\r\n       Meet the Staff\r\n       Join the Group!\r\n       Suggestion Box\r\n    News and Events\r\n       What''s New\r\n       Sysops'' Newswire\r\n       Conference Schedule\r\n       About the Month''s Events\r\n       Beginners'' Help Room Schedule\r\n    Beginners'' Resource Center\r\n       Welcome!\r\n       You''re the Master\r\n       What Can I Do With My Comp.?\r\n       Where to Find Help\r\n       The Most Asked Questions\r\n       Books for Beginners\r\n       Software Reviews\r\n       Computing Term. Dictionary\r\n    Messages and Articles\r\n       Announcements and General\r\n       Questions and Answers\r\n       Introduce Yourself!\r\n       Tips and Tricks\r\n       Computing Issues Debate Forum\r\n       General Articles\r\n    Software Libraries\r\n       C128 Software\r\n          Useful Programs\r\n          Text And Information\r\n       Conference Archives\r\n       Q-Link Information and Tips\r\n       General Help Files\r\n       Other Text Files\r\n       Useful Utilities\r\n       Tutorial Programs\r\n       Miscellaneous Programs\r\n    Beginners'' Help Room\r\n       Beginners'' Help Room\r\n       Formal Conference Room\r\n    Omega-Q Support Center\r\n       What is Omega-Q?\r\n       About Omega-Q 2.1\r\n       How to Use Omega-Q\r\n       NEW: Download Omega-Q 2.1\r\n       Common Questions and Answers\r\n       Questions and Comment Board\r\n       Omega-Q Support Library\r\n');
INSERT INTO `articles` VALUES (481595, 481599, 484758, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 2 of 12       03/17/91\r\n\r\n General/Beginners'' Group (Cont.)\r\n    Special Features and Events\r\n       Computing Issues Debate Forum\r\n          About This Area\r\n          This Weeks''s Topic\r\n          Post YOUR Views!\r\n          Previous Poll Results\r\n       Downloading Crash Course\r\n          What is Downloading?\r\n          About the Crash Course\r\n          Class Schedule\r\n          News Message Board\r\n          Your First Download\r\n          The Classroom\r\n\r\n Applications\r\n (SYSOP DM / SYSHELP TJ)\r\n    About this Group\r\n       Welcome\r\n       About The Group\r\n       Meet The Staff\r\n       Join The Group\r\n    News and Events\r\n       What''s New\r\n       The Appliations Newswire\r\n       Conference Schedule\r\n    Messages and Articles\r\n       C64  Home and Business\r\n       C128 Home and Business\r\n       Program Request Boards\r\n       The Suggestion Box\r\n       ARTICLES\r\n    Conference and Chat Rooms\r\n       Schedule\r\n       User Friendly Cafe\r\n       Formal Conferences\r\n    Software Libraries\r\n       C-128 Software\r\n          Database Managers\r\n          Directory & File Utilities\r\n          Other Disk Utilities\r\n          Educational Programs\r\n          Financial Management\r\n          Word Processing/File Readers\r\n          Other\r\n       Home\r\n       Business\r\n       Word Processing\r\n       File Utilities\r\n       Disk Utilities\r\n       Text and Information\r\n');
INSERT INTO `articles` VALUES (481599, 495363, 481595, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 3 of 12       03/17/91\r\n\r\n Applications (Cont.)\r\n    Library Highlights\r\n       About The Libraries\r\n       Uploading Files\r\n       C64  Applications File Search\r\n       C128 Applications File Search\r\n       All Time Top Downloads\r\n       New This Week\r\n       Weekly Upload Guides\r\n\r\n CP/M\r\n (SYSOP GES)\r\n    Message Boards and Articles\r\n       Answers to Common Questions\r\n       CP/M 3.0\r\n       CP/M 2.2\r\n       Suggestion Box\r\n       ARTICLES\r\n    Conference and Class Rooms\r\n       Formal Conference Room\r\n    Software Libraries\r\n       Starter Files\r\n       Utilities\r\n       Word Star and Text Editors\r\n       Database & Spreadsheet\r\n       Telecommunications\r\n       Languages\r\n       Games\r\n       Information Files\r\n       CP/M Archives\r\n    CP/M File Search\r\n       Search ALL Files\r\n       Search Files New This Week\r\n       Search Files New This Month\r\n    About the Libraries\r\n    CP/M Workshop\r\n       About the CP/M Workshop\r\n       Workshop Message Board\r\n       Workshop Library\r\n    About the CP/M Group\r\n       Welcome to the CP/M Group\r\n       About the CP/M Group\r\n       Meet the Staff\r\n       Join the Group\r\n');
INSERT INTO `articles` VALUES (495363, 524075, 481599, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 4 of 12       03/17/91\r\n\r\n Graphics\r\n (SYSOP PH / SYSOP WP)\r\n (SYSHELP KW / SYSHELP RS)\r\n    Third Annual Pixie Awards\r\n       About the Pixie Awards\r\n       How to Cast Your Vote\r\n       Nominations Voting Booth\r\n    About the Group\r\n       Welcome to the Graphics Group\r\n       About the Graphics Group\r\n       Meet the Staff\r\n       Join the Group\r\n    News and Events\r\n       Graphics What''s New\r\n       Graphics SysOps'' Newswire\r\n       Conference Schedule\r\n       Auditorium/Special Events\r\n    Messages and Information\r\n       General Annoncements/Chat\r\n       C-64 Graphics Help\r\n       C-128 Graphics Help\r\n       Graphics Tips and Tricks\r\n       Starving Artist Cafe Happen''gs\r\n       The Most Often Asked Questions\r\n       Graphics Articles & Reviews\r\n    Conference and Chat Rooms\r\n       (Month) Conference & Cafe Sch.\r\n       (Month) Auditorium / Events\r\n       Starving Artist''s Cafe\r\n       Formal Conferences\r\n    Software Libraries (C-64)\r\n       Works of The Masters\r\n       Masterpiece Gallery\r\n       Picture Perfect\r\n       Cartoons & Comics\r\n          T.H.E. Fox Cartoon\r\n       Digital Darkroom\r\n       Animation\r\n       Printer Clip Art\r\n       Other Printer Art/Collections\r\n       Graphics Toolbox\r\n    Software Libraries (C-128)\r\n       40 Column\r\n       80 Column\r\n       Ultra Hi-Res Graphics (80 Col.)\r\n       BASIC 8 Files\r\n    Library Highlights & Search\r\n       About The Libraries\r\n       Uploading Guidelines\r\n       C64  Graphics File Search\r\n       C128 Graphics File Search\r\n       All Time Top Downloads\r\n       New This Week\r\n       Uploader Spotlights\r\n       Weekly Upload Guides\r\n');
INSERT INTO `articles` VALUES (524075, 517460, 495363, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 5 of 12       03/17/91\r\n\r\n Game World\r\n (SYSOP SR / SYSOP RF / SYSHELP ME)\r\n    About Game World\r\n       Welcome\r\n       About The Group\r\n       Meet The Staff\r\n       Join The Group\r\n    News And Events\r\n       What''s New\r\n       Holiday Newswire!\r\n       Conference Schedule\r\n    Messages\r\n       The Game Board\r\n       C-64 Games\r\n       C-128 Games\r\n       Public Domain\r\n       The Review Board\r\n       Game Help Guild\r\n          General Hints\r\n          Bard''s Tale Series Help/Hint\r\n          InfoCom Help & Hints\r\n          SSI AD&D Games Help/Hints\r\n          Ultima Series Help/Hints\r\n          Dragon Wars/Neuromancer Brd\r\n          Simulations Help/Hints Board\r\n    Conference and Chat Rooms\r\n       Current Schedule\r\n       The Game Room\r\n       Formal Conference\r\n    Articles\r\n       General Articles\r\n       For the Beginner\r\n       Game Reviews\r\n       Help and Hints\r\n    Software Libraries\r\n       C-128 Software\r\n          Games\r\n          Lottery\r\n          Trivia\r\n          Adventure\r\n          Adventure Utilities\r\n       Arcade\r\n       Adventure\r\n       Word and Number\r\n       Card and Chance\r\n       Game Utilities\r\n       Commercial Game Aids\r\n       Stuff and Nonsense\r\n       Text and Information\r\n');
INSERT INTO `articles` VALUES (517460, 491252, 524075, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 6 of 12       03/17/91\r\n\r\n Game World (Cont.)\r\n    Library Highlights\r\n       About The Libraries\r\n       Uploading Files\r\n       C64  Games File Search\r\n       C128 Games File Search\r\n       All Time Top Downloads\r\n       New This Week\r\n       Weekly Upload Guides\r\n\r\n Music Room\r\n (SYSOP JON / SYSOP SIDs / SYSHELP JG)\r\n (SYSOP MIDI / SYSOP Keys)\r\n    Music Room News\r\n       What''s New\r\n       Conference Schedule\r\n    1990 SAMMy Awards\r\n       ** SAMMy Winners for 1990 **\r\n       SAMMy Award Nominations\r\n       SAMMy Voting Booth\r\n    SID Music Room\r\n       About the SID Music Room\r\n       SID Messages and Articles\r\n       Library Spotlight\r\n       SID Archives\r\n       SID to MIDI Library\r\n       About the SID/General Libraries\r\n    MIDI Music Room\r\n       About the MIDI Music Room\r\n       MIDI Music Room News\r\n       Messages and Articles\r\n       MIDI Hotline\r\n       SID to MIDI Library\r\n       Library Spotlight\r\n       Musician Matchmaker\r\n       Electronic MIDI Projects\r\n    SUPER-Q Music Support Center\r\n       Introducing Super Q\r\n       What Super-Q Can Do For You\r\n       Download Super Q\r\n       About SID Player\r\n       Common Questions\r\n       Download the SID Player\r\n       Music Hall and Studio Schedules\r\n       Music Hall and Studio Grafitti\r\n       Ask Mr/Ms Music & Music SysOps\r\n    SID Music Libraries\r\n       POP Pre 50''s - 60''s\r\n       POP 70''s\r\n       POP 80''s and 90''s\r\n       Rock, Country, Rag and Jazz\r\n       Classical\r\n       Holiday, Religious, Patriotic\r\n');
INSERT INTO `articles` VALUES (491252, 485368, 517460, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 7 of 12       03/17/91\r\n\r\n Music Room (Cont.)\r\n    SID Music Libraries (Cont.)\r\n       Movie, TV\r\n       Shows, Albums, Sounds\r\n       Original, Novelty, Utilities\r\n    MIDI, General & C128 Libraries\r\n       C-128 Music Libraries\r\n          Music and Sound\r\n          Music and Sound Utilities\r\n          MIDI Librarians & Utilities\r\n          MIDI Sequence Files - Dr T.\r\n          MIDI Sequence Files - Sonus\r\n       Master Composer Files\r\n       Other Commercial Program Files\r\n       Original Format\r\n       Music Utilities\r\n       MIDI Librarians and Utilities\r\n       MIDI Keyboard Patches\r\n       MIDI Patches -FM/Digital Synths\r\n       MIDI Players and Sequences\r\n    Music Library Search\r\n       C64 & SID Music Search\r\n       C64 MIDI File Search\r\n       C128 Music File Search\r\n       C128 MIDI File Search\r\n\r\n Programmers'' Workshop\r\n (SYSOP JL / SYSHELP SE)\r\n    About this Group\r\n       Welcome\r\n       About The Programmers'' Workshop\r\n       About COMAL Today\r\n       Meet The Staff\r\n       Join The Group\r\n    News And Events\r\n       What''s Ne·?	"?Ñ?ý???Í=Á???r?ÝÍÝ¥É??j"?Ñ?ý??5¡??Õ±??z??*Ù?¹ÑÍ?jj½¹Ñ¡ý?g\r\n       Other Languages\r\n       Programming Request Boards\r\n       Applications Request Board\r\n       ARTICLES\r\n    Monthly Programming Challenge\r\n       About The Challenge and Prizes\r\n       General Rules and Information\r\n       (Month) Challenge\r\n       Previous Challenge Winners\r\n');
INSERT INTO `articles` VALUES (485368, 498325, 491252, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 8 of 12       03/17/91\r\n\r\n Programmers'' Workshop (Cont.)\r\n    Software Libraries\r\n       C-128 Software\r\n          Starter Kit\r\n          Machine Language\r\n          Programming Utilities\r\n          M/L Sub-Routines Source\r\n          Demos and Other Utilities\r\n       C-64 Starter Kit\r\n       BASIC\r\n       FORTH\r\n       C\r\n       PASCAL\r\n       65xx\r\n       Other Languages\r\n       Odds And Ends\r\n       Conference Topics and Notes\r\n    Library Highlights\r\n       About The Libraries\r\n       How to Upload\r\n       C64  Programming File Search\r\n       C128 Programming File Search\r\n       All Time Top Downloads\r\n       New This Week\r\n       Uploader Spotlight A - K\r\n       Uploader Spotlight L - Z\r\n       Weekly Upload Guides\r\n    Workshop and HELP Room\r\n       About the Workshop\r\n       Messages\r\n       Workshop Libraries\r\n       Beta Test Center\r\n       Programming HELP Room\r\n       Formal Conference Room\r\n    COMAL\r\n    (Captain C)\r\n       About COMAL Today\r\n       Message Board and Libraries\r\n          Q & A Message Board\r\n          COMAL 0.14\r\n          COMAL 2.0\r\n       COMAL Conference Room\r\n\r\n Telecommunications\r\n (SYSOP JC / SYSOP CJ)\r\n    About this Group\r\n       Welcome\r\n       About the Group\r\n       Meet the Staff\r\n       Join the Group\r\n');
INSERT INTO `articles` VALUES (498325, 523955, 485368, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 9 of 12       03/17/91\r\n\r\n Telecommunications (Cont.)\r\n    News and Events\r\n       What''s New\r\n       Group Conference Schedule\r\n       BBS SysOp''s Conference Sch.\r\n    BBS List and Member Survey\r\n       Member Verified BBS Lists\r\n       Add to Q-Link''s BBS List\r\n       About the Member Survey\r\n       General Member Survey\r\n    Messages\r\n       General\r\n       C-64 Software/Hardware\r\n       C-128 Software/Hardware\r\n       BBS (Bulletin Board Systems)\r\n          Image BBS Board\r\n          BBS Listings\r\n          BBS SysOps Forum\r\n    Articles\r\n       Article Information\r\n       General Telecommunications Info\r\n       General BBS Information\r\n       File Transfer Info & Utilities\r\n       Common Question\r\n    Software Libraries\r\n       C-128 Software\r\n          80-Column Terminal\r\n          40-Column Terminal\r\n          40/80-Column Terminal\r\n          Protocol ML Source\r\n          Protocol Source Code\r\n          BBS Programs\r\n          C-Net BBS Modification\r\n          Utilities\r\n          Miscellaneous Telecom Files\r\n       BBS Programs & Files\r\n       BBS Program Modules\r\n       Terminal Programs\r\n       Protocol ML Source\r\n       Other Files\r\n       Telecom Utilities\r\n       Text and Information\r\n    Library Highlights\r\n       About the Libraries\r\n       Uploading Files\r\n       C64  Telecom File Search\r\n       C128 Telecom File Search\r\n       All Time Top Downloads\r\n       New This Week\r\n       Weekly Upload Guides\r\n    Help/Chat & Conference Rooms\r\n       Schedule\r\n       The Telecom Help/Chat Room\r\n       Formal Conferences\r\n');
INSERT INTO `articles` VALUES (523955, 521007, 498325, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 10 of 12      03/17/91\r\n\r\n (For all Hardware Support Groups )\r\n (SYSOP LL / SYSOP BJH / FE Hudson)\r\n\r\n C64 Group\r\n    About the C64 Group\r\n       Welcome\r\n       About The C-64 Hardware Group\r\n       Meet The Staff\r\n       Join The Group\r\n    News and Events\r\n       What''s New\r\n       Conference Schedule\r\n    C64 Hardware Message Board\r\n    Conference Room\r\n    Articles\r\n       (list of articles)\r\n    C64 Hardware Support Library\r\n    C64 Hardware File Search\r\n\r\n C128 By Twin Cities 128\r\n    About the Twin Cities 128 Group\r\n       About the Twin Cities 128 Group\r\n       What is Twin Cities 128\r\n       How to Subscribe to TC-128\r\n       Meet Loren Lovhaug\r\n       How to get C-128 Help\r\n    Articles, Excerpts and Updates\r\n       (list of articles)\r\n    Slick Tips\r\n       (list of articles)\r\n    Message Boards\r\n       General Discussions\r\n       News & Information\r\n       Help Key Messages\r\n       Online Rumor/Opinion/Mayhem\r\n    Twin Cities 128 Specials Lib.\r\n       Lovhaug''s Specials\r\n       IPaint Support Files\r\n\r\n Amiga Alliance\r\n    About this Group\r\n       Welcome\r\n       About The Amiga Alliance\r\n       Meet SYSOP JAY\r\n       Join the Group\r\n    Messages and Articles\r\n       General\r\n       Software\r\n       Hardware\r\n       ARTICLES\r\n    Conference Room\r\n');
INSERT INTO `articles` VALUES (521007, 486373, 523955, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 11 of 12      03/17/91\r\n\r\n Amiga Alliance (Cont.)\r\n    Software Libraries\r\n       ASCII Text\r\n       BASIC Programs\r\n       CLI and WorkBench\r\n       Fun and Games\r\n       Graphics\r\n       Music\r\n       Programming\r\n       Telecommunications\r\n       Official C= Amiga Updates\r\n    Library Highlights\r\n       About The Libraries\r\n       Uploading Files\r\n       Amiga File Search\r\n       All Time Top Downloads\r\n       Best Of The Old Files\r\n       New This Week\r\n       Weekly Upload Guides\r\n       About The Guides\r\n    Workshop\r\n       Amiga <==> 64/128 Fast!\r\n       Programming The Amiga\r\n\r\n PC/MS-DOS\r\n    What''s New\r\n       What''s New\r\n       Conference Schedule\r\n    MS-DOS News Corner\r\n       (list of articles)\r\n    Message Board\r\n    Information Center Articles\r\n       (list of articles)\r\n    Conference Room\r\n    Software Libraries\r\n       Recommended Utilities\r\n       General MS-DOS Utilities\r\n       General Applications\r\n       Business Applications\r\n       Programming Utilities\r\n       Games And Entertainment\r\n       Telecommunications\r\n       Information/Text Files\r\n       Graphics And Sound\r\n    About the Group\r\n       About the Group\r\n       Meet the SysOp\r\n       Join the Group\r\n');
INSERT INTO `articles` VALUES (486373, 0, 521007, ' COMPUTING/HARDWARE SUPPORT GROUPS\r\n\r\n Page 12 of 12      03/17/91\r\n\r\n Hardware Company Support Area\r\n    About this Area\r\n    Xetec\r\n    (Xetec1)\r\n       Meet Xetec\r\n       Xetec Message Board\r\n       Product Information\r\n       Xetec Utility Library\r\n    Creative Micro Designs\r\n    (CMD)\r\n       Meet CMD\r\n       CMD Product Information\r\n       CMD Support and Messages\r\n       CMD Support Library\r\n       Dr Evil Product Support\r\n       (Dr Evil)\r\n          Meet Dr. Evil\r\n          Dr. Evil Products\r\n          Ordering Information\r\n          Support and Messages\r\n          Support Library\r\n    Aprotek\r\n    (APROTEK)\r\n       Meet Aprotek\r\n       Aprotek Message Board\r\n       Product Information\r\n       Aprotek Utilities\r\n    Schnedler Systems\r\n    (SSchnedler)\r\n       Meet Schnedler Systems\r\n       Product Information\r\n       Ordering Information\r\n       Support and Messages\r\n       Utility Library\r\n    Dr. Evil Labs\r\n       (see Creative Micro Designs)\r\n\r\n Hardware Conference Center\r\n    Enter the Conference Room\r\n       (1st & 3rd Tue 10:00 pm)\r\n    Conference Schedule\r\n');
INSERT INTO `articles` VALUES (523031, 0, 0, ' ABOUT THE CIN SYSOPS\r\n\r\n The SysOps (System Operators) are\r\n part of Q-Link''s remote staff, and\r\n are responsible for the operation of\r\n the individual Support Groups. They\r\n generally assure that everything in\r\n the group, such as message boards and\r\n software libraries, is properly\r\n maintained.\r\n\r\n If you have a question about\r\n computing and don''t know which group\r\n would handle it, just select\r\n "Hardware Support Groups" or\r\n "Software Support Groups" from the\r\n prior menu to get information on all\r\n the groups available.\r\n\r\n Each group has a weekly conference,\r\n given by a SysOp, on a variety of\r\n topics. All of the meetings are held\r\n in the CIN "Conference Center".\r\n You''ll also find a complete list of\r\n each months conference in the\r\n "TONIGHT!" area of CIN.\r\n\r\n The SysOps are knowledgeable and\r\n genuinely enjoy helping members learn\r\n about computing.  So feel free to use\r\n the message boards and attend the\r\n conferences. They will welcome you\r\n and the opportunity to assist you.\r\n');
INSERT INTO `articles` VALUES (424726, 0, 0, ' NEWS AND REFERENCE\r\n\r\n * USA Today Technology News\r\n * New Product Information\r\n * Baker''s "Inside Q-Link"\r\n * Gutman on Computers\r\n * Run''s Magic Archives\r\n * Newsbytes\r\n * Networker''s Journal\r\n\r\n USA TODAY TECHNOLOGY NEWS\r\n\r\n The Technology News sections gives\r\n you an overview of USA Today''s top\r\n technology news.\r\n\r\n NEW PRODUCT INFORMATION\r\n\r\n The New Product Information message\r\n boards contain the latest information\r\n on software, hardware, accessories\r\n and industry news concerning the\r\n Commodore systems -- especially the\r\n C64, C128 and Amiga -- and now the\r\n PC10/IBM clones.\r\n\r\n BAKER''S "INSIDE Q-LINK"\r\n\r\n This area contains reprints of Robert\r\n Baker''s popular "Inside Q-Link"\r\n column from Commodore Magazine.\r\n Included among his articles are hints\r\n and tips on getting the most from\r\n your Q-Link membership.\r\n\r\n GUTMAN ON COMPUTERS\r\n\r\n "Gutman on Comuters" contains columns\r\n written by syndicated columnist Dan\r\n Gutman. New columns, which deal with\r\n interesting things you can do with\r\n your computer, are added weekly.\r\n\r\n RUN''S MAGIC ARCHIVES\r\n\r\n Collected from the best of the RUN\r\n MAGIC column in RUN magazine, the\r\n Magic Archives  are an invaluable\r\n collection of hints and tips that\r\n will help you get the most out of\r\n your computing experience.\r\n\r\n NEWSBYTES\r\n\r\n Newsbytes has 4 U.S. and 7\r\n international bureaus in London,\r\n Brussels, Toronto, Tokyo, Singapore,\r\n Malaysia, and Sydney, Australia,\r\n devoted to gathering the week''s most\r\n significant microcomputer and\r\n consumer technology news.\r\n\r\n NETWORKER''S JOURNAL\r\n\r\n The Networker''s Journal is published\r\n weekly by telecommunications expert\r\n Charlie Bowen. The journal is updated\r\n every Friday.\r\n');
INSERT INTO `articles` VALUES (509226, 0, 0, ' ABOUT THE SEARCH SYSTEM\r\n\r\n The library search system allows you\r\n to search all the files in a given set\r\n of software libraries. This gives you\r\n the ability to quickly locate specific\r\n files from the over 30,000 files\r\n available.\r\n\r\n With the Q-Link search system, you\r\n can search by:\r\n\r\n * subject\r\n * filename\r\n * uplre search words assigned\r\n to each library. For example, the disk\r\n utilities library online has the\r\n keywords "disk", "utility", and\r\n "application" assigned. A list of\r\n these common keywords are available\r\n in the "Sample Keywords" listoader name\r\n * keywords\r\n\r\n The keywords are search words assigned\r\n to each library. For example, the disk\r\n utilities library online has the\r\n keywords "disk", "utility", and\r\n "application" assigned. A list of\r\n these common keywords are available\r\n in the "Sample Keywords" list located\r\n on the prior menu.\r\n\r\n In addition, you can search by time\r\n period: new files this week, new files\r\n this month or all files in the\r\n library.\r\n\r\n The search system can display up to\r\n 28 files. If more than 28 files are\r\n found you''ll be asked to provide a\r\n more specific search phrase. You can\r\n do this by providing more words or by\r\n using conditional search words.\r\n You''ll find more information on how\r\n to do this in the "How to Search the\r\n Libraries" area on the previous menu.\r\n');
INSERT INTO `articles` VALUES (508330, 0, 0, ' HOW TO SEARCH THE LIBRARIES\r\n\r\n From the Search Menu, you''ll need to\r\n choose which of the library sections\r\n you''d like to search. You''ll choose\r\n based on the computer and operating\r\n system.\r\n\r\n As an example, let''s look for a word\r\n game for the C64 computer. First\r\n we''ll select the C64 Library search\r\n area and then "Search All Files".\r\n This will search every file in the\r\n C64 libraries, new and old.\r\n\r\n Next, we''ll enter the search phrase\r\n "word game". This will search for\r\n files which have the two words "word"\r\n and "game". After pressing return the\r\n system tells us that there were 114\r\n files found and asks us to "Please\r\n use more specific search words".\r\n\r\n Let''s decide to go for word games\r\n which have you unscramble words. We\r\n can do this by changing the search\r\n phrase to "word game unscramble".\r\n This will give us a list of 3 files\r\n we can look at and download.\r\n\r\n TOOLS FOR SEARCHING: AND, OR, NOT\r\n\r\n You can use "AND" to join words and\r\n phrases together such as "word and\r\n game" shown above. Generally the\r\n "and" is understood to be there when\r\n two or more words are put in the\r\n search phrase. In the above example,\r\n we could have entered "word and game\r\n and unscramble" and received the same\r\n result.\r\n\r\n Using "OR" will allow you to find\r\n words which contain one or both of\r\n two specified words. Continuing our\r\n example we could expand our search by\r\n using the phrase "scramble or\r\n unscramble". This will find files\r\n with either the word "scramble" or\r\n "unscramble".\r\n\r\n Finally we can use the "NOT" word to\r\n narrow our search. For example if we\r\n use the phrase "scramble not game" we\r\n find two files, neither of which is a\r\n game.\r\n');
INSERT INTO `articles` VALUES (488298, 0, 0, ' HINTS AND TIPS ON SEARCHING\r\n\r\n 1) The "*" symbol is used in file\r\n subject lines to indicate files\r\n recommended by the SysOps. Add this\r\n character to your search phrase to\r\n get only these select files.\r\n\r\n 2) If there are too many files found\r\n try using the "New This Week" or "New\r\n This Month" options to narrow your\r\n search.\r\n\r\n 3) When searching for files from a\r\n particular uploader always include\r\n any spaces which appear in their\r\n screen names.\r\n\r\n 4) The system is not case sensitive:\r\n It doesn''t matter if you use upper or\r\n lower case letters.\r\n\r\n 5) Don''t forget that different people\r\n see things differently... some people\r\n may call it a "word scramble game",\r\n others a "word unscramble game".\r\n Using "OR" can help; "scramble or\r\n unscramble" can find both.\r\n\r\n 6) Numbers are ignored by the search\r\n system unless they have a decimal\r\n point or letter/number combination\r\n (such as "1.3" or "C64").\r\n\r\n 7) Search words must be 3 or more\r\n characters long.\r\n\r\n 8) When using the "New This Week" or\r\n "New this Month" options, you can\r\n press return with no search phrase\r\n and g¥t a list, or count how many\r\n files have been added, of the newest\r\n files.\r\n');
INSERT INTO `articles` VALUES (504659, 462847, 0, ' SAMPLE KEYWORDS\r\n\r\n Below are some of the keywords\r\n assigned to libraries. You can use\r\n these as a start in building a search\r\n phrase. Additional words should be\r\n used to further define the type of\r\n files you are looking for.\r\n\r\n ABSTRACT     CONVERT      HIRES\r\n ACCESS       COUNTRY      HOLIDAY\r\n ACTION       CREA  HUMOROUS\r\n ADVENTURE    DATABASE     ICON\r\n AID          DEMO         IMAGE\r\n AIR          DESIGN       INFO\r\n ALBUM        DESKTOP      INFORMATION\r\n AMIGA        DESTRUCTION  INPUT\r\n AND          DICE         INSTANT\r\n ANIMAL       DIGITAL      INVENTORY\r\n ANIMATION    DIGITIZED    INVOICE\r\n APPLICATION  DIRECTORY    INVOICING\r\n ARCADE       DISK         JAPANIMATION\r\n ARCHIVE      DISPLAY      JAZZ\r\n ART          DOODLE       JIM\r\n ARTICLE      DOWNLOAD     KEEPER\r\n ASCII        DRIVER       KEYBOARD\r\n ASSEMBLER    DUMP         KID\r\n BACH         DUNGAN       KOALA\r\n BANK         DUNGEON      KORG\r\n BASE         EARLY        LABEL\r\n BASEBALL     EDITOR       LABYRITH\r\n BASIC        EDUCATION    LANDSCAPE\r\n BATTLE       EDUCATIONAL  LANGUAGE\r\n BBS          EFFECTS      LIBRARIAN\r\n BEGINNER     ELECTRONIC   LIFE\r\n BOARD        ENHANCEMENT  LIST\r\n BORDER       ENSONIQ      LIVE\r\n BRAIN        EUPHONY      LORES\r\n BSW          EXECUTABLE   LOTTERY\r\n BUDGET       EXPANSION    MAC\r\n BUSINESS     EXTENSION    MACHINE\r\n C64          FACE         MACPAINT\r\n CALL         FANTASY      MADELBROT\r\n CARD         FICTION      MAILING\r\n CARTOON      FIGURE       MAINTENANCE\r\n CASINO       FILE         MANAGEMENT\r\n CASIO        FILM         MANAGER\r\n CBM          FINANCIAL    MANIPULATION\r\n CENTURY      FLIPPING     MASTER\r\n CHANCE       FOLK         MATCH\r\n CHARACTER    FONT         MATH\r\n CHECKBOOK    FORMAT       MENU\r\n CLASSICAL    FORTH        MESSAGE\r\n CLI          FROM         MIDI\r\n CLIP         FUNNY        MIRAGE\r\n CNET         FUTURE       MISC\r\n COL          GAME         MODEM\r\n COLLECTION   GENERATOR    MODIFICATION\r\n COLUMN       GEO          MODULA\r\n COMAL        GEOPAINT     MODULE\r\n COMIC        GEOS         MONITOR\r\n COMMAND      GEOWRITE     MOVIE\r\n COMMERCIAL   GRAPHIC      MOZART\r\n COMPOSER     GROUP        MULTI\r\n COMPUTER     HARDWARE     MUSIC\r\n CONFERENCE   HASTING      MYSTERY\r\n CONSTRUCTION HELP         NATURE\r\n CONVERSION   HINT         NET\r\n');
INSERT INTO `articles` VALUES (462847, 0, 504659, '----------------------------\r\n\r\n NOTE         SCORE        VDE\r\n NOVELTY      SEA          VIDEO\r\n NUMBER       SECTOR       VIEWER\r\n OBERHEIM     SEQUENCE     WAYNE\r\n OBJECT       SEQUENTIAL   WORD\r\n OCCASION     SET          WORDSTAR\r\n OPERA        SHOOT        WORKBENCH\r\n ORIGINAL     SHOP         WRITE\r\n OTHER        SHOW         WRITER\r\n PAGE         SID          XMODEM\r\n PAINT        SIDPLAYER    YAMAHA\r\n PARK         SIMULATION   Z80\r\n PASCAL       SINFONIAS\r\n PATCH        SLIDESHOW\r\n PATRICK      SOFTWARE\r\n PATRIOTIC    SONUS\r\n PATTERN      SOUND\r\n PEOPLE       SOURCE\r\n PHOTO        SPACE\r\n PICTURE      SPECIAL\r\n PINBALL      SPORT\r\n PLAYER       SPREADSHEET\r\n PLOTTER      SPRITE\r\n POP          SPY\r\n PRE          SSI\r\n PRINTER      STEREO\r\n PROCESSING   STILL\r\n PRODUCT      STRATEGY\r\n PROGRAM      STREET\r\n PROGRAMMING  STRIP\r\n PROJECT      STUDIO\r\n PROTOCAL     SUB\r\n PROTOCOL     SUGGESTED\r\n PUBLIC       SUPER\r\n PUBLISHING   SUPERBASE\r\n PUNTER       SUPPORT\r\n PUZZLE       SYSOP\r\n QLINK        TEACHER\r\n QUEST        TEASER\r\n QUIZ         TELECOM\r\n RACE         TERMINAL\r\n RACING       TESTING\r\n RAGTIME      TEXT\r\n RAM          THEM\r\n RAY          THEME\r\n REALM        THINKING\r\n RECREATION   TIMER\r\n RECREATIONAL TIP\r\n RELIGIOUS    TOOL\r\n RES          TOPIC\r\n REVIEW       TRACING\r\n ROCK         TRACK\r\n ROLAND       TRANSCRIPT\r\n ROLL         TRANSLATION\r\n ROMANTIC     TRANSPORTATION\r\n ROUTINE      TRIVIA\r\n SACHS        TUTORIAL\r\n SCHMIDT      ULTRA\r\n SCI          UTILITIES\r\n SCIENCE      VDC\r\n');
INSERT INTO `articles` VALUES (523033, 0, 0, ' BROWSE THE LIBRARIES \r\n\r\n It''s easy to get programs from our \r\n software libraries. \r\n\r\n If you don''t have a specific title in \r\n mind, selecting  one of the library \r\n browse features allows you to browse \r\n through all the libraries to find \r\n items that are of interest to \r\n you. \r\n\r\n For your convenience the librarie\r\n find the software for the computer \r\n (or mode) you want to use. \r\n\r\n Once you have selected which computer \r\n you wish to find files for you will \r\n find the libraries organized by the \r\n same major categories found in the \r\n CIN Support Groups area. \r\n\r\n After choosing the library you are \r\n interested in and selecting the \r\n appropriate software category, you \r\n can then choose to see the files by \r\n filename or by subject name. The \r\n filename is the name that the \r\n uploader gave to the file. The \r\n subject name more clearly defines \r\n the software. \r\n\r\n Either choice will give you a menu of \r\n upload dates. Browse through all the \r\n date categories. Move the checkmark \r\n to the appropriate file and press F1. \r\n The descriptio¶ of the file will be \r\n displayed on your screen. \r\n\r\n After reading the description, press \r\n F7 for the download menu. You''ll be \r\n able to read or post comments about \r\n the program, or download the program. \r\n\r\n Remember that you will need a \r\n formatted disk (other than your \r\n Q-Link Program Disk) to receive the \r\n file. \r\n');
INSERT INTO `articles` VALUES (523036, 0, 0, ' LIBRARY HIGHLIGHTS \r\n\r\n The "Library Highlights" section is \r\n your direct link to the newest and \r\n most popular software in the "Public \r\n Domain Software Libraries". \r\n\r\n The area includes four special \r\n libraries: \r\n\r\n * NEW THIS WEEK LIBRARIES \r\n * WEEKLY UPLOAD GUIDES \r\n * TOP SOFTWARE PICKS \r\n * ALL TIME TOP DOWNLOADS \r\n\r\n NEW THIS WEEK LIBRARIES \r\n\r\n The "New this Week Libraries" allows \r\n you to browse and download the most \r\n recent additions to the libraries. \r\n The software is grouped by major \r\n library categories. \r\n\r\n You may browse the new additions by \r\n filename or subject heading. \r\n Commodore 128 software is easily \r\n identified by the addition of \r\n "(C128)" to the subject line. \r\n\r\n These libraries are updated every \r\n Friday and include all files \r\n uploaded to the "Public Domain \r\n Software Libraries" during the prior \r\n week. \r\n\r\n WEEKLY UPLOAD GUIDES \r\n\r\n The "Weekly Upload Guides" are \r\n downloadable text files containing \r\n the COMPLETE descriptions of all the \r\n files uploaded in the previous week. \r\n\r\n Each Major catagory holds both the \r\n C-64 and C-128 Software Guides. The \r\n C-64 and C-128 Files are identified \r\n in the subject line of the library \r\n listing. \r\n\r\n After downloading these files you \r\n can look at the complete \r\n descriptions of file off-line. These \r\n files can be viewed and/or printed \r\n using SPRINT or most popular \r\n word processing programs. The files \r\n are divided by major library \r\n categories and are updated each \r\n Friday. \r\n\r\n TOP SOFTWARE PICKS \r\n\r\n The files in this area match the \r\n "Top Software Picks" which appear \r\n each month in Q-Link''s Update \r\n newsletter. They represent some of \r\n the most popular software in the \r\n Q-Link Libraries. \r\n\r\n ALL TIME TOP DOWNLOADS \r\n\r\n This section lists the top downloads \r\n of all time by library. The list \r\n is updated each month so check back \r\n to see what new files have made the \r\n list. \r\n\r\n These libraries can also be found \r\n under "Library Highlights" for \r\n each Special Interest Group in \r\n the "Commodore Community." \r\n');
INSERT INTO `articles` VALUES (443054, 0, 0, ' DOWNLOADING HELP AND INFORMATION\r\n\r\n * Downloader''s Starter Kit\r\n * Downloading Help Desk\r\n * Public Domain Software Directory\r\n\r\n The "Downloader''s Starter Kit" is\r\n designed to guide you through your\r\n first download, from formatting your\r\n first disk to loading and running\r\n your first download.\r\n\r\n The "Downloading Help Desk" is your\r\n place to get information and help on\r\n downloading.  Our own downloading\r\n expert, "QDL Laura", will help you\r\n get the answers you need.\r\n\r\n It''s arrived -- the new 1989/90\r\n Public Domain Software Directory!\r\n Now you can consult this reference\r\n guide, which lists more than 25,000\r\n Q-Link public domain files available\r\n for you to download right here on\r\n Q-Link!\r\n\r\n Copyright 1989 Quantum Computer\r\n Services, Inc.\r\n');
INSERT INTO `articles` VALUES (461276, 0, 0, ' Q-LINK UTILITIES \r\n\r\n The Q-Link Utilities libraries \r\n provide you with easy access to \r\n programs that will help you get the \r\n most out of Q-Link and its public \r\n domain libraries. \r\n\r\n The utilities are divided into four \r\n sections: \r\n\r\n * Q-Link Color change program \r\n * Text File Readers \r\n * Download Utilities \r\n * Music and Graphic Utilities \r\n\r\n Each section has a description about \r\n the utilities, why they are used and \r\n when to use them. \r\n\r\n The Q-Link Colors program allows you \r\n to change the colors of the screen, \r\n text and menus in all Q-Link \r\n departments. \r\n\r\n The Text File Rea* Music and Graphic Utilities \r\n\r\n Each section has a description about \r\n the utilities, why they are used and \r\n when to use them. \r\n\r\n The Q-Link Colors program allows you \r\n to change the colors of the screen, \r\n text and menus in all Q-Link \r\n departments. \r\n\r\n The Text File Readers can be used to \r\n read your Q-Link E-Mail, messages \r\n saved to your disk, documentation \r\n and other text you download from \r\n Q-Link. \r\n\r\n Download Utilities are used on \r\n certain files in the public domain \r\n libraries. These utilities are used \r\n to separate or expand files that \r\n end in ".arc", ".lnx", ".lbr" or \r\n begin with "q/". \r\n\r\n Music and Graphics Utilities allow \r\n you to "play" music files and to \r\n display or print graphic files. \r\n\r\n For your convenience, utilities \r\n which contain more than one file \r\n have been combined. When you download \r\n these utilities, they automatically \r\n are broken up into two or more files \r\n on your disk. This assures that you \r\n get everything you need in one, easy \r\n step. Where documentation on a \r\n program is available, it has been \r\n included as part of the utility. \r\n');
INSERT INTO `articles` VALUES (21830, 0, 0, ' UPLOAD A FILE - FREE \r\n\r\n If you would like to submit a file to \r\n the "Software Libraries," select \r\n "Upload a File" from the "Software \r\n Libraries" menu. \r\n\r\n Choose the appropriate software \r\n library and section of that library \r\n to which you would like to upload. \r\n Then select "Submit a New File for \r\n This Area." You will be asked for the \r\n name of the file you wish to upload. \r\n This must be the exact name of the \r\n file as it appears on the DIRECTORY \r\n of that disk except that you must \r\n type in the name in lowercase \r\n letters. \r\n\r\n Note: The option, "See Files in This \r\n Area" is not functional. To see \r\n public domain files, choose "Browse \r\n the Libraries." \r\n');
INSERT INTO `articles` VALUES (59976, 0, 0, ' PUBLIC DOMAIN SOFTWARE DIRECTORY \r\n\r\n The Q-Link Public Domain Software \r\n Directories make downloading quicker \r\n and easier by allowing you to browse \r\n through the Software Libraries while \r\n offline. \r\n\r\n Information on each file includes its \r\n subject heading, the filename, the \r\n name of the person who uploaded the \r\n file, and the date the file was \r\n uploaded. \r\n\r\n Each chapter in corresponds to a \r\n different Q-Link Software Library. \r\n The chapter is then broken down into \r\n the same categories as the online \r\n Software Libraries. The files are \r\n listed under each category in \r\n alphabetical order by subject \r\n heading. \r\n');
INSERT INTO `articles` VALUES (523041, 0, 0, ' USER GROUP SUPPORT CENTER \r\n\r\n * TPUG \r\n * User Group Shows and Fairs \r\n * User Group Leader Exchange \r\n * User Group Leader Upload Area \r\n\r\n TPUG \r\n\r\n Toronto Pet Users Group (TPUG) was \r\n founded in 1978 in Toronto and has \r\n since grown to be on of the largest \r\n international Commodore user groups \r\n in the world. TPUG brings you the \r\n best of their Software Libraries \r\n along, a message board for questions \r\n and answers as well as a chance to \r\n join this exciting group. \r\n\r\n USER GROUP SHOWS AND FAIRS \r\n\r\n This area lists upcoming trade \r\n shows and fairs sponsored by the \r\n Commodore User Groups. Here you''ll \r\n find a schedule of shows and \r\n a highlight on some of the big \r\n events. \r\n\r\n THE USER GROUP LEADER EXCHANGE \r\n\r\n The User Group Leader Exchange is \r\n specifically designed to help User \r\n Group Leaders get together in a \r\n nation-wide network to support \r\n their club activities. \r\n\r\n This area includes information \r\n and library files to be shared by \r\n User Group leaders, a directory \r\n of participating User Groups, \r\n information on scheduling a Q-Link \r\n demo at Club meetings and more. \r\n\r\n USER GROUP LEADER UPLOAD AREA \r\n\r\n This area is provide you with a FREE \r\n area to upload your contributions to \r\n the "User Group Leader Exchange " \r\n libraries \r\n');
INSERT INTO `articles` VALUES (443050, 0, 0, '            CIN SYSOP LIST\r\n            --------------\r\n\r\n Below is a complete list of the\r\n COMMODORE INFORMATION NETWORK SysOps.\r\n While you should post general\r\n questions on the public message boards\r\n in each group''s area, if you have a\r\n specific problem you think the SysOp\r\n could help you with, you can reach the\r\n SysOps by E-Mailing them at the names\r\n below.\r\n\r\n -------------------------------------\r\n COMPUTING SUPPORT GROUPS\r\n -------------------------------------\r\n\r\n GENERAL/BEGINNERS'' GROUP: QDL Laura\r\n                           QDL Tom\r\n\r\n APPLICATIONS       :  SYSOP DM\r\n                       SYSHELP TJ\r\n\r\n CP/M               :  SYSOP LL\r\n\r\n MUSIC ROOM         :  SYSOP JON\r\n                       SYSOP SIDs\r\n                       SYSOP MIDI\r\n                       SYSOP Keys\r\n                       SYSHELP JG\r\n\r\n GAME ROOM          :  SYSOP SR\r\n                       SYSOP RF\r\n                       SYSHELP ME\r\n\r\n GRAPHICS           :  SYSOP WP\r\n                       SYSOP PH\r\n                       SYSHELP KW\r\n                       SYSHELP RS\r\n\r\n PROGRAMMERS WORKSHOP:  SYSOP JL\r\n                        SYSHELP SE\r\n\r\n TELECOMMUNICATIONS  :  SYSOP CJ\r\n                        SYSOP JC\r\n\r\n -------------------------------------\r\n HARDWARE SUPPORT GROUPS\r\n -------------------------------------\r\n\r\n C64                 :  SYSOP BJH\r\n\r\n C128-TWIN CITIES 128:  Lovhaug\r\n\r\n AMIGA ALLIANCE      :  SYSOP LL\r\n\r\n PC-10/MS-DOS        :  SYSOP LL\r\n');
INSERT INTO `articles` VALUES (465808, 0, 0, ' SENDING ONLINE MESSAGES \r\n\r\n To send an online message (OLM), you \r\n need to go to the "Q-Link Post \r\n Office."  You will find a "Q-Link \r\n Post Office" on many of the menus \r\n in each of the Q-Link departments, \r\n with the exception of the CUSTOMER \r\n SERVICE CENTER. \r\n\r\n Once you select "Q-Link Post Office" \r\n from the menu, you will have three \r\n options: "Send an Online Message", \r\n "Send Electronic Mail", or "Read \r\n Waiting Mail."  Choose "Send \r\n an Online Message." \r\n\r\n You will then be asked for the screen \r\n name of the person to whom you wish \r\n to send the message.  Type in the \r\n screen name and press <RETURN>. \r\n\r\n After Q-Link checks to be sure that \r\n you have typed a valid screen name \r\n and that the person is currently \r\n online, you may begin entering the \r\n text of your message, which may be up \r\n to 15 lines long.  You will receive \r\n a notification when you reach this \r\n limit. \r\n\r\n When you''re entering the text of \r\n the message, you will not be able to \r\n type a blank line; each line must \r\n have something on it.  When you \r\n are finished typing your message, \r\n press <RETURN> on a blank line. This \r\n will tell Q-Link that you are \r\n finished. \r\n\r\n Sometimes other members may be in a \r\n section of Q-Link that will not allow \r\n them to receive your OLM; you may try \r\n again in a few minutes or send \r\n E-Mail. Also, some online games do \r\n not allow the sending of messages \r\n during the game so you may have to \r\n wait for a response. \r\n');
INSERT INTO `articles` VALUES (465804, 0, 0, ' SENDING ELECTRONIC MAIL \r\n\r\n To send electronic mail (E-Mail), \r\n select "Q-Link Post Office" from one \r\n of the many menus throughout Q-Link. \r\n There is no Q-Link Post Office in the \r\n CUSTOMER SERVICE CENTER. \r\n\r\n Once you select "Q-Link Post Office" \r\n from the menu, you will have three \r\n options: "Send an Online Message", \r\n "Send Electronic Mail", or "Read \r\n Waiting Mail."  Choose "Send \r\n Electronic Mail." \r\n\r\n You will then be asked for the screen \r\n name of the person to whom you wish \r\n to send the E-Mail.  Type in the \r\n other Q-Link member''s screen name and \r\n press <RETURN>. \r\n\r\n After Q-Link checks that you have \r\n typed a valid screen name, you may \r\n begin entering the text of your \r\n E-Mail.  Q-Link E-Mail may be up to \r\n 45 lines long and up to 39 characters \r\n to a line. Press <RETURN> once at the \r\n end of each line. You will be told \r\n when you have reached the maximum \r\n number of lines. \r\n\r\n When you''re entering the text of the \r\n mail, you will not be able to enter a \r\n blank line; each line must have \r\n something on it.  When you have \r\n finished typing your mail, press \r\n <RETURN> on a blank line. \r\n\r\n You will then see the message "Your \r\n mail has been posted."  This tells \r\n you that the mail is now waiting for \r\n its intended recipient who will see \r\n the word "MAIL" appear in the bottom \r\n corner of his or her screen and may \r\n then go to a "Q-Link Post Office" to \r\n read it. \r\n\r\n E-Mail will remain online for a \r\n period of 45 days or until it is \r\n read. \r\n');
INSERT INTO `articles` VALUES (465815, 0, 0, ' READING ELECTRONIC MAIL\r\n\r\n If you see the word "MAIL" in the\r\n lower right-hand corner of your\r\n screen, you have Electronic Mail\r\n (E-Mail) waiting for you.\r\n\r\n To read your waiting E-Mail, you need\r\n to go to the "Q-Link Post Office."\r\n You will find a Post Office on the\r\n menu in all of the departments with\r\n the exception of the CUSTOMER SERVICE\r\n CENTER.  To get the menu in PEOPLE\r\n CONNECTION, press the F7 key.\r\n\r\n Once inside the Post Office, select\r\n "Read Waiting Mail."  The mail sent\r\n to you by other members will then\r\n appear.  Once you have read a piece\r\n of E-Mail, it will be removed from\r\n the Q-Link system.  E-Mail will also\r\n be automatically removed after 45\r\n days of the date sent.\r\n\r\n Sometimes you receive E-Mail that is\r\n longer than your screen can display\r\n at one time.  If this happens, you\r\n may "scroll" the text by using the up\r\n and down <CRSR> keys, located on the\r\n lower right hand corner of your\r\n keyboard.\r\n\r\n If you see the "MAIL" flag but Q-Link\r\n says "No mail waiting" when you try\r\n to read your mail, simply send mail\r\n to yourself, then read the mail.\r\n This will "unlock" the "MAIL" flag\r\n and cause it to disappear.\r\n\r\n If you are using a version 3 or\r\n version 4 Q-Link Program disk, you\r\n may save your mail by pressing F7 and\r\n choosing "Save mail" after you read\r\n it.  You will need to put a formatted\r\n disk (not your Q-Link Program Disk)\r\n into the disk drive and select a\r\n filename for the mail.  This filename\r\n must be at least one character and no\r\n more than 16 characters in length.\r\n Numbers, lowercase letters, a period\r\n and/or a slash may be used.  Mail\r\n saved in this manner can be read\r\n offline using any sequential file\r\n reader or word processor.  There is a\r\n sequential reader/printer, SPRINT, on\r\n the versions 3 and 4 Q-Link Program\r\n Disk or downloadable from the "Q-Link\r\n Utilities" section in the COMMODORE\r\n SOFTWARE SHOWCASE''s Software\r\n Libraries under "Text File Readers."\r\n');
INSERT INTO `articles` VALUES (466634, 0, 0, ' HOW TO USE FUNCTION KEYS \r\n\r\n Unlike most online services, Q-Link \r\n is menu driven and therefore, you \r\n don''t have to memorize a complex \r\n series of commands. All of Q-Link''s \r\n features and functions are at your \r\n fingertips through your function \r\n keys. \r\n\r\n These function keys are the F1, F3, \r\n F5 and F7 keys on your Commodore \r\n computer.  They are your online \r\n "tools" and allow you to select \r\n options from menus, move between \r\n departments, clear your screen of \r\n text and menus, and more. \r\n\r\n Function key 1 (F1): allows you to \r\n select an item on any Q-Link menu. \r\n\r\n Function key 3 (F3): allows you to \r\n save the text on your screen onto a \r\n a formatted disk. This works in all \r\n departments of Q-Link except PEOPLE \r\n CONNECTION. It is also used while \r\n playing online games to select either \r\n playing or chatting mode. For more \r\n on saving text, press F5 and select \r\n "How to Save Screen Text." \r\n\r\n Function key 5 (F5): allows you to \r\n "back out" of a menu or series of \r\n menus. Press the F5 key to clear \r\n menus or text from your screen. \r\n\r\n Function key 7 (F7): displays the \r\n menu of items and functions available \r\n in that service or department. It is \r\n also a "help" key that will display \r\n information about how a function \r\n works. \r\n\r\n Once you have a Q-Link menu on your \r\n screen, use your <CRSR> up/down key \r\n to move the cursor between items on a \r\n menu. The cursor will appear as a \r\n check mark on Q-Link menus. If you \r\n have difficulty moving the check \r\n mark, check your <SHIFT/LOCK> key. \r\n');
INSERT INTO `articles` VALUES (465810, 0, 0, ' POSTING MESSAGES ON MESSAGE BOARDS \r\n\r\n Q-Link''s message boards were designed \r\n to be easy to use.  To post a message \r\n for other Q-Link members to read, go \r\n to one of the many message boards on \r\n the Q-Link system and select "Start a \r\n new topic." \r\n\r\n You will be asked for the subject of \r\n your message.  This subject line may \r\n be no longer than 30 characters. \r\n\r\n After you enter the subject of the \r\n message, you may begin composing the \r\n text of the message. \r\n\r\n While typing the text of your \r\n message, you may use the cursor keys \r\n to position the cursor, the insert \r\n and delete keys, and the return key. \r\n There are also a number of special \r\n editing features available by \r\n pressing F7.  Using the menu you get \r\n when you press F7, you will be able \r\n to delete lines, insert text, etc. \r\n\r\n When you have finished composing your \r\n message, press F7 and choose "Send \r\n message to Q-Link."  Q-Link will tell \r\n you when your message has been sent. \r\n Other members may now view and \r\n respond to your message. \r\n\r\n To respond to a message posted by \r\n another Q-Link member, press F7 and \r\n choose "Add a message to this topic" \r\n after reading the original message. \r\n Type your response using the \r\n directions above for posting a \r\n message. The original message will \r\n now have "(R)" at the end of the \r\n subject line.  Any response that has \r\n another response after it will also \r\n have the "(R)."  The number of \r\n responses to an original message will \r\n be indicated in its subject line. For \r\n example, if a message has three \r\n responses to it, there will be "(R3)" \r\n at the end of its subject line. \r\n\r\n Another option available to you after \r\n reading a message is to "Read message \r\n after date."  This will allow you to \r\n view all responses after a date which \r\n you specific by following the \r\n prompts. \r\n\r\n       <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (484790, 0, 0, '\n HOW TO UPLOAD FILES \n\n If you would like to submit a file to \n the software libraries, select \n "Upload a File" from the "Software \n Libraries" menu. \n\n Choose the appropriate software \n library and section of that library \n to which you would like to upload. \n Then select "Submit a New File for \n This Area." You will be asked for the \n name of the file you wish to upload. \n This must be the exact name of the \n file as it appears on the DIRECTORY \n of that disk except that you must \n type in the name in lowercase \n letters. \n\n Note: The option, "See Files in This \n Area" is not functional. To see \n public domain files, choose "Browse \n the Libraries." \n\n HINTS FOR UPLOADING \n\n 1) When uploading a text file or a \n program to Q-Link, be sure to enter \n the filename exactly as it appears on \n the DIRECTORY of that disk (except \n that the filename must be entered in \n lowercase letters). \n\n 2) When entering the description of \n the file/program to be uploaded, \n Please be sure to include the \n following: \n\n - State that the file/program is in \n   the Public Domain. \n\n - Include a good description of what \n the file is; for example: \n\n  "The documentation file for..." \n\n  "This is a disk utility program that \n  gives you the options of..." \n\n  "This is the second of four files.." \n\n 3) Be sure you upload the program to \n the appropriate Software Library. \n\n Note: An uploaded file, will not \n appear immediately. Files uploaded to \n Q-Link are reviewed first. \n\n        <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (484788, 0, 0, '\n DOWNLOADING \n\n After selecting the software library \n in which you are interested, you will \n have the option to view the files by \n filename or by subject. The \n "filename" option will display a \n listing of the exact filenames. The \n "subject" option will display a \n listing of subject headings. \n\n Either choice will give you a menu of \n upload dates. Select a date category \n by pressing F1 and then move the \n check mark to the file you wish to \n download; press F1. The description \n of the file will be displayed on your \n screen. \n\n After reading the description, press \n F7 for the download menu. You''ll be \n able to read or post comments about \n the file, or download the file. \n\n To download the file, select \n "Download This File" and follow the \n prompts. \n\n You will need a formatted disk (other \n than your Q-Link Program Disk) to \n receive the file. \n\n It is a good idea to thoroughly read \n file descriptions and the comments \n posted by other Q-Link members, who \n often give beneficial hints and \n opinions. Also, it is useful to take \n notes on such things as how to use or \n LOAD the file, for later reference. \n\n        <PRESS F5 FOR MENU> \n');
INSERT INTO `articles` VALUES (484780, 0, 0, '\n DOWNLOAD A SPECIFIC FILE \n\n If you know the exact filename and \n the uploader''s exact screen name, you \n can quickly download a file by \n selecting the "Download a Specific \n File" option from the "Software \n Libraries" menu. Q-Link will ask you \n to type in the name of the file to be \n downloaded, and then the name of the \n person who uploaded the file. \n\n Q-Link will check to make sure the \n file is available and then ask you to \n insert a formatted disk. When you are \n ready, press <RETURN> and the file \n will be downloaded. If you have a \n version 3 or 4 Q-Link Program Disk, a \n bell on your computer will ring, to \n tell you when the downloading is \n complete. \n\n Note: Please do not use the "Upload a \n File" option in "Download a Specific \n File" as this option does not work on \n that menu. \n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (453736, 0, 0, ' HOW TO FORMAT A DISK\n\n Formatting allows you to save files\n on a new disk.  It also creates the\n beginning of a directory of the files\n you save to that disk.  Here is how\n to format a disk:\n\n 1. Turn on your computer, disk drive,\n and monitor.  If you are using a\n C128, hold down the Commodore key\n when you turn the computer on so you\n will boot up in C64 mode.\n\n 2. Place the new disk you wish to\n format in the disk drive and close\n the drive door.\n\n 3. Type the following command:\n\n OPEN 15,8,15,"N0:diskname,id":CLOSE 15\n and press <RETURN>.\n\n **(NOTE: "N0:... uses a ZERO and not\n the letter O)**\n\n The "diskname" is any name you wish\n to use for the disk, and can be as\n long as 16 characters.  The "id" is\n any two characters (the disk drive\n uses the "id" to identify the disk.\n An example of a diskname and id is:\n\n             DOWNLOADS 1,01\n\n You will not see the flashing cursor\n while the disk drive is formatting\n the disk until it reaches and\n executes the CLOSE command.  A\n flashing DRIVE light after the\n formatting is complete indicates a\n disk error.  Check to see that the\n disk is properly notched, that the\n drive door is closed, and that the\n you typed the command correctly.\n\n NOTE: Formatting a disk will erase\n all existing files on the disk; you\n only need to format a disk the first\n time you use it.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (503892, 0, 0, '\n HOW TO DISPLAY THE DISK DIRECTORY \n\n You can display the directory of a \n disk by typing: \n\n LOAD "$",8 \n\n and then pressing <RETURN>. \n\n After you see the flashing cursor \n again, type: \n\n LIST \n\n and then press <RETURN>. \n\n The diskname, id, and any files you \n have saved to that disk will then be \n displayed. \n\n         <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (504539, 0, 0, ' DISK ERROR MESSAGES\n\n\n If you receive a disk error message\n from Q-Link, indicating that the disk\n is not formatted or does not have\n enough room for the file you wish to\n download, you will need to clear the\n message by turning the drive off and\n back on again. This will "reset" it.\n Then press <RETURN> to continue with\n the downloading process.\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (500381, 0, 0, '\n DOWNLOADING TOO LONG \n\n Downloading speeds can vary for many \n different reasons.  It could be the \n number of users trying to use the \n same access number that you are \n using. It can also be a result of \n other members trying to download the \n same file. \n\n Switching access numbers in your area \n may help. Select "Access Numbers" in \n the "Members'' Online Guide" in \n CUSTOMER SERVICE CENTER for a \n complete list of the access numbers \n in your area. \n\n Also, excessive noise on the \n telephone line, as well as errors \n noted during error-checks, will cause \n the Q-Link to resend data, which will \n increase the download time.  These \n errors can be caused by peripherals \n connected to the disk drive (such as \n a second disk drive or printer). \n An answering machine or cordless \n phone on your telephone line may \n cause the same problem. \n\n         <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (500182, 0, 0, '\n PROGRAM WILL NOT RUN \n\n Reading the file description of a \n file that you wish to download will \n give you instructions on how to LOAD, \n RUN, and use a file. Also, browsing \n through the comments on a file \n description can help with problems \n you may encounter. \n\n You can save file descriptions and \n their comments by pressing the F3 \n key, and following the prompts. (See \n the "How to Save Screen Text" file.) \n\n However, you may try the two most \n frequently used LOAD commands and see \n if they will work. Type: \n\n LOAD"filename",8   (Press <RETURN>) \n\n Then type: \n\n RUN                (Press <RETURN>) \n\n If that does not work, type: \n\n LOAD"filename",8,1 (Press <RETURN>) \n\n Then type: \n\n RUN                (Press <RETURN>) \n\n Turn off your computer and disk drive \n before and after each attempt. \n\n Sometimes disconnecting peripherals \n will help. Modems, fast load \n cartridges and printers may cause \n programs not to load or run properly. \n\n        <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (501939, 0, 0, '\n FILE TYPES \n\n To determine the filetype, you will \n need to run the disk directory.  You \n can do this by simply typing (while \n offline): \n\n     LOAD "$",8      (Press <RETURN> \n     LIST            (Press <RETURN> \n\n This will allow you to see the size \n (the number of blocks) of each file, \n the exact name of the file (with \n spaces), and the type of file. \n\n The exact name, with the correct \n spelling, spaces and punctuation, is \n very important when you reference a \n filename. \n\n The column on the right side of the \n directory indicates the file type. \n The only types that can be downloaded \n from Q-Link are SEQ (sequential) and \n PRG (program). \n\n SEQ files are either text files that \n require a sequential reader, such as \n SPRINT or a word processor in order \n to view them, or they are files that \n have been altered in some way to make \n uploading and downloading easier. \n\n Note:  SPRINT may be found on \n versions 3 and 4 Q-Link Program Disks \n or in the "Features" section of NEWS \n AND INFORNATION under "Auditorium \n Archives". \n\n PRG files are simply LOADed and RUN. \n See the file "Program Will Not Run" \n for information about using these \n files. \n\n Occasionally, you will see a file \n that has an asterisk (*) in front of \n the file type.  These files are known \n as "splat" files and are caused by a \n file not being completely written to \n the disk, such as an incomplete \n download. You will not be able to use \n these files. \n\n        <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (462887, 0, 0, ' HOW TO SAVE SCREEN TEXT\n\n Text or postings on message boards in\n all the departments other than PEOPLE\n CONNECTION may be saved to disk.  You\n may also save dialogue in conference\n rooms.\n\n Insert a formatted disk (other than\n your Q-Link Program Disk) into your\n disk drive.  Make sure all off the\n text is in your "buffer"; the\n checkmark at the top right corner of\n your screen will disappear.\n\n Press F3 to start the save.  You will\n then be asked for a filename.  This\n filename must be at least one\n character and no more than sixteen\n characters in length.  Numbers,\n lowercase letters, a period and/or a\n slash may be used.  Press <RETURN>\n after you''ve typed the filename.\n You''ll then be reminded not to save\n files onto your Q-Link Program Disk;\n press <RETURN> to continue.\n\n When you save more than one file with\n the same name, each additional file\n will automatically be appended to the\n existing file.\n\n SAVING IN CONFERENCE ROOMS\n\n When you are saving dialogue in a\n conference room, your buffer will\n hold a maximum of 80 lines at a time.\n However, you may wish to save more\n often than every 80 lines and later,\n edit the file to remove the duplicate\n lines.\n\n To view the files later, use any\n sequential file reader/printer, or\n word processor.  A sequential file\n reader, SPRINT, is included on all\n Q-Link V3 and V4 Program Disks.\n SPRINT may also be found and\n downloaded from the "Q-Link\n Utilities" section in COMMODORE\n SOFTWARE SHOWCASE''s Software\n Libraries under "Text File Readers."\n\n       <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (507479, 0, 0, '\n HOW TO USE CONFERENCE ROOMS \n\n These rooms are used for Special \n Interest Group conferences, club \n meetings, Tutoring Center classes, \n and more. You will know you have \n entered a conference room when you \n see "You are now in the conference \n area" at the top of your screen.  A \n maximum of 23 people may be in a \n conference room at one time. \n\n Once you''re in the conference room, \n press the F7 key for a menu of \n options. On the versions 3 and 4 \n Q-Link Program Disk, you have the \n options of "Q-Link Post Office" and \n "Identify Someone." \n\n On all versions of the Q-Link Program \n Disk, you have the option to "List \n people in this conference room." \n Choosing this option will let you see \n the screen names of the other people \n in the room with you. If the list is \n too long, use the up and down <CRSR> \n keys to scroll the list. You may keep \n this list on the screen and still \n participate in the room''s discussion. \n When someone enters or leaves the \n room, the change will be displayed on \n this list. \n\n You may talk in a conference room in \n the same way you talk in PEOPLE \n CONNECTION: simply type what you \n would like to say and press <RETURN>. \n You may use the up and down <CRSR> \n keys to scroll the screen and view \n what other members have typed.  If \n you have scrolled the screen up and \n then someone types a message, you \n will be automatically returned to the \n bottom of the screen. \n\n If you are using the "Q-Link Post \n Office" while in a conference room, \n you may not participate in the \n discussion. To talk in the conference \n room, you must have either the list \n of people in the room or the "You are \n now in the conference area" message \n on the top of your screen. \n\n Many groups which use conference \n rooms use what is known as \n "Conference Protocol." If protocol is \n being used, the protocol information \n will usually be displayed on your \n screen just before you enter the \n conference room. If the meeting is \n being conducted using protocol, \n please be sure that you use the \n protocol to enable everyone to get \n the most from the meeting. \n\n To leave a conference room, press F5. \n When asked if you want to leave the \n conference room, type "Yes." \n\n        <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (438114, 433696, 0, 'COMMODORE BUSINESS MACHINES, INC.\r\n          BACKGROUNDER\r\n\r\nSince naming 22-year industry veteran\r\nHarold D. Copperman President and\r\nChief Operating Officer of Commodore\r\nBusiness Machines Inc. in April, the\r\ncompany has moved aggrressively to\r\nrejuvinate a number of key marketing\r\ninitiatives, including consumer sales,\r\nbusiness, education and government.\r\n\r\nCentral to Copperman''s strategy has\r\nbeen to recruit a cadre of creative\r\nand experienced computer industry\r\nexecutives, including Vice\r\nPresident-Marketing C. Lloyd Mahhaffey\r\nwho formerly directed Apple''s\r\neducation and government marketing\r\nefforts.\r\n\r\nCopperman then appointed former Casio\r\nexecutive Bob Larson for Vice\r\nPresident-Consumer Sales and former\r\nApple colleague and University of\r\nIllinois vice chancellor Howard\r\nDiamond Director of Education. Randall\r\nGriffin left Compputer Sciences\r\nCorporation to join the company to\r\nhead its newly establish Federal\r\nSystems Group.\r\n\r\nJeff Scherb, formerly Vice President,\r\nDatabase and Data Communications\r\nDevelopment at Cullinet Software, and\r\nWalter Simpson, Director of Product\r\nMarketing at Prime Computer, joined\r\nthe team recently as Vice President of\r\nCommodore''s Application and Technical\r\nSupport (CATS) group and Director of\r\nProduct Marketing respectively.\r\n\r\nIn September Copperman followed\r\nthrough with his pledge to expand the\r\nreach of Commodore''s distribution\r\nchannels by announcing a major retail\r\nreseller agreement with Connecting\r\nPoint of America, Inc., to warehouse,\r\nredistribute and sell all Commodore\r\nAmiga and PC line hardware products.\r\nOther similar announcements are\r\nimminent.\r\n\r\nWhile the company places particular\r\nemphasis on its Amiga line of personal\r\ncomputers, it continues to actively\r\nsupport its entire family of machines.\r\nThey include the powerful MS-DOS (R)\r\ncompatible line and the popular 64\r\n(R)/128 (TM) line.\r\n\r\n\r\nTHE AMIGA LINE\r\n\r\n\r\nThe multimedia-oriented Amiga family\r\nof compputers combines versatility and\r\naffordability with powerful sound,\r\ncolor, video and animation\r\ncapabilities for a wide variety of\r\napplications, including desktop\r\npublishing, graphic design, music,\r\nvideo, and interactive applications.\r\n\r\nCommodore''s powerful Amiga computers\r\nare also distinguished by their\r\nadvanced multi-tasking operating\r\nsystem. This allows the user to\r\noperate more than one program\r\nsimultaneously, such as running a\r\ntelecommunications program, printing\r\n');
INSERT INTO `articles` VALUES (433696, 0, 438114, 'out letters via a mail merge program\nand inputting a word processing\nprogram.\n\nThe Commodore Amiga 500 (R) computer\nwas designed for home productivity,\neducation and entertainment\napplications, including home desktop\nvideo, animation, music composition\nand games. It provides state of the\nart computer performance, power and\nflexibility in a convenient and\nattractively priced package.\n\nThe Amiga 2000 (R), 2000HD (R),\n2500 (R) and 2500/30 (R) target\nbusiness, professional and education\nusers with applications ranging from\nvideo pre- and post-production ´o live\npresentations and CADroduction to live\npresentations and CAD engineering\nworkstations and can be expanded for\nMS-DOS compatibility.\n\n\nTHE MS-DOS COMPATIBLE LINE\n\n\nCommodore''s MS-DOS compatible line\nincludes the powerful Professional\nSeries III computers and the Commodore\nColt PC, an affordable home computer\nthat comes ready-for-use with\nWORDSTAR/COLT word pprocessing\nsoftware. All Commodore MS-DOS\ncompatible computers are fully\nexpandable and adaptable for a variety\nof applications.\n\nCommodore''s Professional Series III\ncomputers include the PC10-III (TM),\nPC20-III (TM) and PC40-III (TM)\nmodels. They feature reliable,\nhigh-speed performance needed to\nsupport advanced business productivity\nsoftware, as well as built-in graphic\nadapters, video and mouse interfaces\nand parallel and serial ports.\n\n\nTHE 64/128 LINE\n\n\nThis series of computers continues to\ngenerate a loyal and versatile\nfollowing of Commodore "enthusiasts"\nwith a worldwide user base of ten\nmillion. Each machine can be\ncustomized with a variety of hardware\nand peripheral options.\n\nThe Commodore 64C is an all-purpose\ncomputer for the home and school\nenvironment supported by more than\n10,000 software programs. The Commdore\n128 provides access to a wealth of\nbusiness, educational and recreational\nsoftware and operates in a unique\ntri-mode operating environment,\nallowing users to select any of three\ndifferent operating modes.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (398624, 0, 0, '          HAROLD COPPERMAN\nPRESIDENT AND CHIEF OPERATING OFFICER\n  COMMODORE BUSINESS MACHINES, INC.\n\nHarold D. Copperman was named\nPresident and Chief Operating Officer\nof Commdore Business Machines, the\nUnited States subsidiary of Commdore\nInternational Limited, on April 24,\n1989.\n\nCopperman, 42, was formerly Vice\nPresident and General Manager, Eastern\nOperations, Apple Computer, Inc., a\nposition he held since joining the\ncompany in September 1987. His\nresponsibilities included sales,\nmarketing support and distribution for\nApple''s Eastern Region. He also\nmanaged Apple''s Federal Systems Group.\n\nCopperman also served with\nInternational Business Machines for\ntwenty years, most recently as\nNational Director of Marketing for the\ncompany''s Academic Information Systems\nBusiness Unit. He joined IBM as a\nSystems Engineer in 1967. From\n1970-1982, he worked for IBM''s Data\nProcessing Division and held a variety\nof sales, marketing and management\npositions. In 1983, he joined IBM''s\nNational Marketing Division, where he\nwas named Director of Marketing,\nfollowed by appointment as Regional\nManager. In 1986, he assumed national\nresponsibility for IBM''s sales and\nmarketing in higher education.\n\nA graduate of Rutgers University,\nCopperman holds a B.S. in Mechanical\nEngineering.\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (434273, 0, 0, '         ROBERT J. LARSEN\n  VICE PRESIDENT OF CONSUMER SALES\n  COMMODORE BUSINESS MACHINES, INC.\n\nRobert J. Larsen was named Vice\nPresident of Consumer Sales of\nCommodore Business Machines, the\nUnited States Subsidiary of Commodore\nInternational Limited, on July 28,\n1989.\n\nLarsen, who was Senior Vice President\nof Casio, Inc. with responsibility for\nthe Electronic Musical Instruments and\nProfessional Dealer Products\nDivisions, brings to Commodore more\nthan 25 years of experience in\nelectronics design, manufacturing,\nmarketing, sales and business\nmanagement. During his tenure at\nCasio, Larsen directed the growth of\nthe company''s music business from zero\nto over $200 million, representing a\n55 percent share of the market.\n\nFrom 1967 to 1973 Larsen was employed\nby Whippany Electronics Inc. as\nEngineer, followed by an appointment\nto Assistant General Manager. Prior\nto his tenure at Casio, Larsen served\neight years with Artisan Electronics\nCorp., finishing his term there as\nMarketing Manager in 1980.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (449800, 0, 0, '         C. LLOYD MAHAFFEY\n      VICE PRESIDENT MARKETING\n  COMMODORE BUSINESS MACHINES, INC.\n\nC. Lloyd Mahaffey, Vice President,\nMarketing, joined Commodore Business\nMachines in July of 1989.\n\nPrior to Commodore, he spent 6 years\nwith Apple Computer, Inc. in a range\nof sales and marketing assignments\nincluding Regional Sales Manager,\nSoutheastern United States, Director,\nUS Education Sales and Marketing in\nCupertino, California, and most\nrecently, Director, Federal Systems\nGroup in Washington, D.C. During his\ntenure, Mr. Mahaffey was responsible\nfor much of the success that Apple has\nenjoyed within these two strategic\nmarkets.\n\nAdditional experiences include Branch\nSales and Marketing Manager for\nHoneywell''s Control Systems Division\nand Director, Corporate Systems for\nPCA International, a multi-national\nmanufacturing firm located in\nCharlotte, N.C.\n\nMr. Mahaffey, 34, is a graduate of The\nCitadel and Stanford University.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (442299, 0, 0, '      COMMODORE(R) REWARDS USERS\n    WITH INSIDE TRACK ON AMIGA 3000\n\nWest Chester, PA. April 29, 1991 --\nCommodore''s new Amiga(R) Power Up\nProgram for current users means\ntrade-up, not trade-in.\n\nThe unique trade-up program launched\ntoday does not require customers to\ngive up their current Commodore CPUs.\nExisting system ownership qualifies\ncustomers to purchase the company''s\nmost powerful CPU, the Amiga 3000, at\nsavings up to $1500 from the\nmanufacturer''s suggested retail price.\n\nThe Commodore and Commodore-Amiga\nproducts that are eligible to be used\nin the Power Up Program are:\nVIC-20(R), Commodore 64(R), Commodore\n128(TM), or Amiga 500, 1000, or 2000\nseries microcomputers.  To prove\ncurrent ownership of a Commodore CPU,\nowners are required to write the\nserial number of their CPU on the\ncover of the original owner''s manual.\nThe cover is then submitted with your\norder for an A3000 to your\nparticipating authorized Commodore\ndealer.  The program''s trade-up values\nare assigned to the purchase of new\nAmiga 3000 series systems.\n\nThe Amiga Power Up Program provides up\nto the following savings:\n\nCPU Model#     MSRP  Power-Up Savings\n\nA3000 16/50   $2,999      $1,150\n\nA3000 25/50   $3,499      $1,250\n\nA3000 25/100  $4,699      $1,500\n\n"The Amiga Power Up Program is\ndesigned for the widest acceptance and\nsupport from our existing customer\nbase," said David Archambault,\ndirector of business marketing.  "The\nprogram is both a reward and an\nincentive.  It rewards our user base\nwith the option for saving money and\nencourages ownership of the\nversatility provided by the most\nadvanced technology Commodore offers."\n\nThe offer is available until June 30,\n1991 at participating Commodore\ndealers.  Contact your authorized\nCommodore dealer for additional\ndetails.\n\nCall 1-800-66-AMIGA to locate your\nnearest dealer.\n\nCommodore Business Machines, Inc.,\nbased in West Chester, Pa.,\nmanufactures a complete line of\ncomputers for the business, education,\ngovernment and consumer markets.\n\nCommodore (R), Commodore 64(R),\nCommodore 128(TM), and VIC-20(R) are\ntrademarks of Commodore Electronics\nLimited.  Amiga(R) is a trademark of\nCommodore-Amiga, Inc.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (446963, 0, 0, '    COMMODORE APPOINTS DIONNE AND\n     COPPERMAN TO NEW POSITIONS\n\nNEW YORK, N.Y., January 4, 1991 --\nCommodore International Limited\n(NYSE:CBU) announced today the\nappointment of James Dionne as General\nManager of its U.S. sales company,\nsucceeding Harold Copperman, who has\nbeen appointed Vice President of\nCommodore International Limited, with\nnew responsibilities, including Amiga\nmultimedia strategies.\n\nMr. Dionne has been with Commodore\neleven years, most recently as General\nManager of Commodore''s Canadian sales\nsubsidiary. Mr. Copperman joined\nCommodore in 1989.\n\nCommodore also announced a reduction\nwas being made in the manpower of the\nU.S. operations, primarily in the\nareas of administration and factory\noverhead. This action is partly due to\nthe reorganization of certain\nfunctions and is expected to result in\nimproved operating efficiency.\n\nCommodore International Limited,\nthrough its operating subsidiaries\naround the world, manufactures and\nmarkets personal computers to\ncustomers in the consumer, education,\nprofessional and government market\nsectors. The company has three product\nlines: Amiga multimedia computers, PC\ncompatibles and C64 computers.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (100327, 77307, 0, '   VIRGINIA TECH CHOOSES COMMODORE\r\n         FOR UNIX PLATFORM\r\n  REPLACES MAC AS REQUIRED MACHINE\r\n    FOR COMPUTER SCIENCE MAJORS\r\n\r\nWEST CHESTER, PA., August 7, 1990\r\nCommodore Business Machines, Inc.\r\nlaunched its effort to bring UNIX into\r\neducation with the delivery of its\r\nfirst order of UNIX-based Amiga\r\ncomputers to Virginia Polytechnic\r\nInstitute and State University\r\n(Virginia Tech).\r\n\r\nThe university, which for the last\r\nthree years has required incoming\r\ncomputer science majors to buy Apple''s\r\nMacintosh running A/UX, chose instead\r\nCommodore''s Amiga 3000 with AT&T''s\r\nUNIX System V.4 operating system after\r\nseeing the power and capabilities of\r\nthe new Commodore Amiga 3000 with a\r\nUNIX implementation.\r\n\r\nVirginia Tech''s purchase comes during\r\nthe product''s beta test phase, in\r\npreparation for this fall''s worldwide\r\nAmiga 3000 UNIX launch. Following that\r\nlaunch, Amiga UNIX platforms will be\r\nmade available to the education\r\ncommunity at large.\r\n\r\n"This is a significant win for\r\nCommodore, because it clearly\r\ndemonstrates the power and\r\nprice-perfomance superiority of the\r\nAmiga 3000," said Howard Diamond,\r\nCommodore''s Director of Education.\r\n"The marriage of the Amiga and V.4\r\ntechnology is an exciting development\r\nfor us and for our customers in higher\r\neducation and other markets," he\r\nadded.\r\n\r\n"Commodore''s UNIX passed every one of\r\nour tests," said Dr. James Arthur,\r\nchairman of the computer science\r\ndepartment''s selection committee.\r\n"From the Amiga technology to V.4\r\ndelivery to the Amiga''s unbeatable\r\nprice performance, Amiga UNIX was the\r\nclear choice for our department. We''re\r\nalso very pleased with Commodore''s\r\nwillingness to work closely with us\r\nto produce a solution tailored to our\r\nneeds."\r\n\r\nUNIX technology is significant because\r\nit establishes common standards for\r\nthe exchange of information between\r\ndissimilar jardware systems, an\r\nespecially critical need for computer\r\nscience and other university\r\ndepartments.\r\n\r\nCommodore''s configuration is also\r\nimportant because version V.4''s "open\r\nsystem" integrates into one package\r\nall the features of the various UNIX\r\ntechnologies and is expected by many\r\nto become the standard to which future\r\nsystems will comply. In fact, over 150\r\ncompanies have declared their support\r\nfor V.4.\r\n\r\nSince 1985, Virginia Tech has required\r\nits incoming computer science students\r\nto purchase a personal computer. UNIX\r\nwas selected as the operating system\r\nstandard because it provides an ideal\r\n');
INSERT INTO `articles` VALUES (77307, 0, 100327, 'environment for experimentation and\nbecause it is largely\nplatform-independent.\n\nOver the years, technology advances\nhave prompted constant re-evaluation\nof the required platform. The\nselection of the Commodore Amiga is a\nrealization of that re-evaluation\nprocess.\n\nAccording to Dr. Arthur, Virginia Tech\nis the only university in the country\nwhich requires its computer science\nmajors to purchase a particular UNIX\nplatform. Computer science students\nbecome intimately familiar with the\nUNIX operating system and underlying\nconcepts found on a wide range of\ncomputers from mainframes to micros,\nand will use the Amiga to perform\nhomework, in-class projects and term\npapers.\n\nCommodore Business Machines, Inc.,\nbased in West Chester, Pa.,\nmanufactures and markets a complete\nline of computers and peripherals for\nthe business, education, government\nand consumer markets.\n\nThe multi-tasking Amiga line includes\nthe Commodore Amiga 500 (TM), the\nCommodore Amiga 2000 (TM) and three\nenhanced products: The Commodore Amiga\n2000HD (TM), the Commodore Amiga 2500\n(TM), the Commodore Amiga 2500/30\n(TM), and the Amiga 3000 (TM).\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (80619, 0, 0, '      LETTER TO DEVELOPERS FROM\n      JEFF SCHERB, COMMODORE''S\n      VICE PRESIDENT-COMMODORE\n      APPLICATION AND TECHNICAL\n      SUPPORT (CATS)\n\nThe following is a letter to\ndevelopers from Jeff Scherb in\nresponse to an erroneous report\nregarding the company''s support for\nCDTV -- the company''s CD-ROM product\n-- currently in development.\n\n\nAugust 9, 1990\n\nDear Developer:\n\nA small news item appeared recently in\nVideo Games and Entertainment Magazine\nwhich had all of West Chester in quite\nan uproar. The headline was "Commodore\nPulls The Plug On Entertainment\nSoftware." This article claimed that\nCommodore had recently sent letters to\nall entertainment software houses\ncurrently developing software for the\nAmiga "game machine" (CDTV), informing\nthat we were concentrating not on\nentertainment, but only on education.\n\nNOTHING COULD BE FURTHER FROM THE\nTRUTH. As you all know, the Amiga has\nachieved the level of popularity it\nhas (1.8 million machines as of June,\n1990) because it is the best home\nentertainment and game machine on the\nmarket, regardless of price. Te main\ntarget audience for CDTV is the group\nof adults who want to provide their\nfamilies with interactive multimedia\ninformation, education, and\nentertainment. Clearly, entertainment\nand game software will be a key reason\nfor buying the CDTV machine.\n\nGail Wellington and the entire CDTV\ncrew are very interested in hearing\nfrom you regarding development\nprojects for CDTV. They are looking\nfor education, information,\nentertainment and game titles which\nwill provide compelling reasons for\nconsumers to adopt this new\ntechnology.\n\nAs always, the applications will drive\nthe market for the machine, and\nCommodore is very interested in\nworking with Amiga developers in\nexploring this new market.\n\nSincerely,\n\nJeff Scherb,\nVice President Applications and\nTechnical Support\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (32237, 5422, 0, 'COMMODOREEXPRESS EXPANDS COVERAGE\r\n\r\nCommodoreExpress is an innovative\r\nsupport program offered by Commodore\r\nBusiness Machines through Federal\r\nExpress(R). The program provides the\r\nConsumer Product end user with an\r\n800 number "Helpline" 24 hours a day.\r\n365 days a year. Trained professional\r\nsupport specialists are available to\r\nanswer questions ranging from "How to\r\nHook Up the System" to analyzing\r\nequipment in need of service.\r\n\r\nThis program is available to end users\r\nwho have bought machines marketed by\r\nCommodore Business Machines. Pickup is\r\navailable from locations throughout\r\nthe United States.\r\n\r\nThrough Federal Express, Commodore\r\nwill arrange FREE pick-up of defective\r\nproduct, repair or replace and return\r\nthe product AT NO CHARGE to the end\r\nuser during the warranty period. The\r\nsame service will become available for\r\nout-of-warrany products AT A CHARGE by\r\nAugust 13, 1990.\r\n\r\nFor in-warranty machines,\r\nCommodoreExpress will arrange for FREE\r\npick-up and return of the defective\r\nproduct through Federal Express. The\r\nproduct will be repaired or replaced\r\nat NO CHARGE to the end user. (All\r\nin-warranty repairs REQUIRE written\r\nproof of purchase dated within the\r\nwarranty period to accompany the\r\nreturned product).\r\n\r\nFor out-of-warranty machines,\r\nCommodoreExpress will arrange for\r\npick-up and return of equipment.\r\nTransportation method will be chosen\r\nand paid for by the owner of the\r\nequipment. A CommodoreExpress support\r\nspecialist will quote\r\n"out-of-warranty" repair charges that\r\nmay be paid by Visa or MasterCard\r\nprior to pick-up of the equipment, or\r\nthe end user may send a personal check\r\nwith the equipment to be repaired.\r\nBoth transportation and repair of\r\nequipment may be paid by Visa,\r\nMasterCard or personal check. C.O.D.\r\nservice is available at an extra\r\ncharge.\r\n\r\n\r\nThe products covered by\r\nCommodoreExpress are:\r\n\r\n\r\nThe Amiga Consumer Line:\r\n\r\n\r\nAmiga 500 Computer\r\n\r\nAmiga 1010 and 1011 Disk Drives\r\n\r\nAmiga 590 Hard Drive\r\n\r\nAmiga 501 Memory Expander\r\n\r\nAmiga 520 RF Modulator\r\n\r\n1084 Monitor (including 1084S)\r\n\r\nAmiga 1680 Modem\r\n\r\nAmiga 500 Mouse\r\n');
INSERT INTO `articles` VALUES (5422, 0, 32237, '\nMPS-1230 Printer\n\n\nThe C64 Line:\n\n\nC64 Computer\n\n1541 Disk Drive (including 1541-II)\n\n1764 Ram Expansion Unit\n\n1802 Monitor\n\n1670 Modem\n\n1351 Mouse\n\nMPS-1230 Printer\n\n\nThe Select Edition (MS-DOS) Line:\n\n\nSelect Edition Computers (All Models)\n\nCommodore Colt Computers (All Models)\n\nCommodore 992 Hard Drive\n\n1402 and 1403 Monitors\n\n1352 Mouse\n\nMPS-1230 Printer\n\n\nCommodoreExpress is a toll-free\nservice at 1-800-448-9987.\n\n\nCommodore Business Machines, Inc.,\nbased in West Chester, Pa.,\nmanufactures and markets a complete\nline of computers and peripherals for\nthe business, education, government\nand consumer markets.\n\nThe multi-tasking Amiga line includes\nthe Commodore Amiga 500 (TM), the\nCommodore Amiga 2000 (TM) and three\nenhanced products: The Commodore Amiga\n2000HD (TM), the Commodore Amiga 2500\n(TM) and the Commodore Amiga 2500/30\n(TM). Commodore''s line of MS-DOS (R)\ncompatible computers includes the\nSelect Edition (TM) and Professional\nSeries III (TM).\n\nMS-DOS is a registered trademark of\nMicrosoft Inc.\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (833052, 794784, 0, 'BUNDLED SYSTEMS\r\n\r\nAMIGA BUNDLED SYSTEMS\r\n\r\nAmiga 500 System:\r\n\r\nAmiga 500P\r\nA501 Memory Expander\r\nA1011 External Drive\r\nA1084S Monitor\r\nAmigaVision Software\r\n\r\nList price $1397\r\nEducation price $799\r\n\r\n\r\nAmiga 2000 System\r\n\r\nAmiga 2000\r\nA2010 Internal Drive\r\nA2088D XT Bridgebaord\r\nA1084S Monitor\r\nAmigaVision Software\r\n\r\nList price $3152\r\nEducation price $1599\r\n\r\n\r\nAmiga 2000HD System\r\n\r\nAmiga 2000HD\r\nA2286D AT Bridgeboard\r\nA1084S Monitor\r\nAmigaVision Software\r\n\r\nList price $4697\r\nEducation price $2579\r\n\r\n\r\nAmiga 2500/30 System\r\n\r\nAmiga 2500/30\r\nA2286D AT Bridgeboard\r\nA1084 Monitor\r\nAmigaVision Softwaºe\r\n¿List price $6697\r\nEducation price $3679\r\n\r\n\r\nAmiga 3000/16-40 System\r\n\r\nAmiga 3000/16-40\r\nA1950 Monitor\r\nAmigaVision Software\r\n\r\nList price $4098\r\nEducation price $2599\r\n\r\n\r\nAmiga 3000/25-40 System\r\n\r\nAmiga 3000/25-40\r\nA1950 Monitor\r\nAmigaVision Software\r\n\r\nList price $4798\r\nEducation Price $3039\r\n\r\n\r\nPROFESSIONAL SERIES BUNDLED SYSTEMS\r\n\r\nPC20-III System\r\n\r\nPC20-III\r\n1352 Mouse\r\nMicroSoft Works\r\nDOS Tutor\r\n\r\nList price $1349\r\nEducational price $819\r\n');
INSERT INTO `articles` VALUES (794784, 0, 833052, '\n\nPC40-III System\n\nPC40-III\n1352 Mouse\nMicroSoft Windows\nDOS Tutor\nAmi WordPro\n\nList price $2399\nEducational price $1319\n\nC64 BUNDLE\n\nC64/1541-II        499        249\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (790157, 0, 0, 'INDIVIDUAL CPU''S\n\nPROFESSIONAL SERIES CPU''S\n\nCPU               List     Education\n\nPC10-III-U1       $949       $519\n\nPC10-III-U6       1099        599\n\nPC60-III          4999       2749\n\nPC60-III-80       5999       3299\n\nPC60-III-200      7499       4129\n\n\nAMIGA CPU''S\n\nA500P              799        479\n\nA2000             1895       1139\n\nA2000HD           2699       1619\n\nA2500/30          4699       2819\n\nA3000/16-40       3299       2179\n\nA3000/25-40       3999       2619\n\nA3000/25-100      4499       3059\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (837282, 0, 0, 'INDIVIDUAL COMPONENTS\n\nMONITORS\n\nA10 Stereo          39         29\nSpeakers\n\n1950 MultiSync     799        519\n\n1930 VGA           649        419\n\nA2024 Mono         749        489\n\n\nINDIVIDUAL COMPONENTS\n\nA520                49         29\n\nA501               199        129\n\nA590               629        409\n\nA1011              199        129\n\nA1084S             399        259\n\nA1680               99         69\n\nA2010              159        109\n\nA2058/2            649        429\n\nA2091-40           899        589\n\nA2088D             699        459\n\nA2232              399        259\n\nA2286D            1599       1039\n\nA2300              299        199\n\nA2630             1999       1299\n\n\nAMIGA NEW PRODUCTS\n\nAS250              149         99\nAmigaVision\n\nAS225              199        129\nNFS-TCP/IP\n\nAS220              149         99\nAmiga Client software for\nNovell Netware\n\nA2060 ARCNET       229        149\n\nA2065 ETHERNET     349        229\n\nNote: Individual peripherals must\nbe purchased in conjunction with a\nCPU to qualify for educational\npricing.\n\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (827252, 837485, 0, '   COMMODORE EXTENDS POPULAR AMIGA\r\n PRODUCT LINE INTRODUCES AMIGA 3000\r\n        AT "MULTIMEDIA LIVE"\r\n\r\n   (EXPECTED SHIP DATE: JULY 1990)\r\n\r\nNEW YORK, NY -- April 24, 1990 --\r\nCommodore Business Machines President\r\nHarold Copperman and his aggressive\r\nnew management team today dramatically\r\ndefined multimedia as the company\r\nintroduced the latest in its popular\r\nline of Amiga personal computers at a\r\nlive multimedia demonstration at the\r\nPalladium. The powerful and elegant\r\nnew Amiga (R) 3000 brings enhanced\r\nperformance capabilities and a new\r\nAmigaDOS (TM) 2.0 to the company''s\r\nline of multimedia products.\r\n\r\n"The 3000 marks the first step in our\r\nnew Amiga product marketing strategy\r\nand reinforces our serious bid to\r\ncapture greater market share within\r\nthe business, government and higher\r\neducation markets," said Commodore\r\nVice President of Marketing C. Lloyd\r\nMahaffey. "We''ve delivered an\r\nincredibly competitive hardware system\r\nfeaturing lower cost, higher\r\nperformance and added communications\r\ncapabilities."\r\n\r\nMahaffey said key product features\r\ninclude a 16 or 25 MHz, 68030 Motorola\r\nprocessor, a 68881 or 68882 math\r\ncoprocessor, a true 32-bit\r\narchitecture, 2 MB of memory standard\r\n(with address space of over one\r\ngigabyte) and, as in all Amigas, true\r\nmultitasking capability. The standard\r\nAmiga 3000 comes with a 40 MB hard\r\ndrive and a 3.5-inch floppy disk drive\r\nand features a SCSI interface for\r\nadded communication capability.\r\nCommodore also offers a 100 MB\r\nconfiguration.\r\n\r\nSuggested retail price is $3,299 for\r\nthe 16 MHz version, $3,999 for the 25\r\nMHz version and $4,499 for the 100 MB\r\nversion. Shipments are expected to\r\nbegin in July. Demonstration units are\r\navailable at participating Authorized\r\nCommodore Amiga Reseller locations.\r\n\r\nCommodore Director of Product\r\nMarketing Walt Simpson said the\r\nprice/performance of the A3000 results\r\nfrom the effective integration of the\r\nAmiga''s three custom chips with five\r\nnew custom gate arrays which serve a\r\nvariety of functions including bus\r\narbitration, RAM memory handling,\r\nSCSI device handling and video\r\nenhancing.\r\n\r\nThe Amiga 3000 also features a new\r\noperating system, AmigaDOS 2.0, which\r\nsignificantly enhances the look and\r\nfunctionality of the platform, Simpson\r\nsaid. Besides the new look, standards\r\nhave been created for all system\r\nutilities, icons, requester and\r\ngadgets to permit ease-of-use by both\r\nusers and programmers, he said.\r\n\r\nIn addition, Commodore announced the\r\ninclusion of the AREXX (TM)\r\ninterprocess communications protocol\r\nand programming language. The\r\n');
INSERT INTO `articles` VALUES (837485, 0, 827252, 'integration of AREXX into the AmigaDOS\noperating system will facilitate the\ncontrol of external programs from\nwithin any application supporting\nAREXX, Simpson said. This feature,\ncoupled with Commodore''s new\nAmigaVision (TM) authoring system,\ncreates a powerful multitasking\nenvironment for the creation of\nmultimedia presentations.\n\nAlong with the A3000 announcement,\nCommodore introduced a number of\nstrategic software and peripheral\nproducts, including:\n\no AmigaVision authoring system;\n\no Networking products providing\nconnectivity with Arcnet, Novell (R)\nNetWare, Ethernet, TCP/IP and NFS\nstandards;\n\no Monitors, including 2024 high\nresolution monochrome and 1950 color\nmultiscan; and\n\no Commodore Amiga 10 Stereo Audio\nCompact Speakers.\n\nCommodore further announced an\nAmigaDOS 2.0 enhancer ket for the\nA2000 series machines to be available\nin September.\n\nCommodore Business Machines, Inc.,\nbased in West Chester, Pa.,\nmanufactures and markets a complete\nline of computers and peripherals for\nthe business, education, government\nand consumer markets.\n\nThe multi-tasking Amiga line includes\nthe Commodore Amiga 500 (TM), the\nCommodore Amiga 2000 (TM) and three\nenhanced products: The Commodore Amiga\n2000HD (TM), the Commodore Amiga 2500\n(TM) and the Commodore Amiga 2500/30\n(TM). Commodore''s line of MS-DOS (R)\ncompatible computers includes the\nSelect Edition (TM) and Professional\nSeries III (TM).\n\nFor more information on the Amiga\n3000, contact Walt Simpson, director\nof product marketing, Commodore\nBusiness Machines, 1200 Wilson Drive,\nWest Chester, PA 19380 or call\n215-431-9100.\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (845424, 797799, 0, '        COMMODORE UNVEILS NEW\r\n  AMIGAVISION (TM) AUTHORING SYSTEM;\r\n   INNOVATIVE TOOL PROVIDES KEY TO\r\n       MULTIMEDIA APPLICATIONS\r\n\r\n    (Expected ship date: May 1990)\r\n\r\nNEW YORK, NY --April 24, 1990--\r\nCommodore Business Machines President\r\nHarold Copperman today strengthened\r\nthe company''s leadership position in\r\nthe multimedia market by introducing\r\npowerful multimedia authoring\r\nsoftware. The system can be used to\r\ncreate innovative applications ranging\r\nfrom complex business presentations to\r\ndaily courseware.\r\n\r\nCommodore Vice President of Marketing\r\nC. Lloyd Mahaffey said the new\r\nsoftware system, called AmigaVision\r\n(TM), significantly expands the\r\nmultimedia market by providing an easy\r\nto use and affordable method for\r\nbusiness, education, government and\r\nconsumer users to develop new\r\napplications by creatively combining\r\ngraphics, text, video and audio\r\ncomponents. Shipping is expected to\r\nbegin in May.\r\n\r\nThe announcement was made as part of a\r\nlive multimedia presentation at the\r\nPalladium. The company also introduced\r\nthe latest in its Amiga (R) family of\r\ncomputers, the Amiga 3000, and a full\r\nline of networking products.\r\n\r\nPreviously the domain of programmer-\r\nlevel professional users, multimedia\r\ncan now be a tool for creative\r\nteachers, presentation professionals,\r\ncomputer-based trainers, instruction\r\nspecialists as well as exhibit and\r\ndisplay professionals. AmigaVision\r\ndoes not require previous programming\r\nexperience and is operable through an\r\nintuitive user interface.\r\n\r\nMahaffey said the Amiga is the only\r\ncomputer that was originally designed\r\nas a multimedia class machine.\r\n\r\n"AmigaVision is a significant\r\ndevelopment in multimedia," said Tim\r\nBajarin, vice president of Creative\r\nStrategies International, a Santa\r\nClara, Calif.-based research firm, and\r\npublisher of MULTIMEDIA COMPUTING AND\r\nPRESENTATIONS. "With today''s round of\r\nannouncements, Commodore is positioned\r\nto make a major play for PC sales\r\nwithing this growing market."\r\n\r\nDavid Archambault, director of\r\nbusiness markets, said AmigaVision\r\ntakes full advantage of the Amiga''s\r\nbuilt-in graphics, video and music\r\ncapabilities. The system uses the\r\nAmiga''s native multitasking capability\r\nto allow users to run programs\r\nsimultaneously. Unlike other authoring\r\nsystems, AmigaVision is a\r\nnon-intrusive environment which allows\r\napplications to run without the\r\nAmigaVision menus being visible.\r\nEnhanced design capabilities allow for\r\nimmediate on-screen preview while the\r\npresentation program is running. This\r\nallows the user to create unique user\r\ninterface elements quickly and with\r\n');
INSERT INTO `articles` VALUES (797799, 0, 845424, 'ease.\n\nAmigaVision provides a flow-chart type\niconic interface programming\nenvironment featuring a single control\nscreen/menu. The operating system''s\nAREXX (TM) communications protocol\nsupport allows applications to\ninteract with programs in the same or\nother networked machines.\n\nThe system will be bundled with all\nAmiga 2000 and 3000 series machines.\nFor existing owners, AmigaVision is\navailable at Authorized Commodore\nAmiga Resellers for a suggested retail\nof $149.\n\nMahaffey said AmigaVision is a key\ncomponent of Commodore''s product\nmarketing strategy for the Amiga\nfamily. While professional users\ncomprise the majority of multimedia-\nrelated markets today, future plans\ncall for penetration into the consumer\nmarkets as home users begin to\ndiscover the benefits of multimedia.\n\nFor more information on AmigaVision\n(TM), contact David Archambault,\ndirector of business markets,\nCommodore Business Machines, 1200\nWilson Drive, West Chester, PA 19380\nor call 215-431-9100.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (788166, 803440, 0, ' COMMODORE ADDS EXTENSIVE NETWORKING\r\n   CAPABILITIES ANNOUNCES PLANS TO\r\n     EXPAND GROWING AMIGA MARKETS\r\n\r\n    (Expected ship date: June 1990)\r\n\r\nNEW YORK, NY --April 24, 1990 --\r\nCommodore Business Machines President\r\nHarold Copperman today introduced a\r\nwide variety of networking\r\ncapabilities for the company''s popular\r\nline of Amiga personal computers\r\nduring a spectacular multimedia\r\npresentation at the Palladium. The\r\ncompany also unveiled the newest\r\naddition to the Amiga family, the\r\nAmiga 3000, and a new multimedia\r\nauthoring system called AmigaVision\r\n(TM).\r\n\r\nCommodore Vice President of Marketing\r\nC. Lloyd Mahaffey said the\r\nannouncements are a key component in\r\nCommodore''s strategy to significantly\r\npenetrate the business, higher\r\neducation and government markets. He\r\nsaid today''s introduction marks the\r\nfirst time Commodore has marketed\r\nAmiga networking products. Shipping is\r\nexpected to begin in June.\r\n\r\n"Adding networking capabilities to the\r\nAmiga has been a priority since our\r\nteam took over at Commodore last\r\nspring," Mahaffey said. "We''re\r\nconvinced that this added capability\r\nwill greatly anhance the appeal of the\r\nAmiga in an office or campus\r\nenvironment and increase our\r\ncompetitiveness in the U.S. market."\r\n\r\nNetworking products introduced today\r\ninclude the following:\r\n\r\no The A2065 Ethernet Network Adaptor\r\n\r\nThe Amiga Ethernet Network Adaptor\r\nruns at 10 megabits per second and\r\nprovides full ANSI 802.3 type Ethernet\r\nprotocols over both thick and thin\r\nEthernet connections. The networking\r\nproduct gives Amiga users access to\r\nthe widely installed Ethernet\r\nnetworking standard.\r\n\r\nSuggested retail price is $349.\r\n\r\n\r\no The A2060 Arcnet Network Adaptor\r\n\r\nThe Arcnet Network Adaptor, now\r\navailable for the Amiga, provides full\r\nArcnet bus protocols over Arcnet bus\r\ntopology networks. The 2.5 Mbps Arcnet\r\nNetwork Adaptor supports up to 256\r\nnodes and features a socket for\r\noptional autoboot ROM. It also\r\nprovides buffered memory to enhance\r\ninter-system communications.\r\n\r\nSuggested retail price for the A2060\r\nis $229.\r\n\r\n\r\no The AS220 Amiga Client for Novell\r\n(R) NetWare\r\n\r\nWith Commodore''s introduction of the\r\nAmiga Client for NetWare, the Amiga\r\nnow has the caoability of utilizing\r\nCommodore''s A2060 adaptor to\r\n');
INSERT INTO `articles` VALUES (803440, 0, 788166, 'communicate with Novell Networks\nrunning Novell NetWare Version 2.15 or\nhigher. The software features password\nsecurity and provides the user with\ntwo interfaces: a text-oriented\ninterface or the Amiga mouse-based\ninterface. Users can utilize the\nAmiga''s multitasking feature to\nsimultaneously run other programs\nunder AmigaDOS and/or the MS-DOS with\nAmiga Bridgeboard (TM) options.\n\nSuggested retail price is $149.\n\n\no TCP/IP and NFS Software\n\nTCP/IP and NFS software provide the\nAmiga with connectivity to DoD and\nother networks which support either of\nthese standard packet-switching\nprotocols. This new software for the\nAmiga will provide users with access\nto the widely installed far-reaching\ncommunications networks employing the\nTCP/IP standard.\n\nSeveral developers for the Amiga are\nalready supporting TCP/IP and/or NFS\nfor their networking software\nproducts. These include the X-Windows\nSystem (TM) from GfxBase and TSSnet\nfrom Syndesis.\n\nSuggested retail for the TCP/IP and\nNFS software is $199.\n\n\nOther networking solutions currently\navailable for the Amiga platform\ninclude:\n\no DECnet.\n\nTSSnet (Thursby Software Systems),\nan Amiga implementation of DECnet\n(Digital Network Architecture),\nis available from Syndesis\nCorporation.\n\n\no X-Window System.\n\nThe X-Window System, available from\nGfxBase, enables computers to run\napplications on other machines while\ndisplaying the program''s output and\ninterfacing with the program from\ntheir Amiga system.\n\n\no Peer-to-Peer Network.\n\nA peer-to-peer network, manufactured\nby UK-based Hydra Systems, provides\ncommunication capabilites for Amigas\nsharing hard and floppy disk drives as\nwell as devices connected to an\nAmiga''s parallel or serial ports\n(printers, modems, etc.).\n\nFor more information on Commodore\nnetworking capabilities, contact Walt\nSimpson, director of product\nmarketing, Commodore Business\nMachines, 1200 Wilson Drive, West\nChester, PA 19380 or call\n215-431-9100.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (788720, 828511, 0, '  COMMODORE/FEDERAL EXPRESS ANNOUNCE\r\nUNPRECEDENTED CUSTOMER SERVICE PROGRAM\r\n\r\n\r\nWest Chester, PA., April 19, 1990 --\r\nCommodore Business Machines, Inc.\r\ntoday announced the establishment of\r\nCommodore Express(TM), a new\r\n24-hour toll-free "helpline" and\r\ndoor-to-door customer service\r\nprogram. The service is being offered\r\nto new Amiga 500 owners in the U.S. in\r\ncooperation with Federal Express\r\nCorporation.\r\n\r\n"Commodore is dedicated to customer\r\nsatisfaction," said Jim Reeder,\r\nCommodore vice president for customer\r\nsatisfaction. "Commodore Express\r\nis the first of a number of innovative\r\nnew services to be offered by\r\nCommodore in support of that\r\ncommitment."\r\n\r\nCommodore Express is part of an\r\naggressive new customer service\r\npackage designed with the home\r\ncomputer user in mind. The program\r\nwas developed by Commodore in\r\nconjunction with the company''s recent\r\nintroduction of the Amiga 500 into\r\nthe consumer channel.\r\n\r\nThe comprehensive program includes:\r\n\r\n* A 24-hour toll-free "helpline"\r\n  service offering new Amiga 500\r\n  owners the availability of ongoing\r\n  assistance in setting up and\r\n  operating their Amiga 500s; and\r\n\r\n* Free pick-up and return computer\r\n  delivery for in-warranty repairs.\r\n\r\nCommodore Express'' free pick-up and\r\nreturn service applies to in-warranty\r\nrepairs only and requires\r\nproof-of-purchase. This program will\r\nbe made available to all Amiga 500\r\nowners in the U.S. who purchased their\r\ncomputer after January 1, 1990.\r\n\r\n"Setting up and operating a computer\r\ncan be intimidating, especially for\r\nnew users," Reeder said, adding that\r\neven the simplest manual is often too\r\ntechnical. "Commodore Express makes\r\nthe prospect of owning a computer\r\neasier by providing home users with\r\nongoing service and support that\r\nlasts long after the sale."\r\n\r\nFurther details regarding this program\r\nare available by contacting\r\nCommodore''s Customer Satisfaction\r\nDepartment at 1200 Wilson Drive,\r\nWest Chester, PA 19380.\r\n\r\nCommodore Business Machines, Inc.,\r\nbased in West Chester, Pa.,\r\nmanufactures and markets a complete\r\nline of computers and peripherals for\r\nthe business, education, government\r\nand consumer markets.\r\n\r\nThe multi-tasking Amiga line includes\r\nthe Commodore Amiga 500(TM), the\r\nCommodore Amiga 2000(TM) and three\r\nenhanced products: The Commodore Amiga\r\n2000HD(TM), the Commodore Amiga\r\n2500(TM) and the Commodore Amiga 2500\r\n');
INSERT INTO `articles` VALUES (828511, 0, 788720, '/30(TM). Commodore''s line of MS-DOS(R)\ncompatible computers includes the Colt\n(TM) and Professional Series III(TM).\n\nMS-DOS is a registered trademark of\nMicrosoft, Inc.\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (422973, 0, 0, ' COMMODORE "TEST PILOT" BUNDLE HELPS\n FIRST-TIME COMPUTER USERS ''TAKE OFF''\n\nLAS VEGAS, Nev. --January 6, 1990--\nSelecting a computer for the first\ntime user can be a challenging, if not\nitimidating, experience. A surprising\nnumber of all electronic purchases end\nup back on the store shelves, and\npersonal computers top the list.\n\nThis year, Commodore Business Machines\nlaunched "Test Pilot," a computer\nstart-up package designed especially\nfor first-time computer buyers.\n\n"There''s a lot more to learning to use\na computer than plugging it in," said\nBob Larson, Commodore vice president of\nconsumer sales. "Faced with spending\nhours at a keyboard struggling to\nunderstand complicated directions, many\nfirst-time buyers simply give up."\n\n"Test Pilot" comes complete with a\nCommodore 64 machine, step-by-step\nset-up and operating instructions and\nan assortment of starter software and\ngame disks designed to take the fear\nout of computer users'' "first flight."\nThe package retails for $499.\n\nCommodore expects the "Test Pilot"\noffering to boost sales of the 64C\nmachine, which remains the most popular\nhome computer ever sold. Today there\nare more Commodore 64s in use than any\nother computer, with more than 10\nmillion machines installed worldwide.\n\n"The Commodore 64C is an ideal starter\nmachine," said Larsen. "Unlike\nNintendo, it is much more than just fun\nand games."\n\nIn addition to offering more than 7,000\ntitles, including games, at about half\nthe price of Nintendo, the 64C can also\nrun more sophisticated word processing\nand educational programs.\n\n"The 64C is not a computer that\nchildren will outgrow," according to\nLarsen. "The 64"s wide-ranging\ncapabilities will keep the machine in\nits rightful place after the games are\nput away -- on a desk rather than on a\ncloset shelf."\n\nCommodore''s "Test Pilot" is available\nat leading Commodore dealers and\nselected retailers nationwide. For more\ninformation on where to find "Test\nPilot," call 1-800-627-9595.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (404256, 422981, 0, '       COMMODORE INTRODUCES\n         "SELECT EDITION"\n       MS-DOS COMPATIBLE PCs\n        FOR THE HOME OFFICE\n\nLAS VEGAS, Nev. -- January 6, 1990 --\nCommodore Business Machines Vice\nPresident of Consumer Sales Robert\nLarsen today announced the\nintroduction of Commodore''s "Select\nEdition" line of MS-DOS compatible\nPCs. These high-performance,\nvalue-added PCs were designed to meet\nthe demands of home productivity and\nhome office applications.\n\nAccording to Larsen, the Select\nEdition series was developed to round\nout Commodore''s complete line of\nproducts foº the consumer marketplace.\nThe series offers three models, all\nfeaturing a 286-based machine with a\ncolor VGA monitor.\n\n"The Select Edition series is\nCommodore''s affordable MS-DOS solution\nfor home productivity and the home\noffice" Larsen said. "They provide the\nflexibility and performance that more\nsophisticated consumers have come to\ndemand."\n\nThe Select Edition series includes:\n\n SELECT EDITION - Complete with 640K\n of RAM, two expansion slots and one\n 5.25 inch and one 3.5 inch floppy\n drive already installed. The Select\n Edition is PC/XT compatible and can\n display color or monochrome graphics.\n\n of\nproducts for the consumer marketplace.\nThe series offers three models, all\nfeaturing a 286-based machine with a\ncolor VGA monitor.\n\n"The Select Edition series is\nCommodore''s affordable MS-DOS solution\nfor home productivity and the home\noffice" Larsen said. "They provide the\nflexibility and performance that more\nsophisticated consumers have come to\ndemand."\n\nThe Select Edition series includes:\n\n SELECT EDITION - Complete with 640K\n of RAM, two expansion slots and one\n 5.25 inch and one 3.5 inch floppy\n drive already installed. The Select\n Edition is PC/XT compatible and can\n display color or monochrome graphics.\n\n SELECT EDITION HD-40 - Complete with\n');
INSERT INTO `articles` VALUES (422981, 432048, 404256, '640K of RAM, three expansion slots,\r\n one 5.25 inch and one 3.5 inch floppy\r\n drive, color and monochrome display\r\n and a quick access 40 megabyte hard\r\n drive. It is also PC/XT compatible.\r\n\r\n SELECT EDITION 286 - Complete with\r\n one 5.25 inch high-density floppy\r\n drive and a 40 megabyte hard disk\r\n built-in. The Select Edition 286\r\n runs color VGA graphics as well as\r\n CGA, MDA and Hercules. It is PC/AT\r\n compatible for added speed and\r\n flexibility.\r\n\r\nAll Select Edition computers also\r\nfeature a built-in video and mouse\r\ninterface, parallel and serial ports,\r\na 101-key keyboard and a one year\r\nlimited warranty.\r\n\r\n"As a leader in personal computer\r\ndesign and technology, Commodore is\r\ndedicated to providing a complete,\r\nvalue-added line of computers. Select\r\nEdition is an ideal entry level package\r\nfor home users looking for the best\r\ncost/perfomance value," Larsen said.\r\n\r\nCommodore Business Machines, Inc.,\r\nbased in West Chester, Pa.,\r\nmanufactures and markets a complete\r\nline of computers and peripherals for\r\nthe business, education, government\r\nand consumer markets.\r\n\r\nThe multi-tasking Amiga line includes\r\nthe Commodore Amiga 500 (TM), the\r\nCommodore Amiga 2000 (TM) and three\r\nenhanced products: The Commodore Amiga\r\n');
INSERT INTO `articles` VALUES (432048, 0, 422981, '2000HD (TM), the Commodore Amiga 2500\r\n(TM) and the Commodore Amiga 2500/30\r\n(TM). Commodore''s line of MS-DOS (R)\r\ncompatible computers includes the Colt\r\n(TM) and Professional Series III (TM).\r\n\r\nMS-DOS is a registered trademark of\r\nMicrosoft Inc.\r\n');
INSERT INTO `articles` VALUES (406491, 0, 0, '        COMMODORE ANNOUNCES\n      EDUCATION PURCHASE PLAN\n\nCommodore announced the Education\nPurchase Plan for students, educators\nand educational institutions to\nregional and district sales managers\non Friday, December 22, 1989. Details\nof the program, complete with official\norder forms should reach local dealers\nby December 29th.\n\nFour complete Amiga(R) systems have\nbeen especially configured to meet the\nneeds of educators and students at\nevery level. The A500 system includes\nthe CPU, memory expansion and external\ndrive. The A2000 system includes an XT\nbridgeboard and second internal drive.\nThe 2000HD/1 and the 2500/30 systems\nare bundled with an AT bridgeboard.\nAll of the specially-configured Amiga\nsystems include a monitor. Also\nincluded are two PC Compatible systems\ncomplete with MS-DOS(R) and\nproductivity software and the C64C\nTest Pilot bundle.\n\nEducators, university students who are\nworking towards a degree, and others\ninvolved in the instructional process,\nwill be eligible for special pricing\non the bundled systems. Significant\ndiscounts are also available on\nindividual CPU''s and peripherals when\npurchased along with an Amiga CPU or\none of the specially-configured\nbundles.\n\nEducation Purchase Plan order forms\nhave been provided to authorized\nCommodore resellers. The forms\nprovided by Commodore are the only\nacceptable forms for purchases by\nindividual educators and university\nstudents. Employment or attendance\ninformation must be verified by a\nCommodore reseller before it can be\nsubmitted for order processing.\nPayment must be made by certified\ncheck or money order payable to\n"Commodore Business Machines, Inc."\n\nAccredited schools, colleges and\nuniversities are eligible for similar\npricing on both systems and individual\nCPU''s. School purchase orders should\nbe made to "Commodore Business\nMachines, Inc.," and should reference\nCommodore''s Institutional Terms and\nConditions.\n\nFor complete information regarding the\nprogram and education pricing, contact\nyour local Commodore reseller.\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (425214, 425242, 0, '     COMMODORE TO PARTICIPATE IN\r\n             "TECH 2000"\r\n  AMERICA''S FIRST MULTIMEDIA MUSEUM\r\n\r\nWEST CHESTER, Pa. -December 5, 1989-\r\nCommodore Business Machines, Inc.\r\ntoday announced the company is a\r\nparticipating sponsor of "Tech 2000,"\r\nthe world''s first interactive\r\nmultimedia gallery.\r\n\r\nLocated near the Washington Convention\r\nCenter at Techworld Plaza in\r\nWashington D.C., the gallery will\r\nfeature the most advanced applications\r\nand demonstrations of interactive\r\nmultimedia computing by Commodore and\r\nother leaders in the field. Tech 2000,\r\nwhich opens to the public in January\r\n1990, is expected to draw more than\r\none million visitors annually.\r\n\r\nThe gallery, developed by Techworld\r\nPlaza and the Interactive Video\r\nIndustry Association (IVIA), was\r\npreviewed Nov. 28, 1989, at a private\r\nshowing hosted by IVIA. The showing\r\nprecedes a National Leadership Forum,\r\nentitled "Productivity and Learning in\r\nthe Visual Information Age," which was\r\nheld Nov. 29-30 at Techworld Plaza.\r\n\r\nThe IVIA is an international trade\r\nassociation whose members, including\r\ncorporations, government agencies,\r\ninstitutions and individuals, produce\r\nequipment, software and programming\r\nfor interactive video applications.\r\n\r\nTen Commodore (R) Amiga (R) computers\r\nform an integral part of the exhibit,\r\naccording to David Archambault,\r\nCommodore''s Director of Business\r\nMarkets. He said the Amigas, which\r\noperate interactive kiosks directing\r\nvisitors through the exhibit, help\r\nmake Tech 2000 "user accessible."\r\n\r\n"The Amiga is widely used in a number\r\nof video, graphics and music\r\napplications in addition to its use in\r\nthe color desktop publishing,\r\npresentation and computer-based\r\ntraining markets," Archambault said.\r\n"Since introducing the product in\r\n1985, Commodore has offered a true\r\nmultimedia platform in the Amiga which\r\nhas ideally positioned us to take\r\nadvantage of these high-growth\r\nmarkets."\r\n\r\nAccording to Archambault, video is the\r\nkey component of multimedia. In fact,\r\nBUSINESS WEEK recently called\r\nCommodore the leader in the desktop\r\nvideo niche (October 9).\r\n\r\nCommodore Business Machines, Inc.,\r\nbased in West Chester, Pa.,\r\nmanufactures and markets a complete\r\nline of computers and peripherals for\r\nthe business, education, government\r\nand consumer markets.\r\n\r\nThe multi-tasking Amiga line includes\r\nthe Commodore Amiga 500 (TM), the\r\nCommodore Amiga 2000 (TM) and three\r\nenhanced products: The Commodore Amiga\r\n2000HD (TM), the Commodore Amiga 2500\r\n(TM) and the Commodore Amiga 2500/30\r\n(TM). Commodore''s line of MS-DOS (R)\r\n');
INSERT INTO `articles` VALUES (425242, 0, 425214, 'compatible computers includes the Colt\n(TM) and Professional Series III (TM).\n\nFor further information on the TECH\n2000 gallery or the National\nLeadership Forum, contact the\nInteractive Video Industry Association\nat 703/558-7350.\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (425184, 0, 0, '  COMMODORE SIGNS RETAIL AGREEMENT\n   WITH GENERAL COMPUTER CENTERS\n\nWEST CHESTER, Pa, -December 6, 1989-\nCommodore Business Machines today\nannounced it has signed a twelve\nmonth, multi-million reseller\nagreement with General Computer\nCenters, a regional retail dealer\nbased in Pennsylvania.\n\nThe announcement is the second major\nreseller agreement the company has\nsigned in the last three months. In\nSeptember, Commodore announced it had\nsigned a reseller agreement with\nConnecting Point of America, the\nnation''s fastest growing franchisor\nwith more than 325 retail outlets\nnationwide.\n\nGeneral Computer is the leading\ncomputer retailer in eastern\nPennsylvania, operating 13 computer\noutlets throughout Pennsylvania and\nDelaware. The company, which reported\nsales of over $25 million in 1989,\noffers computer merchandise and\nservice to a variety of different\nmarkets, including government,\ncorporate, small business and\neducation. It has an out bound sales\nforce in each of its target markets.\n\n"General Computer typifies the caliber\nof reseller we are working to attract\nas we continue to expand our product\nlines," said Ken Weber, Commodore Vice\nPresident of Sales. "We expect sales\nof our high-performance, low-cost\nAmiga products to be strong."\n\nCommodore''s new management team, which\nPresident Harold Copperman assembled\nafter joining the company last April,\nis aggressively pursuing the business,\nconsumer, education and government\nmarkets. An important part of\nCopperman''s strategy includes\nre-building Commodore''s dealer\nnetwork.\n\n"The Amiga line is superb," said Ralf\nBzura, president of General Computer.\n"Coupled with the added exposure\nafforded by Commodore''s new ad\ncampaign, we believe carrying the\nCommodore''s Amiga products provides\nGeneral Computer stores with a unique\nopportunity to increase sales\noverall."\n\nCommodore Business Machines, Inc.,\nbased in West Chester, Pa.,\nmanufactures and markets a complete\nline of computers and peripherals for\nthe business, education, government\nand consumer markets.\n\nThe multi-tasking Amiga line includes\nthe Commodore Amiga 500 (TM), the\nCommodore Amiga 2000 (TM) and three\nenhanced products: The Commodore Amiga\n2000HD (TM), the Commodore Amiga 2500\n(TM) and the Commodore Amiga 2500/30\n(TM). Commodore''s line of MS-DOS (R)\ncompatible computers includes the Colt\n(TM) and Professional Series III (TM).\n\nMS-DOS is a registered trademark of\nMicrosoft Inc.\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (401796, 398645, 0, '    COMMODORE FORMS MUTLIMEDIA\r\n         MARKETING GROUP\r\n\r\nWESTCHESTER, Pa. - Commodore\r\nBusiness Machines, Inc. Director\r\nof Busness Markets David Archambault\r\ntoday announced Commodore has formed\r\na multimedia marketing group headed\r\nby former Disney producer Ken\r\nChristie, a well known and highly-\r\nregarded video professional with ten\r\nyears of marketing and creative\r\nexperience in the video production\r\nand interactive video industry.\r\n\r\nThe announcement comes at a time\r\nwhen Commodore''s multi-tasking Amiga\r\nproduct line is being recognized as\r\nthe ideal platform for multi-media\r\ncomputing. Archambault said the\r\nAmiga currently is in use in a wide\r\nvariety of video, graphics and\r\nmusic applications which make it a\r\nversatile multimedia tool.\r\n\r\n"It is true that for several years\r\nCommodore has offered a true\r\nmultimedia platform in the Amiga,"\r\nArchambault said. "Based on our own\r\nforecasts of near-term growth in\r\nthis market, we chose to add a\r\nmultimedia group to our marketing\r\norganization to ensure the Amiga\r\nremains the industry leader."\r\n\r\nAccording to Archambault, Commodore\r\nplans to aggressively pursue the\r\ncomputer-based training and desktop\r\npresentation market segments, in\r\nparticular. He said the company\r\nintends to expand its presence in\r\nthe market by leveraging its clear\r\nlead in desktop video which is the\r\nbackbone of multimedia.\r\n\r\n"Taking the lead in multimedia is\r\nbut one component of our strategy to\r\nmake the significant inroads into\r\nthe U.S. business computer market,"\r\nArchambault said. "We are excited by\r\nthe proven marketing expertise and\r\ncomprehensive knowledge of the video\r\nindustry Ken Christie brings to our\r\nteam."\r\n\r\nDuring his three years with Walt\r\nDisney Productions, Christie was\r\nresponsible for the design,\r\ndevelopment and productions of 90\r\ninteractive and linear videodisc\r\nprograms for EPCOT Center. He was\r\nmost recently Vice President of\r\nMarketing for Nebraska Interactive\r\nVideo, Inc. A founding member of the\r\nInteractive Video Industry\r\nAssociation (IVIA) and current\r\nPresident of the International\r\nInteractive Communications Society,\r\nChristie''s articles have been\r\npublished in a variety of video\r\npublications.\r\n\r\nAt Commodore he will be responsible\r\nfor the management of Amiga\r\nmarketing programs in desktop and\r\nprofessional video, interactive\r\nvideo and professional music. His\r\nteam will integrate these areas to\r\nenhance Commodore''s position in the\r\nmultimedia industry.\r\n');
INSERT INTO `articles` VALUES (398645, 0, 401796, 'Commodore Business Machines, Inc.,\nbased in West Chester, Pa.,\nmanufactures and markets a complete\nline of computers and peripherals\nfor the business, education,\ngovernment and consumer markets.\n\nThe multi-tasking Amiga line\nincludes the Commodore Amiga\n2000 (TM), the Commodore Amiga\n500 (TM) and three enhanced\nproducts: the Commodore Amiga\n2000HD (TM), the Commodore Amiga\n2500 (TM) and the Commodore Amiga\n2500/30 (TM). Commodore''s line of\nMS-DOS(R)-compatible computers\nincludes the Colt (TM) and\nProfessional Series III (TM).\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (405102, 0, 0, '     COMMODORE ADJUSTS PRICES\n       FOR AMIGA 2000 SERIES\n\nCommodore Business Machines, Inc.\ntoday announced price adjustments\nfor it''s high-performance Amiga\n2000 product line to make the\nproducts more accessible to\nprofessional users. Lloyd Mahaffey,\nCommodore Vice President of\nMarketing, said price reductions for\nthe product line were in the 10%-15%\nrange. The Amiga 2000, for example,\nnow is being offered at a suggested\nretail price of $1,899, down from\n$2,195.\n\n"We believe these price adjustments\nwill point out the Amiga''s price-\nperformance superiority," Mahaffey\nsaid. "The move is another step we are\ntaking to increase our competitive\nedge in the U. S. marketplace."\n\nMahaffey said the price adjustments\nwere also designed to speed\nacceptance of the Amiga in the\nbusiness, government and education\nmarkets. He said the machine is\nbeing touted as the ideal platform\nfor multimedia computing which is\nexpected to become a multi-billion\ndollar industry by the early 1990s.\n\nSince Harold Copperman became\nPresident of Commodore U. S. in\nApril, the company has placed\nsubstantial resources behind the\nAmiga. Last month, the company\nlaunched a $15 million advertising\ncampaign to promote the Amiga''s\nversatile graphics, video and music\ncapabilities.\n\n"We anticipate stronger Amiga sales\nin these markets as new users\ndiscover the product''s broad\ncapabilities and as multimedia takes\nhold," Copperman said. "We expect\nthese pricing adjustments will be a\nmechanism to build on the Amiga''s\ncurrent popularity and increase its\npresence in the markets we are\npursuing."\n\nCommodore Business Machines, Inc.,\nbased in West Chester, Pa.,\nmanufactures and markets a complete\nline of computers and peripherals\nfor the business, education,\ngovernment and consumer markets.\n\nThe multi-tasking Amiga line\nincludes the Commodore Amiga\n2000 (TM), the Commodore Amiga\n500 (TM), and three enhanced\nproducts: the Commodore Amiga\n2000HD (TM), the Commodore Amiga\n2500 (TM), and the Commodore Amiga\n2500/30 (TM). Commodore''s line of\nMS-DOS(R)-compatible computers\nincludes the Colt (TM) and\nProfessional Series III (TM).\n\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (405720, 402959, 0, '     COMMODORE INTRODUCES NEW\r\n        AMIGA PERIPHERALS\r\n\r\nLAS VEGAS, Nev, - Commodore Business\r\nMachines, Inc. Amiga Product Manager\r\nKeith Masavage today announced the\r\ncompany is extending its line of\r\nperipherals for the Commodore Amiga.\r\n\r\nThe new peripherals are designed to\r\nsubstantially expand the utility of\r\nthe popular Amiga (R) product family\r\nwhich is widely used in a number of\r\nvideo, music, computer-based\r\ntraining and presentation\r\napplications. The move reflects\r\nCommodore''s ongoing commitment to\r\nadding increased performance to its\r\nsophisticated Amiga line by\r\nproviding additional processing\r\nspeed and interfacing capabilities.\r\n\r\n"Users in a wide variety of\r\nindustries have demonstrated that\r\nthe Amiga is a versatile, high-\r\nperformance desktop computer,"\r\nMasavage said. "These new products\r\nwill assist us as we work to expose\r\nthe Amiga to a larger audience."\r\n\r\nAmong the new peripherals to be\r\nannounced are:\r\n\r\nCOMMODORE AMIGA (R) 2630\r\n\r\nThe A2630 is a Motorola (R) 68030-\r\nbased accelerator board for the\r\nAmiga 2000 series computers\r\nwhich features a 25 Mhz MC68030\r\nmicroprocessor, a 25 Mhz MC68882\r\nmath co-processor and a 68851\r\nmemory management unit.\r\n\r\nThe A2630 comes standard with 2 MB\r\nof 32-bit memory and is expandable\r\nto 4 MB. The 2630 provides the\r\nprofessional Amiga user with a\r\ndramatic performance increase for\r\nmath intensive applications such as\r\n3-D solid modelling or\r\nvisualizations.\r\n\r\nThe suggested retail price for the\r\nA2630 is $2,195.\r\n\r\nCOMMODORE (R) AMIGA 2091 AND 2091-40\r\n\r\nThe A2091 is a high-performance\r\nautobooting hard disk controller and\r\nmemory expansion board. The device\r\ncan be fitted with 2 MB of memory\r\nand provides improved SCSI\r\ncapabilities. Additionally, the\r\ncontroller provides space for\r\nmounting a 3.5-inch hard disk.\r\n\r\nThe more powerful A2091-40 is an\r\nautobooting 40 MB SCSI hard disk\r\nand controller which has been\r\nincorporated as a standard component\r\ninto the Commodore Amiga 2000HD (TM)\r\nand is also available as a\r\nperipheral. It features sockets for\r\nup to 2 MB of 16-bit fast RAM and\r\nprovides room to mount the 3.5-inch\r\nSCSI hard disk on the board. With\r\nthe A2091-40 users can boot directly\r\nfrom the Amiga''s Fast File system,\r\ndecreasing boot times, increasing\r\nperformance and requiring fewer\r\ndisk partitions.\r\n');
INSERT INTO `articles` VALUES (402959, 0, 405720, '\nThe suggested retail price for the\nA2091 is $399, $899 for the\nA2091-40.\n\nCOMMODORE (R) AMIGA 2232\n\nThe A2232 is a multi-serial port\ncard that provides the Amiga user\nseven additional RS232 ports. Each\nport can operate independently and\nsimultaneously and provides speeds\nup to 19.2 KBaud. Additionally, the\nA22ration and full multi-\ntasking which is critical for many\nof the sophisticated applications\nthat have been developed on the\nAmiga.\n\nThe suggested retail price for the\nA2232 is $399.\n\nCommodore Bu32''s shared on-board RAM and\ndedicated micro-processor provides\nhigh-speed operation and full multi-\ntasking which is critical for many\nof the sophisticated applications\nthat have been developed on the\nAmiga.\n\nThe suggested retail price for the\nA2232 is $399.\n\nCommodore Bu32''s shared on-board RAM and\ndedicated micro-processor provides\nhigh-speed operation and full multi-\ntasking which is critical for many\nof the sophisticated applications\nthat have been developed on the\nAmiga.\n\nThe suggested retail price for the\nA2232 is $399.\n\nCommodore Business Machines, Inc.,\nbased in West Chester, Pa.,\nmanufactures and markets a complete\nline of computers and peripherals\nfor the business, education,\ngovernment and consumer markets.\n\nThe multi-tasking Amiga line\nincludes the Commodore Amiga\n2000 (TM), the Commodore Amiga\n500 (TM) and three enhanced\nproducts: the Commodore Amiga\n2500 (TM), the Commodore Amiga\n2000HD (TM) and the Commodore\nAmiga 2500/30 (TM). Commodore''s\nline of MS-DOS (R)-comaptible\ncomputers includes the Colt (TM)\nand Professional Series III (TM).\n\n\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (412684, 404953, 0, '       COMMODORE INTRODUCES\r\n        AMIGA 2500/30 (TM)\r\n\r\n  Higher-performance 2500 features\r\n     68030 Processor and 68882\r\n         Math Co-Processor\r\n\r\nLAS VEGAS, Nev. - Commodore Business\r\nMachines, Inc. today launched the\r\nAmiga 2500/30 at Comdex. The\r\nenhanced A2500 meets the needs of\r\ngraphics, animation and video\r\nprofessionals who require higher-\r\nperformance features to accomplish\r\nhigh-speed Amiga applications. The\r\nA2500/30 is also highly desirable\r\nfor desktop publishing, music, word\r\nprocessing and many other business\r\napplications.\r\n\r\n"The high-performance Amiga 2500,\r\nwhich has been on the market for\r\none year, has flourished within the\r\nmarkets for which it was designed,"\r\nsaid David Archambault, Commodore\r\nDirector of Business Markets. "We\r\ndeveloped the A2500/30 to meet both\r\nthe demands of our customers and\r\nthe increasingly sophisticated\r\napplications being produced by\r\nAmiga developers."\r\n\r\nArchambault said the advanced\r\ngraphics capability of the Amiga\r\nseries is ideally suited to color\r\ndesktop publishing and presentation,\r\ncomputer-based training as well as\r\nprofessional video and music\r\napplications. He said the Amiga\r\nalso is the ideal multimedia\r\nplatform.\r\n\r\nThe Commodore Amiga 2500/30 comes\r\nstandard with a Motorola 68030-based\r\nco-processor card running at 25 Mhz\r\nwith 2 MB of 32-bit RAM, (expandable\r\nto 4 MB of 32-bit RAM). In addition,\r\nthe system features a 25 MB 68882\r\nmath co-processor, a 68851 memory\r\nmanagement unit, 1 MB of 16-bit\r\n"chip" RAM; a built-in 880K, 3.5\r\ninch floppy disk drive; a pre-\r\nconfigured, high-performance 40 MB\r\nhard disk drive and autobooting SCSI\r\nhard disk controller; custom sound,\r\nanimation and graphics chips; RS232\r\nserial and parallel connectors; and\r\ntwo RCA-type audio output jacks.\r\n\r\nSpecial features that give users an\r\nunparalleled flexibility advantage\r\nare two bridgeboards allowing the\r\nA2500/30 to run both MS-DOS (R)\r\nhardware and software.\r\n\r\nThe open architecture of the Amiga\r\n2000 series computers allows for\r\nextensive internal expansion with\r\nmulti-processor, multi-DOS options.\r\nContained in the Amiga 2500/30 are\r\nfive full-size Amiga expansion slots;\r\ntwo standard PC/XT slots; two PC/AT\r\nslots; a CPU expansion slot\r\n(occupied) and a video expansion\r\nslot.\r\n\r\nThe Amiga 2500/30 will be available\r\nthrough authorized Commodore Amiga\r\ndealers at a suggested retail price\r\nof $4,699. Owners of an A2000 family\r\nAmiga can upgrade their existing\r\n');
INSERT INTO `articles` VALUES (404953, 0, 412684, 'machines by purchasing a 2630 card\nfrom an authorized dealer for $2,195\n(suggested retail price).\n\nCommodore Business Machines, Inc.,\nbased in West Chester, Pa.,\nmanufactures a complete line of\ncomputers and peripherals for the\nbusiness, education, government\nand consumer markets.\n\nThe multi-tasking Amiga line\nincludes the Commodore Amiga\n2000 (TM), the Commodore Amiga\n500 (TM), and three enhanced\nproducts: the Commodore Amiga\n2000HD (TM), the Commodore Amiga\n2500 (TM) and the Commodore Amiga\n2500/30 (TM). Commodore''s line of\nMS-DOS (R)-compatible computers\nincludes the Colt (TM) and\nProfessional Series III (TM).\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (1434, 0, 0, '\n ABOUT THE Q & A SECTION \n\n * Common Questions and Answers \n * Public Discussion Board \n * Commodore''s Private Hotlines \n\n The "Questions and Answers" area \n provides you with  answers to your \n Commodore computing questions. \n\n\n COMMON QUESTIONS AND ANSWERS \n\n The expanded "Common Questions and \n Answers" section lists the answers to \n the most asked questions Commodore \n receives. \n\n\n PUBLIC DISCUSSION BOARD \n\n The "Public Discussion Board" is used \n for general discussion with other \n Q-Link members allowing you to gain \n from the experience of others. \n\n\n¨ªªê?ÔJU???%?ÊUQ5Za?Ñ? KDE HOTLINES \n\n With "Commodore''s Private Hotlines" \n you have a direct connection to \n Commodore Business Machines Inc. \n Commodore''s telecommunications \n department will be glad to assist you \n in trouble shooting programs, general \n product information, etc. \n\n Due to the nature of the Private \n Hotline, Commodore cannot assist you \n in writing your own programs. For \n this type of assistance, go to the \n Hardware and Computing Support Groups \n of the COMMODORE INFORMATION NETWORK. \n Other sources of such information you \n should check include your local CBM \n User Groups, the ience of others. \n\n\n COMMODORE''S PRIVATE HOTLINES \n\n With "Commodore''s Private Hotlines" \n you have a direct connection to \n Commodore Business Machines Inc. \n Commodore''s telecommunications \n department will be glad to assist you \n in trouble shooting programs, general \n product information, etc. \n\n Due to the nature of the Private \n Hotline, Commodore cannot assist you \n in writing your own programs. For \n this type of assistance, go to the \n Hardware and Computing Support Groups \n of the COMMODORE INFORMATION NETWORK. \n Other sources of such information you \n should check include your local CBM \n User Groups, the Programmers \n Reference Manual, as well as your \n local bookstore or library. \n\n The Commodore Hotlines are run \n directly by Commodore Business \n Machines staff. For Q-Link specific \n questions, please use the Q-Link \n question boards in the CUSTOMER \n SERVICE DEPARTMENT. \n\n Questions posted on the Private \n Hotlines are generally answered, via \n E-Mail, within 2 to 3 business days. \n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (845758, 0, 0, ' COMMON QUESTIONS ON THE COMMODORE\n   EDUCATIONAL PURCHASE PROGRAM\n\n1. Does the Commodore education\npurchase program end on June 30?\n\nAns: The Commodore Education Purchase\nPlan does not end on June 30. The\nprogram was started in January 1990\nand will continue indefinitely. Since\nthe product selection and pricing is\nreviewed by Commodore management\nfrequently, these are subject to\nchange without notice. There are no\nplans to end the program.\n\n2. Sales Tax: when do I pay?\n\nAns: End users in the following states\nwill pay sales tax:\nPA, GA, VA, IL and CA. This is stated\non the current order form. The\ncollection of sales tax is based upon\nlegal notices given to Commodore about\nthe tax collextion requirements in\nthese states. If the tax laws change\nand additional state require the\ncollextion of sales tax, Commodore\nwill add them to the list.\n\n3. Do high school students qualify for\nthe education discount?\n\nAns: No. Only students enrolled in a\ncourse of study at a post-secondary\nQualified Educational Institution and\nare certified by the institution as\nmaking significant progress towards a\ndegree qualify for the education\ndiscount.\n\n4. Can a qualified end user buy Amiga\ncomponents and options without the\npurchase of a CPU or a bundled system?\n\nAns: Only until June 30, 1990 ($250\nminimum order). After that date,\nindividual components may only be\npurchased at the education price in\nconjunction with a bundled system or\nCPU.\n\n\n\n          <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (41183, 0, 0, ' COMMODORE USER GROUPS\n\n Check in the User Group sections\n here on Q-Link for further\n assistance and location of a\n nearby user group.\n\n You will need to contact your local\n user group directly (via U.S. Mail or\n by phone) to find out further info on\n meeting times, place, etc.\n\n Also, there is a USER GROUP SECTION\n here on Q-Link that will be able to\n direct you to the Commodore User\n Group in your area.\n\n      <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (46435, 0, 0, ' RECOVERING PROGRAMS FROM DISKS\n\n There is no way to recover data and\n programs after you have formatted or\n headered a disk. There are however,\n programs like the "Disk Doctor" that\n allow you to go into the disk and\n read each block to try and retrieve\n data. Check in local software dealers\n for this third party program.\n\n        <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (64506, 0, 0, ' USING COMMODORE EQUIPMENT OVERSEAS\n\n Commodore cannot recommend or support\n the use of any Commodore-US\n manufactured computer product or any\n Europe made product in the U.S.\n\n It is recommended that you purchase a\n computer in the country which\n provides that same T.V. standard as\n needed. You could also bring an NTSC\n T.V. set and the proper converters if\n you must bring your present U.S. made\n computer. However, the T.V. set will\n not be able to receive foreign\n channels or stations.\n\n As a reminder, Commodore can not\n fulfill any warranty on a computer\n that is operated other than what it\n was originally designed for.\n\n Since COMMODORE has offices in many\n other countries, we do not maintain\n further information on the machines\n made and sold in those countries.\n Those machines are not made in the\n USA and we do not have access to\n parts, supplies or information on\n their machines. If you need further\n info, we suggest you contact\n COMMODORE in the country where you\n are going to for further assistance.\n\n We have had reports from users who\n claim to used there US computers with\n some form of a power transformer.\n\n      <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (2226, 0, 0, ' UNDERLINING IN EASY-SCRIPT\n\n To underline using EasyScript using\n an unlisted printer, you will need\n to use the printer codes located in\n the back of your manual (as\n you would with other types of\n underlining printers). The codes\n needed to turn on underlining are:\n\n The printer that we are using in\n this example is the DPS-1101\n\n  <F-3> for the "*" mark\n  then: 1=27:2=69:3=82 <return>\n\n To start underlining, hit:\n\n      F-1 and 1 and then F-1 and 2.\n\n It leaves a reversed "12" on the\n screen.\n\n To stop underlining, hit F-1 and 1\n and then F-1 and 3. This will leave a\n reversed "13" on the screen.\n\n     <PRESS F5 TO RETURN TO MENU>');
INSERT INTO `articles` VALUES (11882, 0, 0, ' INTERFACING THIRD PARTY PRODUCTS\n\n When hooking up any third party\n product (printers, monitors, etc) to\n the Commodore computer systems, you\n would need to use the appropriate\n interface cable or connector product.\n\n Note: the third party product MUST be\n labeled: "compatible to Commodore\n products" in order to correctly\n connect and use.\n\n Information on which interface should\n be used is provided by the third\n party manufacturer or local dealer.\n\n Interfaces (IEEE or RS232) are\n manufactured by the following:\n\n   OMNI TRONICS (206) 236-2983\n   MIRCO R&D    (303) 985-1473\n   Cables-To-Go  800-826-7904\n\n Also check in local Radio Shack,\n Sears and computer product dealers in\n your area.\n\n Note: for the business computer line:\n 8032P, 4040, 8050, etc. you will need\n to purchase an IEEE interface to\n connect to the C128 and C64 series We\n suggest you contact the following\n company for information on price,\n ordering and availability of the\n interface:\n\n PROGRESSIVE PERIPHERALS\n\n    (303) 825-4144\n\n          -or -\n\n SKYLES ELECTRIC WORKS\n\n    (415) 965-1735\n\n      <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (40184, 0, 0, ' COMMODORE 4032, 8032 AND PET REPAIRS\n\n All repairs to the COMMODORE "PET"\n models of business computers are done\n by approved service centers. Below is\n a listing of all the current centers\n that repair the "PET" & business\n models.\n\n Note: all parts and peripherals\n servicing inquiries should also be\n sent to the following centers:\n\n On Line Micro Computer Repair\n 3207 S. Brea Canyon Rd. #B\n Diamond Bar, CA 91765\n (714) 594-2641\n\n ACOM Corp.\n 3482 Oakcliff\n Doraville, GA 30340\n (404) 451-8455\n\n Micro Computer Repair\n 105 N. McKinney #B\n Richardson, TX 75081\n (214) 644-3770\n\n Cem Corp.\n Rt. 1 213 Arrow Lane\n Freeport, TX 77541\n (409) 233-3153\n\n Larsons Computer Service\n 4010 Joseph Hardin #280\n Dallas, TX 75236\n (214) 337-4876\n\n      <PRESS F5 FOR MENU>');
INSERT INTO `articles` VALUES (835141, 0, 0, 'Press RETURN to continue or F5 to cancel.');
INSERT INTO `articles` VALUES (430, 417, 450, '2005-09-01 Update\r\no File downloads now work!  Only\r\n  one file is up at present, but the\r\n  rest is just a matter of organizing \r\n  the files in the menu:\r\n  CSC:SW Libs:Browse C64 SW\r\n  Select the item with F1, then F7 to\r\n  download.  Comments and such are\r\n  not implemented yet.  Client will\r\n  hang if you try them :-)\r\no Seat #13 bug is finally squashed.\r\n  Bad developer code :-)\r\no Search for replies after date and \r\n  Message Base search now work\r\no Fixed bug in message base pause\r\n  routine.  After 5 msgs, hit return for\r\n  more of the listing.\r\no More bugfixes\r\n');
INSERT INTO `articles` VALUES (450, 430, 451, '2005-09-02 Update\r\n\r\nImplementation is slowing, due to the types of features left to implement and my energy level.  I will probably set this aside for a few days to refresh.\r\n\r\no Cleaned up Message Bases.  Was using same entry type for messages as for multi-part files.  Fixed.  Also, message listing now has "Press RETURN..." line at end if more than 5 messages.\r\no Removed "<Press F7..." from actual articles and had server add it automatically on transmit\r\no Same for <Press F5...\r\no Message Base titles can be 32 chars, but only 29 show in a listing (23 if replies present).  So, added code to abbreviate the end of lines with "..."\r\no Code cleanup\r\no Cached DB conn was timing out on long sessions.  Removed caching for now.\r\no Cleaned up some data files in the menus that had corrupt data in them (caused by the way I extracted them).  No data was lost.\r\no Added commands for menu items: chat and upload.\r\n\r\nLittle stuff, but should make the system more robust.\r\n\r\nPeople need to beat on the message bases.\r\n\r\nJim\r\nWorking on them...');
INSERT INTO `articles` VALUES (417, 418, 430, '2005-08-31 Update\r\n\r\no Message bases are now active.\r\n  Search and Get After Date do not\r\n  work yet, they will lock the client.\r\n  This part should be considered \r\n  pre-alpha.\r\no Empty rooms are now removed.\r\n  Used to work, but broke when the\r\n  room code was switched to case\r\n  insensitive matches.\r\no RoomManager would add user to\r\n  all non-full Lobbies.  Fixed.\r\no Window size increased from 8 to 16\r\n  This should help with the "freeze"\r\n  some saw.\r\no Cleaned up String -> byte code to\r\n  be portable.\r\no Hopefully fixed bug with 13th chat\r\n  user in a room sharing ID with #12.\r\n  Please test.\r\no Added more menus.\r\no Fixed bug in List Rooms code.\r\n  System should now handle a room\r\n  list > 8 correctly and not lock up.  \r\no Database connection was dying \r\n  after long period of login.  Changed\r\n  code to get a new conn if the current\r\n  one closes.\r\n\r\nNOTE: Please use *Alpha Tester Message Base* to discuss service issues.\r\n');
INSERT INTO `articles` VALUES (418, 0, 417, '2005-08-29 Update\r\no Moved service to Linux server.  I had\r\n  to fix some string encoding bugs,\r\n  so there may be more.\r\no Implemented System-Wide-OLMs\r\n\r\n2005-08-28 Update\r\no Implemented Identify Command in Chat.  \r\n  It will not crash the menus anymore\r\no Implemented Locate User.  Same effect\r\no Implemented rudimentary //roll\r\n  command.  Need to add support for\r\n  multiple dice\r\no Changed /msg and /me to //msg\r\n  and //me for consistency\r\no Fixed bug preventing emails with "''"\r\n  in them being sent.\r\no Implemented //8ball command :-)\r\no Fixed //roll cmd to match QLink\r\n\r\nThere is a bug in rolling 0 sided dice.\r\nDon''t do it, or you''ll get disconnected\r\n\r\n2005-08-26 Update\r\no Extracted files and menus from\r\n  Raymond Day''s traces and placed into\r\n  the menu system.  Not all data is\r\n  available\r\n\r\nNotes:\r\n\r\no Please do not /. this yet.  The\r\n  system is not complete enough, and\r\n  will just frustrate users expecting\r\n  the system to be fully operational.\r\no Please understand this service is\r\n  just in development, and you are an\r\n  alpha tester.  If you are expecting\r\n  the system to function well, please\r\n  log off and try back in a month or\r\n  so. I know this should be obvious,\r\n  but I am starting to get emails and\r\n  such from people getting frustrated\r\n  by VICE setup, tcpser configs, etc.\r\n\r\nJim');
INSERT INTO `articles` VALUES (451, 450, 900, '2005-09-04 Update\r\n\r\nAs it was Labor Day weekend, I took some time off.  I had some fixes, but it didn''t seem worth it to reboot the server.  I now have some stuff worth the wait:\r\n\r\no Games!  yes, preliminary games support is in place.  All the initial shipped games (not sure about RJ Casino, and CC/Hab/Puzzler are excluded) should now work.  Observing a game is not implemented, nor is the "Have Q-Link pick my partners".  List games will now work, although I think it may fail if there are too many games to list.  I also do not know the error condition if a client does not have the game requested, so make sure everyone has the correct game before starting.  As with all the newly added code, bang on it and qmail me what you find.  I assume my weakest spot is the error conditions.  I know there is one bug, the invite screen shows your name, not the inviter''s.  I have a fix in dev.\r\no Restructured a lot of code to implement the game system.  Thus, try out all the chat features that used to work and make sure they still function correctly.\r\no Added more DB close commands to make a cleaner system.\r\no Changed the window size on downloads, so please try the dload again and let me know if the resulting file does not load.  I can slide the window back dwon towards the previous 8 packets from the current 16.\r\no Cleaned up errors in the Bulletin display code.\r\no Cleaned up bugs in the chat addUser code, so double adds should not happen again.\r\no More general code fixes.\r\n\r\nCode is getting somewhat feature complete for v1.0.  I want to add the following features:\r\n\r\no Uploads\r\no Comments and Docs on dloads\r\no Observe Game\r\no Pick Partners\r\no Suspend/Resume Game\r\n\r\nAnd then I think the v1.0 code will be feature complete.\r\n\r\nJim');
INSERT INTO `articles` VALUES (900, 451, 903, '2005-09-08 Update\r\n\r\no I think I have caught all the places a user can leave the game.  Games List should be cleaned up now.\r\no Restructured and simplified the Lobby creation code.  Was able to remove a couple classes and a lot of special cases in RoomManager.  Lobbies will go from A to Z, and then start over at 1 and go up.  That should keep us for a while.\r\no Added code to properly handle packets with CRC errors.  DarkVulcan, try your tests again.\r\no Invite timeouts should no longer lock clients.  You can still lock the client by starting a game load and then disconnecting one of the parties.  Not sure how to fix that.\r\no Restarts are closer to working, but no go.\r\no Someone keeps trying to load SuperQ.  Quit that.  It will not work, and I had to add code to bump those folks off for now.\r\no Added code to terminate connection after 20 consecutive packet errors.\r\no Took pics of the server config.  www.jbrain.com/vicug/gallery/qlink/\r\no Added code to prevent use of reserved words and chars in screen names\r\no Fixed invite dialog naming bug\r\no Cleaned up game leave code\r\no Cleaned up game terminate code\r\n\r\n');
INSERT INTO `articles` VALUES (903, 900, 901, '2005-09-11 Update\r\n\r\no Restart now works\r\no I cleaned up the Auditorium code to prevent OLMs on new questions to show on all viewers.\r\no I added auto-text capabilities to the auditoirum, for starting new shows and sending out intros.\r\no I added code to the game termination modules, to eliminate ghost game sessions.\r\n\r\nAs I and my family are planning to leave for the Chicago SWRAP EXPO, I need to move the server to a more permanent home this week.  Otherwise, if the personal box or our cable broadband connection dies, no one will be here to fix it.\r\n\r\nJim');
INSERT INTO `articles` VALUES (901, 903, 902, '2005-09-13 Update\r\n\r\no No major enhancements, as I am cleaning up code for SWRAP demo.\r\no Wrote utility that read the HW and SW Support Map articles and parsed the text into actual menu entries for the HW and SW Support areas.  All items are marked menu, though, so I need to fix that after EXPO.\r\no The server will be moving to ltshosting.net as soon as things are arranged.  I will place a stub service at the old address with the new information.\r\n\r\nJim');
INSERT INTO `articles` VALUES (902, 901, 905, '2005-09-15 Update\r\n\r\no Server is now moved to ltshosting.net.  Many thanks for Mark Ponter and associates for donating hosting space.  Server should be more stable, as it is no longer hosted at my house.\r\no Leaving for EXPO tomorrow.  I will be unavailable most of the day.\r\no Folks can now feel free to submit to digg and /. as they wish.  It is now public.\r\n\r\nJim');
INSERT INTO `articles` VALUES (905, 902, 904, '2005-09-19 Update\r\n\r\no Many thanks to those who chatted with us at EXPO.  We imopressed the attendees.\r\no Slashdot picked up the story.  We rolled to Lobby A tonight.\r\no I am recuperating from the EXPO trip, so enjoy the current server for a bit while I get unpacked and such.\r\n\r\nJim');
INSERT INTO `articles` VALUES (1000003, 904, 1000004, '2005-09-26 Update:\r\n\r\no Bug fix to uppercase first letter of screen name\r\no Bug fix in download file function\r\no Added initial support for Adding and deleting screen names.  Does not work yet, but hopefully will finish tomorrow.\r\no Fixed code that saves account name on disk to send 10 chars, padded with spaces.\r\no Cleaned up screen names (min 3 chars, no illegal chars, etc.) and added code to re-sychronize the disk screen name with the one on the server as folks login.  FOr those writing utilities to see the names, this will also fix the padding issue on the disk.\r\n\r\nA pretty light update, but I needed to fix the above bugs.\r\n\r\nJim');
INSERT INTO `articles` VALUES (904, 905, 401, '2005-09-22 Update:\r\n\r\no In the morning, pushed new code to add Game Observation and fix Game restarts, but broke the chat rooms in the process.  Backed out changes at 9AM CT, and fixed bug during the day.  Re-rolled changes at night.\r\no Game restarts are supposed to move the restart requestor to front of queue.  The re-queuing code was broken.  Fixed.\r\no Games can now be observed.  I still need to add code to ask player if he can be observed, so there is the option to cheat at present.  \r\no Added support for gateways back into the code.\r\no Many minor bigfixes.\r\n\r\nJim');
INSERT INTO `articles` VALUES (1000004, 1000003, 1000005, '2005-09-29 Update:\r\n\r\no Finished support for Add and Delete users names.  Also added a "Change Name" feature to switch account names while logged on.\r\no Added a Terminate Disk feature to help people merge multiple Q-Link names onto a single disk or image\r\no Later in the day, found I''d missed a case when changing names, so people were getting locked out.  Fixed that.\r\n\r\nDuring the night, everyone went wild adding new names, and I had all I could do to keep up blocking the ones that should be reserved.');
INSERT INTO `articles` VALUES (1000005, 1000004, 1000006, '2005-10-02 Update:\r\n\r\no Added security to chat rooms, so as to add special commands that only QGUIDES can use (//vio, etc.)  Also added a flag in the database to denote a staff user\r\n\r\n2005-10-01 Update:\r\n\r\no Added code to ignore spaces in user names, so QTESTjim and QTESTjim (case insensitive) will still match.  This required quite a bit of changes in the system.\r\no Cleaned up more of chat room code, moving // command that do not deal with the room outside the room code.\r\no Added questionaire to beginning of session, and populated the IDENTIFY user menu item in Chat.\r\no Implemented AccountInfo and UserInfo objects to hold the account and user information during lookups.\r\n\r\n2005-09-30 Update:\r\n\r\no Cleanup on multiple user names code.  I changed the reserved words matching routine to ignore spaces and be case insensitive.\r\n');
INSERT INTO `articles` VALUES (1000006, 1000005, 401, '2005-10-06 Update:\r\n\r\no To fix final longering bugs in Chat code and add new features, rewrote a large chunk of the Chat Room codebase.\r\no Added secret new feature, but still testing.  \r\no Added hooks for simple statistics gathering.  Will add more later.\r\n');
INSERT INTO `articles` VALUES (401, 1000006, 0, '2005-10-08 Update:\r\n\r\n(Sorry about the delay in getting these out.  I have to add them manually in the DB and link them as chained articles, which is not easy to do.)\r\n\r\no Added //who command in chat to bring up user list.\r\no Rewrote server startup code to allow for multiple service ports to be open (thinking of adding a web service port for proxy-bound users, and an admin port)\r\no Added more hooks for statistics, and reworked Reset (0x23) command to prep for more new features.\r\no More tweaks to secret new feature.  Should be ready to unveil by evening.  It is still alpha code, but it looks to be somewhat solid.\r\no Added //nick <user name> command in chat to quickly change your username in use.\r\no Added //who command to show users in room.\r\n');

-- --------------------------------------------------------

-- 
-- Table structure for table `audit_log`
-- 

DROP TABLE IF EXISTS `audit_log`;
CREATE TABLE `audit_log` (
  `audit_log_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL default '0',
  `operation` enum('LOGIN','LOGOUT','FAILED LOGIN') NOT NULL default 'LOGIN',
  `text` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`audit_log_id`),
  KEY `account_id` (`account_id`,`operation`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `audit_log`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `auditorium_talk`
-- 

DROP TABLE IF EXISTS `auditorium_talk`;
CREATE TABLE `auditorium_talk` (
  `talk_id` int(11) NOT NULL auto_increment,
  `mnemonic` varchar(10) NOT NULL default '',
  `text` text NOT NULL,
  `delay` int(2) NOT NULL default '10',
  `sort_order` int(1) NOT NULL default '1',
  PRIMARY KEY  (`talk_id`),
  KEY `name` (`mnemonic`)
) TYPE=MyISAM AUTO_INCREMENT=9 ;

-- 
-- Dumping data for table `auditorium_talk`
-- 

INSERT INTO `auditorium_talk` VALUES (1, 'common', 'Quantum is pleased to award a door prize at each event held in the Q-Link\r\nAuditorium. Winner names are generated by the Q-Link computers from among guests present IN the Auditorium! \r\n', 17, 1);
INSERT INTO `auditorium_talk` VALUES (2, 'common', '   -=* Featured Events *=-\r\n   ```````````````````````\r\nMM/DD INFO Forum       9:00pm\r\nMM/DD Checkers Tourney10:00pm\r\nMM/DD Adult Vices      2:00pm\r\nMM/DD Timeworks        3:30pm\r\nMM/DD RUN Forum       11:00pm\r\nMM/DD Broderbund Forum 3:00pm\r\nMM/DD Pet Care Forum   5:30pm\r\nMM/DD Homes Today      6:00pm\r\nMM/DD YAY! It''s WHEEL! 7:00pm\r\nMM/DD Scout? Bartlett  8:00pm', 30, 1);
INSERT INTO `auditorium_talk` VALUES (3, 'common', 'The Q-Link Auditorium can accommodate up to 200 guests. Other PEOPLE CONNECTION rooms limit "occupancy" to 23. To see the number of members in the Auditorium, press F7 for your menu. Select "Leave the Auditorium". From that menu, you can "list" all public rooms.\r\n', 20, 1);
INSERT INTO `auditorium_talk` VALUES (4, 'common', 'For in-depth information about the Auditorium and its special features, be sure to visit the Auditorium Green Room in JUST FOR FUN''s PC Studio.\r\n', 10, 1);
INSERT INTO `auditorium_talk` VALUES (5, 'common', 'The "chat" feature has been disabled in the Auditorium in order to provide more orderly events, making it easier to follow a forum or enjoy the continuity of a game-show.\r\n', 10, 1);
INSERT INTO `auditorium_talk` VALUES (6, 'common', 'To ask a question or make a comment, use the Ask A Question feature from your menu. (Press F7; select by pressing F1.) There may be a delay before your item is aired since other members may be sending items at the same time you are.\r\n', 10, 1);
INSERT INTO `auditorium_talk` VALUES (7, 'common', 'Items sent via Ask A Question are received in the order sent.  Speakers reserve the right to delete items that cannot be understood, are incomplete or duplicated. Use of the Ask A Question feature is governed by Q-Link''s Terms Of Service which may be read in the free CUSTOMER SERVICE CENTER.\r\n', 10, 1);
INSERT INTO `auditorium_talk` VALUES (8, 'max', 'Meet Max Weber. Bon? Wizant? man-about-town, a talk-show host of the future -- TODAY!\r\nMeet Max, Chain-smoking with a propensity for argyle sox, if paired, his only ties with the world of the past. Max brings you guests from a wide array of fascinating areas: fat specialists, programmers on viruses, dating services, gurus and more.  Meet Max. Easy to beat on but hard to beat.  Welcome, Max!\r\n', 10, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `auditorium_text`
-- 

DROP TABLE IF EXISTS `auditorium_text`;
CREATE TABLE `auditorium_text` (
  `auditorium_id` int(11) NOT NULL auto_increment,
  `text` text NOT NULL,
  `start_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`auditorium_id`),
  KEY `start_date` (`start_date`,`end_date`)
) TYPE=MyISAM AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `auditorium_text`
-- 

INSERT INTO `auditorium_text` VALUES (1, '  *******************************\r\n  *  WELCOME TO THE AUDITORIUM  *\r\n  *******************************\r\n\r\n Your name and the names of the \r\n speakers are the only names that\r\n will be displayed\r\n', '0000-00-00 00:00:00', '2005-12-31 00:00:00');
INSERT INTO `auditorium_text` VALUES (2, ' This evening, Max''s guest is\r\n David Mercier, who''ll be discussing\r\n Acupuncture\r\n\r\n What do you think of the use of\r\n acupuncture? Have you ever had it\r\n done? Exactly how safe is it?\r\n\r\n Stay tuned and join Max onstage to\r\n ask YOUR questions in person.\r\n', '0000-00-00 00:00:00', '2005-12-31 00:00:00');

-- --------------------------------------------------------

-- 
-- Table structure for table `bulletin`
-- 

DROP TABLE IF EXISTS `bulletin`;
CREATE TABLE `bulletin` (
  `bulletin_id` int(11) NOT NULL auto_increment,
  `text` text NOT NULL,
  `start_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `approved` enum('N','Y') NOT NULL default 'N',
  PRIMARY KEY  (`bulletin_id`),
  KEY `start_date` (`start_date`,`end_date`),
  KEY `approved` (`approved`)
) TYPE=MyISAM AUTO_INCREMENT=16 ;

-- 
-- Dumping data for table `bulletin`
-- 

INSERT INTO `bulletin` VALUES (1, 'Stay up to date every time you come on-line with our extensive NEWS & INFORMATION Area.\r\n', '0000-00-00 00:00:00', '2005-12-31 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (2, 'Win Qpons! Visit the Learning Center''s Interactive Education Services Contest Challenges Board.\r\n', '0000-00-00 00:00:00', '2005-12-31 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (3, 'ATTN:  The service will be demonstrated at the upcoming Chicago SWRAP EXPO this Saturday at 11AM CDT.  Please join us!', '2005-08-12 00:00:00', '2005-09-30 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (4, 'Thanks to Mark Ponter and associates at ltshosting.net for providing our new server home.  The change should eliminate availability issues.', '2005-08-01 00:00:00', '2005-09-30 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (5, 'ATTN:  Please read "What''s New" in the CUSTOMER SERVICE CENTER for service updates.', '0000-00-00 00:00:00', '2006-01-01 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (6, 'TRIVIA-BUFFS: Catch some exciting "TV Trivia" in PEOPLE CONNECTION''s TRIVIA room on Tuesday @ 8PM Central.', '0000-00-00 00:00:00', '9999-12-31 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (7, 'Welcome, Slashdot crowd!  Your QLink experience awaits...  -- Jim Brain, QADMIN jim, QLink RELOADED developer', '0000-00-00 00:00:00', '9999-12-31 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (8, 'A big Q-Welcome to all the returning Q-Linkers!  The system is still in a beta state and much is left to do, but please enjoy what is working.', '0000-00-00 00:00:00', '2005-09-30 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (9, 'Last night''s changes backed out due to PEOPLE CONNECTION room join bug.  Will fix today and redeploy tonight.', '0000-00-00 00:00:00', '9999-12-31 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (10, 'Returning Q-Linkers: Join the ''Orphans'' for a ''Reunion'' Thursdays, 9PM Central in PEOPLE CONNECTION''s ''OrphansBar'' room.', '0000-00-00 00:00:00', '9999-12-31 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (11, 'Additional User Names functionality now works!  Create up to 5 names.  As well, change user names without logging off! Menu items in CUSTOMER SERVICE CENTER - Account/User Name Management', '0000-00-00 00:00:00', '2005-10-02 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (12, 'Fixed some bugs in new user name functionality, and made user names space-insensitive (sending email to qadminjim will now work)', '0000-00-00 00:00:00', '9999-12-31 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (13, 'Big changes!  Implemented the information dialogs you just used (Data is shown on IDENTIFY menu item).  Added security for QGUIDEs and such to utilize special commands.  Lots of major rework.  Please test.', '0000-00-00 00:00:00', '2005-10-31 00:00:00', 'N');
INSERT INTO `bulletin` VALUES (14, 'Q-Link''s PEOPLE CONNECTION can now link to Internet Relay Chat (IRC).  Simply go to a public room "IRC name", where "name" is the NEWNet IRC channel to join.  More details later in What''s New!', '0000-00-00 00:00:00', '2005-10-09 20:00:00', 'Y');
INSERT INTO `bulletin` VALUES (15, 'Q-Link RELOADED, running build 0.8.3-2005-10-08.  See What''s New for updates', '0000-00-00 00:00:00', '2005-10-31 00:00:00', 'Y');

-- --------------------------------------------------------

-- 
-- Table structure for table `email`
-- 

DROP TABLE IF EXISTS `email`;
CREATE TABLE `email` (
  `email_id` int(11) NOT NULL auto_increment,
  `recipient_id` int(11) NOT NULL default '0',
  `recipient` varchar(255) default NULL,
  `sender_id` int(11) NOT NULL default '0',
  `sender` varchar(255) default NULL,
  `subject` varchar(255) default NULL,
  `body` text NOT NULL,
  `unread` enum('N','Y') NOT NULL default 'Y',
  `received_date` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`email_id`),
  KEY `to_id` (`recipient_id`)
) TYPE=MyISAM AUTO_INCREMENT=721 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `entry_types`
-- 

DROP TABLE IF EXISTS `entry_types`;
CREATE TABLE `entry_types` (
  `reference_id` int(11) NOT NULL default '0',
  `entry_type` int(11) NOT NULL default '0',
  `cost` enum('PREMIUM','NORMAL','NOCHARGE') NOT NULL default 'NORMAL',
  `special` enum('N','Y') NOT NULL default 'N',
  `create_date` datetime NOT NULL default '1990-04-13 00:00:00',
  `last_update` datetime NOT NULL default '1990-04-13 00:00:00',
  PRIMARY KEY  (`reference_id`),
  KEY `reference_id` (`reference_id`)
) TYPE=MyISAM PACK_KEYS=0;

-- 
-- Dumping data for table `entry_types`
-- 

INSERT INTO `entry_types` VALUES (0, 0, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (1, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (2, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (3, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (4, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (5, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (6, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (7, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (8, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (9, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (401, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (402, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (403, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (404, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (405, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (406, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (407, 143, 'NORMAL', 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (500, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (501, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (502, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (600, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (601, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (602, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (603, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (604, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (610, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (611, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (612, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (613, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (614, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (615, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (616, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (800, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (801, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (802, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (803, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (804, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (887, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (1058, 135, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (1422, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (1434, 130, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (2226, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (2291, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (4857, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (8039, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (10483, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (11882, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (13306, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (14001, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (16175, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (17520, 0, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (19786, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (19871, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (21314, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (21830, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (22188, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (22191, 0, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (23977, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (26690, 0, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (28858, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (31225, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (32003, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (32161, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (32237, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (33253, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (33369, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (33703, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (34186, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (34493, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (34519, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (39469, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (40183, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (40184, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (41183, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43246, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (46435, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (47134, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (52388, 132, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (52654, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (58127, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (58519, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (58879, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (59121, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (59976, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (60051, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (63169, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (63726, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (64506, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (65446, 132, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (80619, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (99248, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (100327, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (398624, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (400440, 1, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (401796, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (404256, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (405102, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (405720, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (406365, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (406491, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (412684, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (418134, 1, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (422973, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (422994, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423102, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (424726, 130, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (425184, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (425214, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (425281, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (425283, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (426528, 1, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (430811, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (432729, 1, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (434273, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (437948, 130, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (438079, 139, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (438114, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (439209, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440013, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440575, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440576, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440585, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440612, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440620, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440626, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440669, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440671, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440684, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (442299, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (443050, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (443054, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (443059, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (445131, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (446821, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (446963, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (449800, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (449925, 130, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (450976, 1, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (452666, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (453736, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (454000, 1, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (461276, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (462887, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (465804, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (465808, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (465810, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (465815, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (466634, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (468603, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (472485, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (475467, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (478447, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (483970, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (484758, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (484780, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (484788, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (484790, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (488298, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (489104, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (491337, 12, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (492282, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (492561, 1, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (492576, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (496368, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (496668, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (498609, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (500182, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (500381, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (501192, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (501934, 1, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (501939, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (503892, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (504539, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (504659, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (506677, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (507479, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (507804, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (507806, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (507814, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (507818, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (507829, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (507831, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (508330, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (508885, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (509226, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (510379, 1, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (515033, 1, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (523003, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (523017, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (523031, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (523033, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (523036, 130, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (523041, 130, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (787499, 132, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (788166, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (788720, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (790157, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (794811, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (801815, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (803923, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (816745, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (818137, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (818476, 129, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (823536, 129, 'PREMIUM', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (827252, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (831244, 1, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (833052, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (835141, 12, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (837282, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (845424, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (845758, 136, 'NOCHARGE', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (9999, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (409, 1, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (410, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (411, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (412, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (413, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (414, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (415, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (805, 138, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (416, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (417, 130, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (418, 130, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (419, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (420, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (481595, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (481599, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (21557, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (491789, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (461539, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (495363, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (524075, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (517460, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (491252, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (485368, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (498325, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (523955, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (521007, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (486373, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (462847, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (433696, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (77307, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (5422, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (794784, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (837485, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (797799, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (803440, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (828511, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (422981, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (432048, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (425242, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (398645, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (402959, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (404953, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (430, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (421, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (422, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (424, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (425, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (426, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (427, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (428, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (429, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (431, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (432, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (433, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (434, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (435, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (436, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (437, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (438, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (439, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (440, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (441, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (442, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (443, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (444, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (445, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (450, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (446, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (501935, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (447, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (451, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (448, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (449, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (452, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (453, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (454, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (455, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (456, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (457, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (458, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (459, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (460, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (461, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (462, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (463, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (464, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (465, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (466, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (467, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (468, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (469, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (470, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (471, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (472, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43247, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43248, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43249, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43250, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43251, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43252, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43253, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43254, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43255, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43256, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43257, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43258, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43259, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43260, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43261, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43262, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43263, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43264, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43265, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43266, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43267, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43268, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43269, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43270, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43271, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43272, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43273, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43274, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43275, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43276, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43277, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43278, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43279, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43280, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43281, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43282, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43283, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43284, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43285, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43286, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43287, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43288, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43289, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43290, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43291, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43292, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43293, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43294, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43295, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43296, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43297, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43298, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43299, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43300, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43301, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43302, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43303, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43304, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43305, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43306, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43307, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43308, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43309, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43310, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43311, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43312, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43313, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43314, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43315, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43316, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43317, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43318, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43319, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43320, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43321, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43322, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43323, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43324, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43325, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43326, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43327, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43328, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43329, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43330, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43331, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43332, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43333, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43334, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43335, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43336, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43337, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43338, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43339, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43340, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43341, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43342, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43343, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43344, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43345, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43346, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43347, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43348, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43349, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43350, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43351, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43352, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43353, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43354, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43355, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43356, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43357, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43358, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43359, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43360, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43361, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43362, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43363, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43364, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43365, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43366, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43367, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43368, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43369, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43370, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43371, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43372, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43373, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43374, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43375, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43376, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43377, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43378, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43379, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43380, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43381, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43382, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43383, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43384, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43385, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43386, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43387, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43388, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43389, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43390, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43391, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43392, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43393, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43394, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43395, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43396, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43397, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43398, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43399, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43400, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43401, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43402, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43403, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43404, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43405, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43406, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43407, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43408, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43409, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43410, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43411, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43412, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43413, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43414, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43415, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43416, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43417, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43418, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43419, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43420, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43421, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43422, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43423, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43424, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43425, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43426, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43427, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43428, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43429, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43430, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43431, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43432, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43433, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43434, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43435, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43436, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43437, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43438, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43439, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43440, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43441, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43442, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43443, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43444, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43445, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43446, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43447, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43448, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43449, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43450, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43451, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43452, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43453, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43454, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43455, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43456, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43457, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43458, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43459, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43460, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43461, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43462, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43463, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43464, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43465, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43466, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43467, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43468, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43469, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43470, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43471, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43472, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43473, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43474, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43475, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43476, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43477, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43478, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43479, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43480, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43481, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43482, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43483, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43484, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43485, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43486, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43487, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43488, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43489, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43490, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43491, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43492, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43493, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43494, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43495, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43496, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43497, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43498, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43499, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43500, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43501, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43502, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43503, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43504, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43505, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43506, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43507, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43508, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43509, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43510, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43511, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43512, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43513, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43514, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43515, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43516, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43517, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43518, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43519, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43520, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43521, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43522, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43523, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43524, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43525, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43526, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43527, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43528, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43529, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43530, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43531, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43532, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43533, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43534, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43535, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43536, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43537, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43538, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43539, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43540, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43541, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43542, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43543, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43544, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43545, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43546, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43547, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43548, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43549, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43550, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43551, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43552, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43553, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43554, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43555, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43556, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43557, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43558, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43559, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43560, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43561, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43562, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43563, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43564, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43565, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43566, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43567, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43568, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43569, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43570, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43571, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43572, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43573, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43574, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43575, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43576, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43577, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43578, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43579, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43580, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43581, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43582, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43583, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43584, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43585, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43586, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43587, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43588, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43589, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43590, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43591, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43592, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43593, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43594, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43595, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43596, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43597, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43598, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43599, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43600, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43601, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43602, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43603, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43604, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43605, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43606, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43607, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43608, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43609, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43610, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43611, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43612, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43613, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43614, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43615, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43616, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43617, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43618, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43619, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43620, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43621, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43622, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43623, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43624, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43625, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43626, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43627, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43628, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43629, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43630, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43631, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43632, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43633, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43634, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43635, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43636, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43637, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43638, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43639, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43640, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43641, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43642, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43643, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43644, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43645, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43646, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43647, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43648, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43649, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43650, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43651, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43652, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43653, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43654, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43655, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43656, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43657, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43658, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43659, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43660, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43661, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43662, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43663, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43664, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43665, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43666, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43667, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43668, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43669, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43670, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43671, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43672, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43673, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43674, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43675, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (43676, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423103, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423104, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423105, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423106, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423107, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423108, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423109, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423110, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423111, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423112, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423113, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423114, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423115, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423116, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423117, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423118, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423119, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423120, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423121, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423122, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423123, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423124, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423125, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423126, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423127, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423128, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423129, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423130, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423131, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423132, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423133, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423134, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423135, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423136, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423137, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423138, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423139, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423140, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423141, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423142, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423143, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423144, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423145, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423146, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423147, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423148, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423149, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423150, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423151, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423152, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423153, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423154, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423155, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423156, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423157, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423158, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423159, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423160, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423161, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423162, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423163, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423164, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423165, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423166, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423167, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423168, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423169, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423170, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423171, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423172, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423173, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423174, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423175, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423176, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423177, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423178, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423179, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423180, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423181, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423182, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423183, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423184, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423185, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423186, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423187, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423188, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423189, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423190, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423191, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423192, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423193, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423194, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423195, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423196, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423197, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423198, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423199, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423200, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423201, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423202, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423203, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423204, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423205, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423206, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423207, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423208, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423209, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423210, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423211, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423212, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423213, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423214, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423215, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423216, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423217, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423218, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423219, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423220, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423221, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423222, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423223, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423224, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423225, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423226, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423227, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (423228, 129, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (473, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (474, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (475, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (476, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (477, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (478, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (479, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (480, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (481, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (482, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (483, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (484, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (485, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (486, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (487, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (488, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (489, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (490, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (491, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (492, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (493, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (494, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (495, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (496, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (497, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (900, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (901, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (902, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (903, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (498, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (499, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (503, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (504, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (505, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (506, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (507, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (508, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (509, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (510, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (904, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (905, 136, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (511, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (512, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (513, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (514, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (515, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (516, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (517, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (408, 129, 'NOCHARGE', 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (1000000, 129, 'NOCHARGE', 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (1000001, 143, 'NOCHARGE', 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (518, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (519, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (520, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (521, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (522, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (523, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (524, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (525, 2, 'NORMAL', 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `entry_types` VALUES (526, 2, 'NORMAL', 'N', '2005-10-01 01:21:00', '2005-10-01 01:21:00');
INSERT INTO `entry_types` VALUES (527, 2, 'NORMAL', 'N', '2005-10-01 22:18:58', '2005-10-01 22:18:58');
INSERT INTO `entry_types` VALUES (528, 2, 'NORMAL', 'N', '2005-10-02 03:28:19', '2005-10-02 03:28:19');
INSERT INTO `entry_types` VALUES (529, 2, 'NORMAL', 'N', '2005-10-02 11:23:06', '2005-10-02 11:23:06');
INSERT INTO `entry_types` VALUES (530, 2, 'NORMAL', 'N', '2005-10-03 11:07:59', '2005-10-03 11:07:59');
INSERT INTO `entry_types` VALUES (801816, 129, 'NORMAL', 'N', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `entry_types` VALUES (531, 2, 'NORMAL', 'N', '2005-10-04 07:31:35', '2005-10-04 07:31:35');
INSERT INTO `entry_types` VALUES (532, 2, 'NORMAL', 'N', '2005-10-04 19:49:24', '2005-10-04 19:49:24');
INSERT INTO `entry_types` VALUES (533, 2, 'NORMAL', 'N', '2005-10-04 19:54:20', '2005-10-04 19:54:20');
INSERT INTO `entry_types` VALUES (1000002, 130, 'NOCHARGE', 'Y', '2005-10-08 00:39:14', '2005-10-08 00:39:14');
INSERT INTO `entry_types` VALUES (1000003, 136, 'NOCHARGE', 'N', '2005-10-08 00:39:14', '2005-10-08 00:39:14');
INSERT INTO `entry_types` VALUES (1000004, 136, 'NOCHARGE', 'N', '2005-10-08 00:41:22', '2005-10-08 00:41:22');
INSERT INTO `entry_types` VALUES (1000005, 136, 'NOCHARGE', 'N', '2005-10-08 00:41:22', '2005-10-08 00:41:22');
INSERT INTO `entry_types` VALUES (1000006, 136, 'NOCHARGE', 'N', '2005-10-08 00:43:30', '2005-10-08 00:43:30');

-- --------------------------------------------------------

-- 
-- Table structure for table `files`
-- 

DROP TABLE IF EXISTS `files`;
CREATE TABLE `files` (
  `file_id` int(11) NOT NULL auto_increment,
  `reference_id` int(11) NOT NULL default '0',
  `name` varchar(16) NOT NULL default '',
  `filetype` enum('prg','seq') NOT NULL default 'prg',
  `description` text,
  `data` mediumblob NOT NULL,
  PRIMARY KEY  (`file_id`),
  KEY `reference_id` (`reference_id`,`name`)
) TYPE=MyISAM AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `files`
-- 

INSERT INTO `files` VALUES (1, 805, 'my1stdl.prg', 'prg', 'This is the sample Download Q-Link used to offer', 0x01083d0800008bb628c228363535333329b232353529a79922111120544849532046494c452052554e5320494e203634204d4f4445204f4e4c59223a80007d0801004d48b23031383a4d4cb23032333a9e363034333a9734393136392c4d4c3a9734393137302c4d483a9734393136372c4d4c3a9734393136382c4d4800b50802009734393137322c2e3a9e34393135353a973830382c3233393a9735333238302c2e3a9735333238312c2e3a9734393137322c3700e30803004124b2222020202020c8454c4c4f204e455720d12dccc9cecb20444f574e4c4f4144455221203a292200100904004224b222d7454c4c2c204954204c4f4f4b53204c494b4520594f5527564520444f4e452049542e22003c0905004324b222d94f5527564520444f574e4c4f4144454420594f55522046495253542046494c452122006f0906004eb2c3284124293a4db2c3284224293a4fb2c3284324293a54b2333a864124284e292c4224284d292c4324284f2900a009070099229311990e08223a973637372c303a814ab231a432303a9941243a9e35393737373a993a99221311223a8200bd0908008144b23332373638a444aa3330343a87593a97442c593a8200f30909008149b231a4313030303a823a8158b23234a434a9ab313a973738312c583a9e35393930333a823a4bb2333a814ab231a44d00300a0a0099221311111111119e223a4224284a29b2ca2842242c4a2c31293a8149b23339a44ba9ab313a99a349294224284a2922201311111111112200600a0b00823a4bb24baa313a823a814ab231a44f3a4324284a29b2ca2843242c4a2c31293a8158b23231a438a9ab3100910a0c009922139f223a973231342c583a993a99a354294324284a293ba354aa3430292220223a823a54b254aa313a8200a70a0d00973737302c3133313a973737312c31363400dd0a0e009738382c2e3a9738392c3139323a9739302c2e3a9739312c3139323a973738312c33333a973738322c2e3a9e343139363400170b0f009738382c3235343a9738392c3235353a9739302c3235343a9739312c3235353a973738312c33333a973738322c2e3a9e3431393634003b0b10009735393633392c31303a97312cc2283129af3235333a973231342c32303a9900680b110099220520202020a62020202020a62020a6a6a6a6a6a6a6202020202020a6202020202020a6a6a62200950b12009922052020202020a6202020a6202020a62020202020202020202020a620a62020202020a6a6a62200c20b1300992205202020202020a620a620202020a620202020202020202020a6202020a620202020a6a6a62200ef0b140099220520202020202020a62020202020a6a6a6a6202020202020a62020202020a6202020a6a6a622001c0c150099220520202020202020a62020202020a6202020202020202020a6a6a6a6a6a6a620202020a6202200490c160099220520202020202020a62020202020a6202020202020202020a62020202020a620202020a6202200790c170099220520202020202020a62020202020a6a6a6a6a6a6a6202020a62020202020a6202020204f111111112200a90c18009735333236352cc228353332363529af323535ab383a9735333237302cc228353332373029af323535ab3800c30c19008149b231303235a449aa33383a97492c3130323a8200e00c1a008149b231303632a432303233a934303a97492c3130323a8200fd0c1b008149b232303233a431393834a9ab313a97492c3130323a82001b0d1c008149b231393835a431303235a9ab34303a97492c3130323a8200450d1d009735363235322c31313a9735363235332c31313a97313938302c31313a97313938312c353500590d1e009e20343631353a9735333238302c32008d0d1f0097322c32323a97332c3131333a97342c373a97352c3135303a97362c373a973137362c3232363a973137372c32333500ab0d2000973235312c3131383a973235322c3132383a973634362c313000b60d21009e333237363800d30d220091ab28c22831393729b2363429893334203a9e363531323600f00d23008144b23332373638a444aa3330343a87593a97442c593a8200340e2400833132302c3136362c322c33322c3235352c3233332c3136352c3235312c3133332c3235332c3136352c3235322c3133332c3235342c3136392c372c31333300740e2500833235352c3136302c312c3137372c332c3133362c3134352c332c3230302c3230302c3139322c34312c3230382c3234352c3136322c302c31363100b70e2600833235332c3230312c39352c3230382c31322c3136352c3235312c3133332c3235332c3136352c3235322c3133332c3235342c392c312c3230382c32333600f90e2700833233342c3233342c3136302c302c3134352c352c3233302c3235332c3230382c322c3233302c3235342c3137332c31382c3230382c3139372c313736003d0f2800833230382c3234392c3137332c32322c3230382c34312c3234382c32342c3130312c3235352c3134312c32322c3230382c3137332c31382c3230382c313937007f0f2900833137372c3230382c3234392c3137332c32322c3230382c34312c3234382c3134312c32322c3230382c3137332c312c3232302c34312c31362c32343000be0f2a0083382c3139382c3235352c3136352c3235352c31362c3231302c34382c3135392c3136362c322c33322c3235352c3233332c38382c39362c383000f30f2b008331382c31352c372c31382c312c31332c33322c322c32352c33322c38322c34362c33322c38372c34362c33322c37350028102c008331352c322c352c31382c33322c33322c34352c34352c33322c33322c36352c32312c32302c31352c34352c38322c35005b102d008331322c31352c332c312c32302c352c31382c33322c322c32352c33322c37342c31352c382c31342c33322c37360090102e0083352c352c31392c31352c31342c33322c33322c34352c34352c33322c33322c38332c37332c36382c38302c31322c3100c3102f008332352c352c31382c33322c37372c31352c342c32312c31322c352c33322c322c32352c33322c37372c312c313800f81030008331312c33322c36352c34362c33322c36382c392c332c31312c352c31342c31392c31352c31342c33322c33322c3435002c1131008334352c33322c33322c38332c37332c36382c33322c36352c31382c31382c312c31342c372c352c31332c352c3134005f1132008332302c33322c322c32352c33322c37382c392c332c31312c33322c39302c352c31322c392c31342c31392c313100971133008332352c33322c33322c34352c34352c34352c34352c34352c34352c34352c33322c38302c31382c30352c31392c31392c333200cf1134008331392c31362c30312c30332c30352c33322c32302c31352c33322c30352c32342c30392c32302c33322c34352c34352c343500041235008334352c34352c34352c34352c34352c33322c33322c39352c33322c33322c33322c33322c33322c33322c33322c333200000034ee20d0a01888d0fdad14c0d0f36000342e0278017a01064001ae0137960201fa011b014b0114014001e401a82605018742b056fd1e001400460110001e01010646011099109c109e10911e02149210935492109210001e034602109a109d10df10921e04149310945493109310001e054603109b109e105110931e06149410955494109410001e074601360214921092549310931000010f1e0846021493149310931094145454951e092c9510001e0a012fa6b301164601100010941094149554961e0b1096460210951094149554941e0c109410921092149254931e0d2c9310001e0e4601100010941094149554961e0f109610951094149554941e101094460210921092149254931e112c931000012fa60e1e124601149c109c549c149c309c1e13149e109e549d549d109c4601149c1e1414df14df14df54df14df30df1e154603109214925491549130df1e164602109d149d549d149d309d1e17109f149f549e549e309d1e184601109114915491149110915495149510935491109110001e1a01121e1b4601109c149c549c149c309c1e1c109e149e549d0c9d1e1d460110df14df54df14df30df1e1e1492109254df0cdf1e1f4601149d109d549d149d309d1e20149f109f549d0c9d1e21460114911491149154911491109154951e22149510935491109110000102a6b3322001121e234601100010941094149554961e24109610951094149554941e251094460110921092149254931e26109310931094149554941e270c944602509310921e280c910cde1e29489e1e2a089e1e2b014f0114013001b4014826010187322056fe760486031e00140010001e0101560ca10ca41e022ca610001e030ca20ca51e042ca510001e050ca30ca61e062ca6109a1e07360230df549d109d1000010f1e080c9b109c145c549d1e092c9d10001e0a012f0166a6b31000109e109e149e14001e0b1000109e1000149e14001e0c1000109c1000149c14001e0d10001091100010911e0e1000109e109e149e14001e0f1000109e1000149e14001e101000109c1000149c14001e1110001091100010911e12012fa60e017610a610000c001e13109910000c001e14109a10000c001e151400309a14591400149914001e1610a710000c001e17109a10000c001e18149b14001000149b14001400549b1e19012f149b140010000c001e1a016201721e1b149b140010000c001e1ca60e015201621e281000109e109e149e14001e291000109e1000149e14001e2a1000109c1000149c14001e2b1000109d1000149d549c1e2c0c9c0c9b1e2d0c9a0c9a1e2e48991e2f08a61e30014f0114013001c401482602018722bc56031e0014a210a11e0101a608ac1e022ca210ae1e0308ad1e042ca110ad1e0508ae1e062ca2a6b3109a1e07a60e360230e75499109910a51e08010f0ca510ef14af54a110a11e0910ef10ae10ad1e0a012f01b610ac140054ac10ac10ab1e0b10aa140054aa10aa10a91e0c10f7140054f710f710f71e0d10a9140054a910a910a91e0e10ac140054ac10ac10ab1e0f10aa140054aa10aa10a91e1010f7140054f710f710f71e1110a9140054a910a910a91e12012f01c610a110000c001e1310ac10000c001e1410ef10000c001e15140030ef14ae140014ee14001e1610ad10000c001e1710ad10000c001e1814a11400100014a11400140054a11e19012f14a114a110ef10ae10ad1e1a01b201c21e1b14a114a110ef10ae10ad1e1c01a201b21e2810ac140054ac10ac10ab1e2910aa140054aa10aa10a91e2a10f7140054f710f710f71e2b10a9140054ad10ad14a154ef1e2c0cef0cae1e2d0cad0cef1e2e48ac1e2f08ac1e30014f484150505920444159530d4c5952494353204259204e4f524d414e2047494d424c450d4d5553494320425920434841524c455320464f580d53494420415252414e47454d454e54204259204e49434b205a454c494e534b590d0000340010a96085fb7820fb00bacabd000185fbbd010185fc5818a95165fb85fba90065fc85fca000b1fb85fdc8b1fb85fe389865fb85fba5fc690085fca000b1fb91fde6fbd002e6fce6fdd002e6fea5fcc52e9004a5fbc52d90e46000c04c08ca2072c22090c22040c94c57c900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004551204c424c34330d2042504c204c424c34340d20494e590d4c424c343420434c430d204144432056415233360d2001005048410d20414e442023370d205354412056415233360d20535400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000524432290d4c424c3438204a5352204c424c3035410d4c424c3435204c4441204c424c30370d20414e442056415231010a342c580d20424551204c424c34370d204c44592023300d204c444cdbc34c94c671c300002cc22cc22cc26001020400070e0100ff0002040507090b1e188b7efa06acf3e68ff82e868e969fa8b3bdc8d4e1eefd8c7864503c2814000002030507080a0c0d0f111200e00004080cf900f578ad13c0c900f014a202bd13039d23c2bd21c29d1303cad0f18e15c05860ad13c0c900d001608dd8c28ddbc28ddec28de6c28decc48dfec48d24c68d2cc68d17c88d4fc88d7ac88d9bc88dcac6a9008d15c0ae11c08602ac12c08403a0c4991cc188d0fa8d17d48d15d48d16d4a9088d39c18d18d4a9908d3ac1a90c8d3bc1ad13c08505a202a9019d3dc1a9049d43c1a9049d8bc1bd6bc29da6c1bd30c28504a900a0029104a9089d2ac19d7fc1c89104c89104a9409d2dc19104a9209d30c1c89104a9f59d33c1c89104ca10b8a5021869068504a900aaa8650385059d9ac19da0c1a5049d97c19d9dc11871028504a505c87102c8e8e003d0e0a604a860ad0ddcad15c030570980a82907f055d88c15c0ad13c08503a200ad15c03d2dc2f00d8e3cc1201cc2ad15c02978d032e8e003d0e6caad15c03d2dc2f019bd30c28502bd21c1a0009102bd24c1c89102bd94c1a0049102ca10dcad15c0297f2ca9088d15c06c24c26c26c2bd30c28502de3dc1f04fbd40c130eed00ebd43c1dd3dc19006bd2dc19d94c1bd46c1f0560abd21c1b0317d49c19d21c1a8bd24c17d4cc19d24c14898dd70c168fd73c19033bd70c19d21c1bd73c19d24c1a9009d46c118901ff075fd49c19d21c1bd24c1fd4cc19d24c1bd70c1dd21c1bd73c1fd24c1b0cd9065bd4fc1f060a000de52c1d031bd55c11d58c1d01bbd61c19d5bc19d52c1bd4fc10abd5ec1900449ff69009d4fc1d010bd5bc19d52c19838fd4fc19d4fc1c900100188187d55c19d55c148987d58c19d58c1a868189002f0557d70c19d21c1987d73c19d24c1bd76c1f017187d27c19d27c1a0029102bd79c17d2ac19d2ac1c89102a000bd85c1f0221001c8186d36c14829078d36c18d15d4686a4a4a187969c2186d37c18d37c18d16d46c26c2bd97c18504bd9ac18505d0066c28c2201fc2ad15c03d2dc2f0f2a000b1048506c8b104a8a50418690285049d97c1a505690085059d9ac1a5062903d0d2bd70c19d21c1bd73c19d24c1989d1ec129384a4a4a7d64c185049829c00a2a2aa8b932c28505bd1ec12907f068d002f092a8b935c26505187d67c1100518690ce604c90c9004e90cc6048505a8a50648b949c28506b93dc2a40488300646066a8810fa187d6ac19d70c1a5067d6dc19d73c1688506291cf0b6bd49c11d4cc1f016bd21c1dd70c1bd24c1fd73c1a9fe6a9d46c19011f0579d46c1bd70c19d21c1bd73c19d24c1bd40c10ad042bd76c1f013bd7cc19d27c1a0029102bd7fc19d2ac1c89102bd82c1f00fa404187955c2a40518795dc2189008bd85c1f011bd88c18d37c18d16d4a9008d36c18d15d4a506a8292085069829409d40c198291c4a4aa8ad3bc188f01cad3ac1d0013888f0066ab03988d0faa4068506f0074ab02d6506b02c9d3dc1bd8bc10a0a1d8ec10a1d91c10a9d2dc138bd1ec12907d0037e40c1bd2dc169009d94c16c28c2a9102ca9188d15c0609848a5064ab0744a4ab01f4ab00f9d7fc1a0039102689d7cc1889102604a900209f89d6dc1689d6ac1604a900b4a68b0069d88c18d16d460a8f0256888f02688f02788f02888f03588f03688f03f88f04088f05c88f05d88f05e9d1bc06c2ac2688d3ac1608d3bc1609d43c1609da3c1a5049d9dc1a5059da0c160b0558d17c0609d76c10a900188989d79c1609d85c160a8d0049d4fc1609d5ec1bc4fc1d00f9d4fc1989d55c19d58c1a9019d52c1609d61c1609d82c1604a9002c818482907796fc29d64c1684a4a4a187970c29d67c1604a90089d4cc1689d49c160684ab05c4ab02c4ab0054aa0f0d0060a0a0a0aa00f850698a005b00b3d30c105069d30c19102603d33c105069d33c1c89102604ab02c4ab0528506bda6c1dd6cc2f042fea6c1a8a50499a9c1a50599b5c1a406b9d1c1f02a8505b9c1c1850460b0464ab034a8a50499c1c1a50599d1c1bda6c1dd6cc2f00dfea6c1a8a90099b5c160a9302ca9288d15c0600a0a0a0a4d38c129f04d38c1906b4d39c1290f4d39c18d39c18d18d4604a4ab05f4aa8f01788f02d88f03988f03c88f03fad39c1297f90620980b05eac39c1b007c898290fd0076098290ff007888c39c18c18d460bd2dc249ff2d38c1901a1d2dc2b015982a9d8ec160982a9d91c160ad38c129f7900209088d38c18d17d4604ab01e4ab008d002a9089d8bc1600a0a0a0a4d39c129704d39c18d39c18d18d4604aa8d015bda3c1f005dea3c1f00abd9dc18504bda0c185056088d020bda6c1dd6bc2f012dea6c1a888b9b5c1f0078505b9a9c1850460a9208d15c060ad15c05d2dc28d15c088989102c89102604c8bca4c44cd1fca0000fac8fac8fac86001020400070e0100ff0002040507090b1e188b7efa06acf3e68ff82e868e969fa8b3bdc8d4e1eefd8c7864503c2814000002030507080a0c0d0f111200e00004080cf900f578a202bd13039df1c8bdefc89d1303cad0f18e14c05860a9008d14c0ae0fc086fbac10c084fca0cc9914c088d0fa8d17d48d15d48d16d4a9088d39c08d18d4a9908d3ac0a90c8d3bc0a9d485fea202a9019d3dc0a9049d43c0a9049d8bc0bd39c99da6c0bdfec885fda900a00291fda9089d2ac09d7fc0c891fdc891fda9409d2dc091fda9209d30c0c891fda9f59d33c0c891fdca10b8a5fb18690685fda900aaa865fc85fe9d9ac09da0c0a5fd9d97c09d9dc01871fb85fda5fec871fbc8e8e003d0e0a6fda86078a9318d1403a9ea8d1503a9008d1ad0a9818d0ddc5860ad0ddcad14c030590980a82907f057d88c14c0a9d485fcad3403a200ad14c03dfbc8f00d8e3cc020eac8ad14c02978d032e8e003d0e6caad14c03dfbc8f019bdfec885fbbd21c0a00091fbbd24c0c891fbbd94c0a00491fbca10dcad14c0297f2ca9088d14c06cf2c86cf4c8bdfec885fbde3dc0f04fbd40c030eed00ebd43c0dd3dc09006bd2dc09d94c0bd46c0f0560abd21c0b0317d49c09d21c0a8bd24c07d4cc09d24c04898dd70c068fd73c09033bd70c09d21c0bd73c09d24c0a9009d46c018901ff075fd49c09d21c0bd24c0fd4cc09d24c0bd70c0dd21c0bd73c0fd24c0b0cd9065bd4fc0f060a000de52c0d031bd55c01d58c0d01bbd61c09d5bc09d52c0bd4fc00abd5ec0900449ff69009d4fc0d010bd5bc09d52c09838fd4fc09d4fc0c900100188187d55c09d55c048987d58c09d58c0a868189002f0557d70c09d21c0987d73c09d24c0bd76c0f017187d27c09d27c0a00291fbbd79c07d2ac09d2ac0c891fba000bd85c0f0221001c8186d36c04829078d36c08d15d4686a4a4a187937c9186d37c08d37c08d16d46cf4c8bd97c085fdbd9ac085fed0066cf6c820edc8ad14c03dfbc8f0f2a000b1fd85ffc8b1fda8a5fd18690285fd9d97c0a5fe690085fe9d9ac0a5ff2903d0d2bd70c09d21c0bd73c09d24c0989d1ec029384a4a4a7d64c085fd9829c00a2a2aa8b900c985febd1ec02907f068d002f092a8b903c965fe187d67c0100518690ce6fdc90c9004e90cc6fd85fea8a5ff48b917c985ffb90bc9a4fd88300646ff6a8810fa187d6ac09d70c0a5ff7d6dc09d73c06885ff291cf0b6bd49c01d4cc0f016bd21c0dd70c0bd24c0fd73c0a9fe6a9d46c09011f0579d46c0bd70c09d21c0bd73c09d24c0bd40c00ad042bd76c0f013bd7cc09d27c0a00291fbbd7fc09d2ac0c891fbbd82c0f00fa4fd187923c9a4fe18792bc9189008bd85c0f011bd88c08d37c08d16d4a9008d36c08d15d4a5ffa8292085ff9829409d40c098291c4a4aa8ad3bc088f01cad3ac0d0013888f0066ab03988d0faa4ff85fff0074ab02d65ffb02c9d3dc0bd8bc00a0a1d8ec00a1d91c00a9d2dc038bd1ec02907d0037e40c0bd2dc069009d94c06cf6c8a9102ca9188d14c0609848a5ff4ab0744a4ab01f4ab00f9d7fc0a00391fb689d7cc08891fb604a900209f89d6dc0689d6ac0604a900b4a68b0069d88c08d16d460a8f0256888f02688f02788f02888f03588f03688f03f88f04088f05c88f05d88f05e9d18c06cf8c8688d3ac0608d3bc0609d43c0609da3c0a5fd9d9dc0a5fe9da0c060b0558d16c0609d76c00a900188989d79c0609d85c060a8d0049d4fc0609d5ec0bc4fc0d00f9d4fc0989d55c09d58c0a9019d52c0609d61c0609d82c0604a9002c818482907793dc99d64c0684a4a4a18793ec99d67c0604a90089d4cc0689d49c060684ab05c4ab02c4ab0054aa0f0d0060a0a0a0aa00f85ff98a005b00b3d30c005ff9d30c091fb603d33c005ff9d33c0c891fb604ab02c4ab05285ffbda6c0dd3ac9f042fea6c0a8a5fd99a9c0a5fe99b5c0a4ffb9d1c0f02a85feb9c1c085fd60b0464ab034a8a5fd99c1c0a5fe99d1c0bda6c0dd3ac9f00dfea6c0a8a90099b5c060a9302ca9288d14c0600a0a0a0a4d38c029f04d38c0906b4d39c0290f4d39c08d39c08d18d4604a4ab05f4aa8f01788f02d88f03988f03c88f03fad39c0297f90620980b05eac39c0b007c898290fd0076098290ff007888c39c08c18d460bdfbc849ff2d38c0901a1dfbc8b015982a9d8ec060982a9d91c060ad38c029f7900209088d38c08d17d4604ab01e4ab008d002a9089d8bc0600a0a0a0a4d39c029704d39c08d39c08d18d4604aa8d015bda3c0f005dea3c0f00abd9dc085fdbda0c085fe6088d020bda6c0dd39c9f012dea6c0a888b9b5c0f00785feb9a9c085fd60a9208d14c060ad14c05dfbc88d14c0889891fbc891fb605230342c580d1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a);

-- --------------------------------------------------------

-- 
-- Table structure for table `gateways`
-- 

DROP TABLE IF EXISTS `gateways`;
CREATE TABLE `gateways` (
  `gateway_id` int(11) NOT NULL default '0',
  `address` varchar(255) NOT NULL default '',
  `port` int(11) NOT NULL default '0',
  PRIMARY KEY  (`gateway_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `gateways`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `messages`
-- 

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL auto_increment,
  `reference_id` int(11) NOT NULL default '0',
  `parent_id` int(11) NOT NULL default '0',
  `base_id` int(11) NOT NULL default '0',
  `title` varchar(33) NOT NULL default '',
  `author` varchar(10) NOT NULL default '',
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `replies` int(11) NOT NULL default '0',
  `text` text NOT NULL,
  PRIMARY KEY  (`message_id`),
  KEY `base_id` (`base_id`,`date`)
) TYPE=MyISAM PACK_KEYS=0 AUTO_INCREMENT=121 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `reference_handlers`
-- 

DROP TABLE IF EXISTS `reference_handlers`;
CREATE TABLE `reference_handlers` (
  `reference_id` int(11) NOT NULL default '0',
  `handler` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`reference_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `reference_handlers`
-- 

INSERT INTO `reference_handlers` VALUES (407, 'org.jbrain.qlink.state.AddUserNameState');
INSERT INTO `reference_handlers` VALUES (408, 'org.jbrain.qlink.state.DeleteUserNameState');
INSERT INTO `reference_handlers` VALUES (1000000, 'org.jbrain.qlink.state.ChangeUserNameState');
INSERT INTO `reference_handlers` VALUES (1000001, 'org.jbrain.qlink.state.TerminateDiskState');

-- --------------------------------------------------------

-- 
-- Table structure for table `reserved_names`
-- 

DROP TABLE IF EXISTS `reserved_names`;
CREATE TABLE `reserved_names` (
  `name` varchar(10) NOT NULL default '',
  UNIQUE KEY `name` (`name`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `reserved_names`
-- 

INSERT INTO `reserved_names` VALUES ('1nternet');
INSERT INTO `reserved_names` VALUES ('a01');
INSERT INTO `reserved_names` VALUES ('a0l');
INSERT INTO `reserved_names` VALUES ('adm1n');
INSERT INTO `reserved_names` VALUES ('admin');
INSERT INTO `reserved_names` VALUES ('ao1');
INSERT INTO `reserved_names` VALUES ('aol');
INSERT INTO `reserved_names` VALUES ('Brain');
INSERT INTO `reserved_names` VALUES ('buttrfield');
INSERT INTO `reserved_names` VALUES ('cmd');
INSERT INTO `reserved_names` VALUES ('cmdrkey');
INSERT INTO `reserved_names` VALUES ('ge0rep');
INSERT INTO `reserved_names` VALUES ('GeoRep');
INSERT INTO `reserved_names` VALUES ('ide64');
INSERT INTO `reserved_names` VALUES ('INTERNET');
INSERT INTO `reserved_names` VALUES ('JBrain');
INSERT INTO `reserved_names` VALUES ('jennyc');
INSERT INTO `reserved_names` VALUES ('jeri');
INSERT INTO `reserved_names` VALUES ('JimBrain');
INSERT INTO `reserved_names` VALUES ('MODERATOR');
INSERT INTO `reserved_names` VALUES ('modernity');
INSERT INTO `reserved_names` VALUES ('Q1ink');
INSERT INTO `reserved_names` VALUES ('q1link');
INSERT INTO `reserved_names` VALUES ('qadm1n');
INSERT INTO `reserved_names` VALUES ('QADMIN');
INSERT INTO `reserved_names` VALUES ('QD1ety');
INSERT INTO `reserved_names` VALUES ('QDIETY');
INSERT INTO `reserved_names` VALUES ('QDJ');
INSERT INTO `reserved_names` VALUES ('qg0d');
INSERT INTO `reserved_names` VALUES ('QGAME');
INSERT INTO `reserved_names` VALUES ('QGOD');
INSERT INTO `reserved_names` VALUES ('qgraph');
INSERT INTO `reserved_names` VALUES ('qgu1de');
INSERT INTO `reserved_names` VALUES ('QGUIDE');
INSERT INTO `reserved_names` VALUES ('qhelp');
INSERT INTO `reserved_names` VALUES ('ql1ink');
INSERT INTO `reserved_names` VALUES ('ql1nk');
INSERT INTO `reserved_names` VALUES ('Qlink');
INSERT INTO `reserved_names` VALUES ('qm0n');
INSERT INTO `reserved_names` VALUES ('qmail');
INSERT INTO `reserved_names` VALUES ('qmon');
INSERT INTO `reserved_names` VALUES ('qop');
INSERT INTO `reserved_names` VALUES ('qp');
INSERT INTO `reserved_names` VALUES ('qpon');
INSERT INTO `reserved_names` VALUES ('qrep');
INSERT INTO `reserved_names` VALUES ('QRJ');
INSERT INTO `reserved_names` VALUES ('qsav');
INSERT INTO `reserved_names` VALUES ('qsig');
INSERT INTO `reserved_names` VALUES ('qsu');
INSERT INTO `reserved_names` VALUES ('qsys');
INSERT INTO `reserved_names` VALUES ('QTEND');
INSERT INTO `reserved_names` VALUES ('QTEST');
INSERT INTO `reserved_names` VALUES ('QTR1V');
INSERT INTO `reserved_names` VALUES ('QTRIV');
INSERT INTO `reserved_names` VALUES ('qtutor');
INSERT INTO `reserved_names` VALUES ('sys0p');
INSERT INTO `reserved_names` VALUES ('SYSOP');
INSERT INTO `reserved_names` VALUES ('System');
INSERT INTO `reserved_names` VALUES ('t0s');
INSERT INTO `reserved_names` VALUES ('tos');

-- --------------------------------------------------------

-- 
-- Table structure for table `toc`
-- 

DROP TABLE IF EXISTS `toc`;
CREATE TABLE `toc` (
  `toc_id` int(11) NOT NULL auto_increment,
  `menu_id` int(11) NOT NULL default '0',
  `reference_id` int(11) NOT NULL default '0',
  `title` varchar(40) NOT NULL default '',
  `sort_order` int(11) NOT NULL default '1',
  `active` enum('N','Y') NOT NULL default 'Y',
  `create_date` datetime NOT NULL default '1990-04-13 00:00:00',
  `last_update` datetime NOT NULL default '1990-04-13 00:00:00',
  PRIMARY KEY  (`toc_id`),
  KEY `reference_id` (`reference_id`),
  KEY `parent_id` (`menu_id`)
) TYPE=MyISAM PACK_KEYS=0 AUTO_INCREMENT=906 ;

-- 
-- Dumping data for table `toc`
-- 

INSERT INTO `toc` VALUES (1, 0, 1, 'Unknown Item', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (2, 0, 2, 'The Mall', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (3, 0, 3, 'Unknown Item', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (4, 0, 4, 'Customer Service Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (5, 0, 5, 'Commodore Software Showcase', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (6, 0, 6, 'Just For Fun', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (7, 0, 7, 'Learning Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (8, 0, 8, 'News & Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (9, 0, 9, 'Commodore Information Network', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (10, 5, 65446, 'NEW 1990-91 PD Software Directory!', 1, 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (11, 5, 21314, 'Software Series: GAMING', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (12, 5, 468603, 'Software Buyer''s Guide', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (13, 5, 47134, 'Software Support Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (14, 5, 31225, 'GEOS Arena', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (15, 5, 483970, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (16, 5, 508885, 'Special Edition Software', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (17, 5, 1058, 'Q-Link Post Office', 1, 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (18, 5, 0, 'Move to Another Q-Link Department', 1, 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (19, 9, 58127, 'Tonight! In CIN & CINOvations', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (20, 9, 60051, 'Commodore''s Headquarters', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (21, 9, 99248, 'Conference Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (22, 9, 43246, 'Computing Support Groups', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (23, 9, 423102, 'Hardware Support Groups', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (24, 9, 506677, 'News & Reference', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (25, 9, 483970, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (26, 9, 22188, 'User Group Support Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (27, 9, 65446, 'NEW 1990-91 PD Software Directory!', 1, 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (28, 9, 0, 'Move to Another Q-Link Department', 1, 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (29, 58127, 0, 'TONIGHT! IN CIN & CINOvations', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (30, 58127, 422994, 'CINOvations', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (31, 58127, 794811, 'CIN Special Events 4/5 - 4/11', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (32, 58127, 818137, 'CIN''s Regular Events Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (33, 58127, 437948, 'New & Improved Omega-Q!', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (34, 58127, 39469, 'Members'' Guide to this Department', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (35, 39469, 0, 'MEMBERS'' GUIDE TO THIS DEPARTMENT', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (36, 39469, 14001, 'About Commodore Information Network', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (37, 39469, 406365, 'Description of Services', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (38, 39469, 40183, 'Q-Link System Functions', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (39, 406365, 0, 'DESCRIPTION OF SERVICES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (40, 406365, 2291, 'Commodore''s Headquarters', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (41, 406365, 449925, 'Conference Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (42, 406365, 16175, 'The Support Groups', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (43, 406365, 424726, 'News and Reference', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (44, 406365, 10483, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (45, 406365, 523041, 'User Group Support Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (46, 406365, 443050, 'CIN SysOp List', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (47, 16175, 0, 'THE SUPPORT GROUPS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (48, 16175, 523003, 'About the Support Groups', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (49, 16175, 523017, 'The Computing Support Groups', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (50, 16175, 443059, 'The Hardware Support Groups', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (51, 16175, 484758, 'Support Groups Maps', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (52, 16175, 523031, 'The CIN SysOps', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (53, 483970, 0, 'SOFTWARE LIBRARIES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (54, 483970, 439209, 'Search the Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (55, 483970, 523033, 'Browse the Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (56, 483970, 523036, 'Library Highlights', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (57, 483970, 443054, 'Download Help and Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (58, 483970, 461276, 'Q-Link Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (59, 483970, 21830, 'Upload a File', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (60, 483970, 59976, 'Public Domain Software Directory', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (61, 439209, 0, 'ABOUT SEARCHING LIBRARIES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (62, 439209, 509226, 'About the Search System', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (63, 439209, 508330, 'How to Search the Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (64, 439209, 488298, 'Hints and Tips on Searching', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (65, 439209, 504659, 'Sample Keywords', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (66, 40183, 0, 'Q-LINK SYSTEM FUNCTIONS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (67, 40183, 498609, 'How to Use the Post Office', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (68, 40183, 466634, 'How to Use Function Keys', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (69, 40183, 465810, 'How to Use Message Boards', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (70, 40183, 58519, 'How to Download/Upload', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (71, 40183, 453736, 'How to Format a Disk', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (72, 40183, 462887, 'How to Save Screen Text', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (73, 40183, 507479, 'How to Use Conference Rooms', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (74, 498609, 0, 'HOW TO USE THE POST OFFICE', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (75, 498609, 465808, 'Sending Online Messages (OLMs)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (76, 498609, 465804, 'Sending Electronic Mail (E-Mail)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (77, 498609, 465815, 'Reading Electronic Mail', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (78, 58519, 0, 'DOWNLOADING/UPLOADING', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (79, 58519, 484790, 'How to Upload Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (80, 58519, 484788, 'How to Download Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (81, 58519, 484780, 'How to Download a Specific File', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (82, 58519, 453736, 'How to Format a Disk', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (83, 58519, 503892, 'How to Display a Disk Directory', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (84, 58519, 4857, 'Downloading Help', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (85, 4857, 0, 'DOWNLOADING HELP', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (86, 4857, 504539, 'Disk Error Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (87, 4857, 500381, 'Downloading Too Long', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (88, 4857, 500182, 'Program Will Not Run', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (89, 4857, 501939, 'File Types', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (90, 2291, 22191, 'COMMODORE''S HEADQUARTERS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (91, 2291, 440013, 'About Commodore''s Headquarters', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (92, 2291, 425281, 'News from Commodore', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (93, 2291, 33703, 'Questions and Answers', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (94, 2291, 446821, 'Product Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (95, 2291, 32161, 'Software From Commodore', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (96, 2291, 816745, 'Service Centers', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (97, 2291, 803923, 'Commodore User Groups', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (98, 440013, 0, 'ABOUT COMMODORE''S HEADQUARTERS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (99, 440013, 2291, 'Welcome', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (100, 440013, 438114, 'About Commodore Business Machines', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (101, 440013, 445131, 'Profiles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (102, 445131, 0, 'PROFILES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (103, 445131, 398624, 'Harold Copperman', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (104, 445131, 434273, 'Robert J. Larsen', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (105, 445131, 449800, 'C. Lloyd Mahaffey', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (106, 425281, 0, 'NEWS FROM COMMODORE', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (107, 425281, 442299, 'INSIDE TRACK ON AMIGA 3000', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (108, 425281, 446963, 'COMMODORE APPOINTS DIONNE', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (109, 425281, 100327, 'VA TECH CHOOSES COMMODORE', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (110, 425281, 80619, 'LETTER TO DEVELOPERS FROM', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (111, 425281, 32237, 'COMMODOREEXPRESS EXPANDS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (112, 425281, 818476, 'EDUCATIONAL PURCHASE PROGRAM', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (113, 425281, 827252, 'AMIGA 3000 INTRODUCED', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (114, 425281, 845424, 'AMIGAVISION AUTHORING SYSTEM', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (115, 425281, 425283, 'More...', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (116, 818476, 0, 'EDUCATIONAL PURCHASE PROGRAM', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (117, 818476, 833052, 'BUNDLED SYSTEMS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (118, 818476, 790157, 'INDIVIDUAL CPU''S', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (119, 818476, 837282, 'INDIVIDUAL COMPONENTS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (120, 425283, 0, 'NEWS FROM COMMODORE', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (121, 425283, 788166, 'COMMODORE NETWORKING CAPABILITES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (122, 425283, 788720, 'ANNOUNCING COMMODORE EXPRESS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (123, 425283, 422973, 'COMMODORE "TEST PILOT" BUNDLE', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (124, 425283, 404256, 'INTRODUCING "SELECT EDITION"', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (125, 425283, 406491, 'COMMODORE''S EDUCATION PURCHASE PLAN', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (126, 425283, 425214, 'ABOUT "TECH 2000"', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (127, 425283, 425184, 'GCC RETAIL AGREEMENT', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (128, 425283, 401796, 'MULTIMEDIA MARKETING GROUP FORMED', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (129, 425283, 452666, 'More...', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (130, 452666, 0, 'NEWS FROM COMMODORE', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (131, 452666, 405102, 'PRICES ADJUSTED FOR AMIGA 200', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (132, 452666, 405720, 'NEW AMIGA PERIPHERALS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (133, 452666, 412684, 'INTRODUCING THE AMIGA 2500/30', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (134, 33703, 22191, 'QUESTIONS AND ANSWERS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (135, 33703, 1434, 'About this Section', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (136, 33703, 507831, 'Common Questions and Answers', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (137, 33703, 32003, 'Public Discussion Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (138, 33703, 34519, 'Commodore''s Private Hotlines', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (139, 507831, 0, 'COMMON QUESTIONS AND ANSWERS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (140, 507831, 845758, 'Educational Purchase Program Q&A', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (141, 507831, 507814, 'General Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (142, 507831, 440671, 'New Products', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (143, 507831, 507818, 'Disk Drives', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (144, 507831, 507806, 'Modems', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (145, 507831, 507829, 'CP/M', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (146, 507831, 507804, 'Other Computers', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (147, 507814, 0, 'GENERAL INFORMATION', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (148, 507814, 41183, 'Commodore User Groups', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (149, 507814, 46435, 'Recovering Programs From Disks', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (150, 507814, 64506, 'Using Commodore Equipment Overseas', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (151, 507814, 2226, 'Underlining In Easy-Script', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (152, 507814, 11882, 'Interfacing Third Party Products', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (153, 405720, 0, 'NEW PRODUCTS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (154, 405720, 440575, 'A1011 3.5" EXTERNAL DISK DRIVE', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (155, 405720, 440626, 'AMIGA 2000 HD PC', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (156, 405720, 440669, 'A2091 HARD DISK CONTROLLER', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (157, 405720, 440620, 'A2091-40 HARD DISK', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (158, 405720, 440612, 'A2232 MULTI-SERIAL PORT', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (159, 405720, 440585, 'AMIGA 2500/30 PC', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (160, 405720, 440576, 'A2630 ACCELERATOR BOARD', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (161, 405720, 63726, 'AMIGA 500 AND 2000 INFORMATION', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (162, 405720, 440684, 'More...', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (163, 507806, 0, 'MODEMS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (164, 507806, 492576, 'Dip Switches on the New 1670', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (165, 507806, 501192, 'Hanging Up with the New 1670', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (166, 507806, 19786, '1670 Modem Availability', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (167, 507806, 59121, 'Disabling 1670 Auto-Answer', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (168, 507806, 13306, 'Using the 1660 or 1670 with Q-Link', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (169, 507806, 34493, 'Call Waiting Problems', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (170, 507804, 0, 'OTHER COMMODORE COMPUTERS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (171, 507804, 8039, 'The Plus/4 Computer', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (172, 507804, 40184, 'Commodore 4032, 8032 And Pet Repair', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (173, 34519, 22191, 'COMMODORE''S PRIVATE HOTLINES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (174, 34519, 17520, 'For Q-Link specific question please', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (175, 34519, 26690, 'use the boards in Customer Service', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (176, 34519, 491337, 'C64 Questions', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (177, 34519, 835141, 'C128 Questions', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (178, 7, 887, 'Academic American Encyclopedia', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (179, 7, 430811, 'Spring Registration Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (180, 7, 801815, 'Interactive Education Services', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (181, 7, 823536, 'Teachers'' Information Network', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (182, 7, 1422, 'disABILITIES Services', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (183, 7, 787499, 'InQuizitive', 1, 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (184, 7, 1058, 'Q-Link Post Office', 1, 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (185, 7, 0, 'Move to Another Q-Link Department', 1, 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (186, 887, 0, 'ACADEMIC AMERICAN ENCYCLOPEDIA', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (187, 887, 475467, 'About the Encyclopedia', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (188, 887, 478447, 'How to Use the Encyclopedia', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (189, 887, 52388, 'Browse the Encyclopedia', 1, 'N', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (235, 4, 401, 'What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (236, 4, 402, 'Service and Billing', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (237, 4, 403, 'Talk to Q-Link', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (238, 4, 404, 'Account/User Name Maintenance', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (239, 4, 405, 'Online User''s Guide', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (240, 4, 406, 'Terms Of Service', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (241, 404, 407, 'Create An Additional User Name', 2, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (242, 404, 408, 'Delete a User Name', 3, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (243, 483970, 500, 'Browse C64 Software', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (244, 500, 501, 'Music: SID', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (245, 501, 502, 'Pop 80''s/Pre 80''s', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (246, 43246, 600, 'Music Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (247, 600, 601, 'SID Music Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (248, 601, 602, 'SID Archives', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (249, 602, 603, 'Pop 80''s/Pre 80''s', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (250, 603, 604, 'All Stereo SID Sections', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (251, 6, 610, 'Games and Contests', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (252, 6, 611, 'Photo Gallery', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (253, 6, 612, 'Cafe Bozart', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (254, 6, 613, 'The Funny Bone', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (255, 6, 614, 'The Q-Link Clubhouse', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (256, 6, 615, 'RockLink', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (257, 6, 616, 'The GrandStand', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (258, 8, 800, 'USA TODAY Evening Update', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (259, 8, 801, 'Express Yourself', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (260, 8, 802, 'Computers and Technology', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (261, 8, 803, 'Q-Link Clubs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (262, 8, 804, 'The Classified Connection', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (263, 31225, 0, 'GEOS ARENA', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (264, 31225, 496668, 'GEOS Beginner''s Area', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (265, 31225, 58879, 'GEOS Conversion Programs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (266, 31225, 23977, 'Customer Service Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (267, 31225, 28858, 'Programming Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (268, 31225, 496368, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (269, 31225, 33369, 'News and Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (270, 31225, 489104, 'Laser Print GEOS Documents', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (271, 31225, 492282, 'Order GEOS Products', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (272, 31225, 438079, 'GEOS Chat Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (273, 23977, 0, 'CUSTOMER SERVICE MESSAGES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (274, 23977, 33253, 'GEOS C64 Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (275, 23977, 19871, 'GEOS C128 Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (276, 23977, 432729, 'New Products and Suggestions', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (277, 23977, 63169, 'GeoWorks Ensemble Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (278, 33253, 0, 'GEOS C64 MESSAGES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (279, 33253, 418134, 'General Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (280, 33253, 501934, 'Printer Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (281, 33253, 400440, 'geoWrite/Word Processing', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (282, 33253, 510379, 'geoPaint/Graphics', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (283, 33253, 34186, 'Follow-on Applications', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (284, 19871, 0, 'GEOS 128 MESSAGES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (285, 19871, 454000, 'General Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (286, 19871, 450976, 'Printer Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (287, 19871, 426528, 'geoPaint/Graphics', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (288, 19871, 515033, 'geoWrite/Word Processing', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (289, 19871, 52654, 'Follow-on Applications', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (290, 28858, 0, 'PROGRAMMING INFORMATION', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (291, 28858, 831244, 'Programming Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (292, 28858, 492561, 'geoProgrammer Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (293, 28858, 472485, 'Reference Manual Updates', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (294, 4, 409, '*Alpha Tester Message Base*', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (297, 500, 805, 'Q-Link Sample Download', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (298, 43246, 43247, 'General/Beginners'' Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (299, 43247, 43248, 'About This Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (300, 43248, 43249, 'Welcome!', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (301, 43248, 43250, 'Members'' Guide to This Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (302, 43248, 43251, 'Meet the Staff', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (303, 43248, 43252, 'Join the Group!', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (304, 43248, 43253, 'Suggestion Box', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (305, 43247, 43254, 'News and Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (306, 43254, 43255, 'What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (307, 43254, 43256, 'Sysops'' Newswire', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (308, 43254, 43257, 'Conference Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (309, 43254, 43258, 'About the Month''s Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (310, 43254, 43259, 'Beginners'' Help Room Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (311, 43247, 43260, 'Beginners'' Resource Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (312, 43260, 43261, 'Welcome!', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (313, 43260, 43262, 'You''re the Master', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (314, 43260, 43263, 'What Can I Do With My Comp.?', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (315, 43260, 43264, 'Where to Find Help', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (316, 43260, 43265, 'The Most Asked Questions', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (317, 43260, 43266, 'Books for Beginners', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (318, 43260, 43267, 'Software Reviews', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (319, 43260, 43268, 'Computing Term. Dictionary', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (320, 43247, 43269, 'Messages and Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (321, 43269, 43270, 'Announcements and General', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (322, 43269, 43271, 'Questions and Answers', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (323, 43269, 43272, 'Introduce Yourself!', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (324, 43269, 43273, 'Tips and Tricks', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (325, 43269, 43274, 'Computing Issues Debate Forum', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (326, 43269, 43275, 'General Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (327, 43247, 43276, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (328, 43276, 43277, 'C128 Software', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (329, 43277, 43278, 'Useful Programs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (330, 43277, 43279, 'Text And Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (331, 43276, 43280, 'Conference Archives', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (332, 43276, 43281, 'Q-Link Information and Tips', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (333, 43276, 43282, 'General Help Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (334, 43276, 43283, 'Other Text Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (335, 43276, 43284, 'Useful Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (336, 43276, 43285, 'Tutorial Programs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (337, 43276, 43286, 'Miscellaneous Programs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (338, 43247, 43287, 'Beginners'' Help Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (339, 43287, 43288, 'Beginners'' Help Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (340, 43287, 43289, 'Formal Conference Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (341, 43247, 43290, 'Omega-Q Support Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (342, 43290, 43291, 'What is Omega-Q?', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (343, 43290, 43292, 'About Omega-Q 2.1', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (344, 43290, 43293, 'How to Use Omega-Q', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (345, 43290, 43294, 'NEW: Download Omega-Q 2.1', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (346, 43290, 43295, 'Common Questions and Answers', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (347, 43290, 43296, 'Questions and Comment Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (348, 43290, 43297, 'Omega-Q Support Library', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (349, 43247, 43298, 'Special Features and Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (350, 43298, 43299, 'Computing Issues Debate Forum', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (351, 43299, 43300, 'About This Area', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (352, 43299, 43301, 'This Weeks''s Topic', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (353, 43299, 43302, 'Post YOUR Views!', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (354, 43299, 43303, 'Previous Poll Results', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (355, 43298, 43304, 'Downloading Crash Course', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (356, 43304, 43305, 'What is Downloading?', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (357, 43304, 43306, 'About the Crash Course', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (358, 43304, 43307, 'Class Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (359, 43304, 43308, 'News Message Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (360, 43304, 43309, 'Your First Download', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (361, 43304, 43310, 'The Classroom', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (362, 43246, 43311, 'Applications', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (363, 43311, 43312, 'About this Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (364, 43312, 43313, 'Welcome', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (365, 43312, 43314, 'About The Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (366, 43312, 43315, 'Meet The Staff', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (367, 43312, 43316, 'Join The Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (368, 43311, 43317, 'News and Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (369, 43317, 43318, 'What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (370, 43317, 43319, 'The Appliations Newswire', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (371, 43317, 43320, 'Conference Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (372, 43311, 43321, 'Messages and Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (373, 43321, 43322, 'C64  Home and Business', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (374, 43321, 43323, 'C128 Home and Business', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (375, 43321, 43324, 'Program Request Boards', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (376, 43321, 43325, 'The Suggestion Box', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (377, 43321, 43326, 'ARTICLES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (378, 43311, 43327, 'Conference and Chat Rooms', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (379, 43327, 43328, 'Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (380, 43327, 43329, 'User Friendly Cafe', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (381, 43327, 43330, 'Formal Conferences', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (382, 43311, 43331, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (383, 43331, 43332, 'C-128 Software', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (384, 43332, 43333, 'Database Managers', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (385, 43332, 43334, 'Directory & File Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (386, 43332, 43335, 'Other Disk Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (387, 43332, 43336, 'Educational Programs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (388, 43332, 43337, 'Financial Management', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (389, 43332, 43338, 'Word Processing/File Readers', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (390, 43332, 43339, 'Other', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (391, 43331, 43340, 'Home', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (392, 43331, 43341, 'Business', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (393, 43331, 43342, 'Word Processing', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (394, 43331, 43343, 'File Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (395, 43331, 43344, 'Disk Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (396, 43331, 43345, 'Text and Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (397, 43311, 43346, 'Library Highlights', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (398, 43346, 43347, 'About The Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (399, 43346, 43348, 'Uploading Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (400, 43346, 43349, 'C64  Applications File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (401, 43346, 43350, 'C128 Applications File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (402, 43346, 43351, 'All Time Top Downloads', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (403, 43346, 43352, 'New This Week', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (404, 43346, 43353, 'Weekly Upload Guides', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (405, 43246, 43354, 'CP/M', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (406, 43354, 43355, 'Message Boards and Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (407, 43355, 43356, 'Answers to Common Questions', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (408, 43355, 43357, 'CP/M 3.0', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (409, 43355, 43358, 'CP/M 2.2', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (410, 43355, 43359, 'Suggestion Box', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (411, 43355, 43360, 'ARTICLES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (412, 43354, 43361, 'Conference and Class Rooms', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (413, 43361, 43362, 'Formal Conference Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (414, 43354, 43363, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (415, 43363, 43364, 'Starter Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (416, 43363, 43365, 'Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (417, 43363, 43366, 'Word Star and Text Editors', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (418, 43363, 43367, 'Database & Spreadsheet', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (419, 43363, 43368, 'Telecommunications', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (420, 43363, 43369, 'Languages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (421, 43363, 43370, 'Games', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (422, 43363, 43371, 'Information Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (423, 43363, 43372, 'CP/M Archives', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (424, 43354, 43373, 'CP/M File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (425, 43373, 43374, 'Search ALL Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (426, 43373, 43375, 'Search Files New This Week', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (427, 43373, 43376, 'Search Files New This Month', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (428, 43354, 43377, 'About the Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (429, 43354, 43378, 'CP/M Workshop', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (430, 43378, 43379, 'About the CP/M Workshop', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (431, 43378, 43380, 'Workshop Message Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (432, 43378, 43381, 'Workshop Library', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (433, 43354, 43382, 'About the CP/M Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (434, 43382, 43383, 'Welcome to the CP/M Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (435, 43382, 43384, 'About the CP/M Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (436, 43382, 43385, 'Meet the Staff', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (437, 43382, 43386, 'Join the Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (438, 43246, 43387, 'Graphics', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (439, 43387, 43388, 'Third Annual Pixie Awards', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (440, 43388, 43389, 'About the Pixie Awards', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (441, 43388, 43390, 'How to Cast Your Vote', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (442, 43388, 43391, 'Nominations Voting Booth', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (443, 43387, 43392, 'About the Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (444, 43392, 43393, 'Welcome to the Graphics Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (445, 43392, 43394, 'About the Graphics Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (446, 43392, 43395, 'Meet the Staff', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (447, 43392, 43396, 'Join the Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (448, 43387, 43397, 'News and Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (449, 43397, 43398, 'Graphics What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (450, 43397, 43399, 'Graphics SysOps'' Newswire', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (451, 43397, 43400, 'Conference Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (452, 43397, 43401, 'Auditorium/Special Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (453, 43387, 43402, 'Messages and Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (454, 43402, 43403, 'General Annoncements/Chat', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (455, 43402, 43404, 'C-64 Graphics Help', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (456, 43402, 43405, 'C-128 Graphics Help', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (457, 43402, 43406, 'Graphics Tips and Tricks', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (458, 43402, 43407, 'Starving Artist Cafe Happen''gs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (459, 43402, 43408, 'The Most Often Asked Questions', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (460, 43402, 43409, 'Graphics Articles & Reviews', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (461, 43387, 43410, 'Conference and Chat Rooms', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (462, 43410, 43411, '(Month) Conference & Cafe Sch.', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (463, 43410, 43412, '(Month) Auditorium / Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (464, 43410, 43413, 'Starving Artist''s Cafe', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (465, 43410, 43414, 'Formal Conferences', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (466, 43387, 43415, 'Software Libraries (C-64)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (467, 43415, 43416, 'Works of The Masters', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (468, 43415, 43417, 'Masterpiece Gallery', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (469, 43415, 43418, 'Picture Perfect', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (470, 43415, 43419, 'Cartoons & Comics', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (471, 43419, 43420, 'T.H.E. Fox Cartoon', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (472, 43415, 43421, 'Digital Darkroom', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (473, 43415, 43422, 'Animation', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (474, 43415, 43423, 'Printer Clip Art', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (475, 43415, 43424, 'Other Printer Art/Collections', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (476, 43415, 43425, 'Graphics Toolbox', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (477, 43387, 43426, 'Software Libraries (C-128)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (478, 43426, 43427, '40 Column', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (479, 43426, 43428, '80 Column', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (480, 43426, 43429, 'Ultra Hi-Res Graphics (80 Col.)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (481, 43426, 43430, 'BASIC 8 Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (482, 43387, 43431, 'Library Highlights & Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (483, 43431, 43432, 'About The Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (484, 43431, 43433, 'Uploading Guidelines', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (485, 43431, 43434, 'C64  Graphics File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (486, 43431, 43435, 'C128 Graphics File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (487, 43431, 43436, 'All Time Top Downloads', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (488, 43431, 43437, 'New This Week', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (489, 43431, 43438, 'Uploader Spotlights', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (490, 43431, 43439, 'Weekly Upload Guides', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (491, 43246, 43440, 'Game World', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (492, 43440, 43441, 'About Game World', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (493, 43441, 43442, 'Welcome', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (494, 43441, 43443, 'About The Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (495, 43441, 43444, 'Meet The Staff', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (496, 43441, 43445, 'Join The Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (497, 43440, 43446, 'News And Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (498, 43446, 43447, 'What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (499, 43446, 43448, 'Holiday Newswire!', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (500, 43446, 43449, 'Conference Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (501, 43440, 43450, 'Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (502, 43450, 43451, 'The Game Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (503, 43450, 43452, 'C-64 Games', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (504, 43450, 43453, 'C-128 Games', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (505, 43450, 43454, 'Public Domain', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (506, 43450, 43455, 'The Review Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (507, 43450, 43456, 'Game Help Guild', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (508, 43456, 43457, 'General Hints', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (509, 43456, 43458, 'Bard''s Tale Series Help/Hint', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (510, 43456, 43459, 'InfoCom Help & Hints', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (511, 43456, 43460, 'SSI AD&D Games Help/Hints', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (512, 43456, 43461, 'Ultima Series Help/Hints', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (513, 43456, 43462, 'Dragon Wars/Neuromancer Brd', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (514, 43456, 43463, 'Simulations Help/Hints Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (515, 43440, 43464, 'Conference and Chat Rooms', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (516, 43464, 43465, 'Current Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (517, 43464, 43466, 'The Game Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (518, 43464, 43467, 'Formal Conference', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (519, 43440, 43468, 'Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (520, 43468, 43469, 'General Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (521, 43468, 43470, 'For the Beginner', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (522, 43468, 43471, 'Game Reviews', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (523, 43468, 43472, 'Help and Hints', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (524, 43440, 43473, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (525, 43473, 43474, 'C-128 Software', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (526, 43474, 43475, 'Games', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (527, 43474, 43476, 'Lottery', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (528, 43474, 43477, 'Trivia', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (529, 43474, 43478, 'Adventure', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (530, 43474, 43479, 'Adventure Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (531, 43473, 43480, 'Arcade', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (532, 43473, 43481, 'Adventure', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (533, 43473, 43482, 'Word and Number', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (534, 43473, 43483, 'Card and Chance', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (535, 43473, 43484, 'Game Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (536, 43473, 43485, 'Commercial Game Aids', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (537, 43473, 43486, 'Stuff and Nonsense', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (538, 43473, 43487, 'Text and Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (539, 43440, 43488, 'Library Highlights', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (540, 43488, 43489, 'About The Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (541, 43488, 43490, 'Uploading Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (542, 43488, 43491, 'C64  Games File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (543, 43488, 43492, 'C128 Games File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (544, 43488, 43493, 'All Time Top Downloads', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (545, 43488, 43494, 'New This Week', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (546, 43488, 43495, 'Weekly Upload Guides', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (547, 43246, 43496, 'Music Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (548, 43496, 43497, 'Music Room News', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (549, 43497, 43498, 'What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (550, 43497, 43499, 'Conference Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (551, 43496, 43500, '1990 SAMMy Awards', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (552, 43500, 43501, '** SAMMy Winners for 1990 **', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (553, 43500, 43502, 'SAMMy Award Nominations', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (554, 43500, 43503, 'SAMMy Voting Booth', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (555, 43496, 43504, 'SID Music Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (556, 43504, 43505, 'About the SID Music Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (557, 43504, 43506, 'SID Messages and Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (558, 43504, 43507, 'Library Spotlight', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (559, 43504, 43508, 'SID Archives', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (560, 43504, 43509, 'SID to MIDI Library', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (561, 43504, 43510, 'About the SID/General Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (562, 43496, 43511, 'MIDI Music Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (563, 43511, 43512, 'About the MIDI Music Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (564, 43511, 43513, 'MIDI Music Room News', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (565, 43511, 43514, 'Messages and Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (566, 43511, 43515, 'MIDI Hotline', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (567, 43511, 43516, 'SID to MIDI Library', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (568, 43511, 43517, 'Library Spotlight', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (569, 43511, 43518, 'Musician Matchmaker', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (570, 43511, 43519, 'Electronic MIDI Projects', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (571, 43496, 43520, 'SUPER-Q Music Support Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (572, 43520, 43521, 'Introducing Super Q', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (573, 43520, 43522, 'What Super-Q Can Do For You', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (574, 43520, 43523, 'Download Super Q', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (575, 43520, 43524, 'About SID Player', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (576, 43520, 43525, 'Common Questions', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (577, 43520, 43526, 'Download the SID Player', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (578, 43520, 43527, 'Music Hall and Studio Schedules', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (579, 43520, 43528, 'Music Hall and Studio Grafitti', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (580, 43520, 43529, 'Ask Mr/Ms Music & Music SysOps', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (581, 43496, 43530, 'SID Music Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (582, 43530, 43531, 'POP Pre 50''s - 60''s', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (583, 43530, 43532, 'POP 70''s', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (584, 43530, 43533, 'POP 80''s and 90''s', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (585, 43530, 43534, 'Rock, Country, Rag and Jazz', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (586, 43530, 43535, 'Classical', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (587, 43530, 43536, 'Holiday, Religious, Patriotic', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (588, 43530, 43537, 'Movie, TV', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (589, 43530, 43538, 'Shows, Albums, Sounds', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (590, 43530, 43539, 'Original, Novelty, Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (591, 43496, 43540, 'MIDI, General & C128 Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (592, 43540, 43541, 'C-128 Music Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (593, 43541, 43542, 'Music and Sound', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (594, 43541, 43543, 'Music and Sound Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (595, 43541, 43544, 'MIDI Librarians & Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (596, 43541, 43545, 'MIDI Sequence Files - Dr T.', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (597, 43541, 43546, 'MIDI Sequence Files - Sonus', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (598, 43540, 43547, 'Master Composer Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (599, 43540, 43548, 'Other Commercial Program Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (600, 43540, 43549, 'Original Format', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (601, 43540, 43550, 'Music Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (602, 43540, 43551, 'MIDI Librarians and Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (603, 43540, 43552, 'MIDI Keyboard Patches', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (604, 43540, 43553, 'MIDI Patches -FM/Digital Synths', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (605, 43540, 43554, 'MIDI Players and Sequences', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (606, 43496, 43555, 'Music Library Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (607, 43555, 43556, 'C64 & SID Music Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (608, 43555, 43557, 'C64 MIDI File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (609, 43555, 43558, 'C128 Music File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (610, 43555, 43559, 'C128 MIDI File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (611, 43246, 43560, 'Programmers'' Workshop', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (612, 43560, 43561, 'About this Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (613, 43561, 43562, 'Welcome', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (614, 43561, 43563, 'About The Programmers'' Workshop', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (615, 43561, 43564, 'About COMAL Today', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (616, 43561, 43565, 'Meet The Staff', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (617, 43561, 43566, 'Join The Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (618, 43560, 43567, 'News And Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (619, 43567, 43568, 'What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (620, 43567, 43569, 'Other Languages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (621, 43567, 43570, 'Programming Request Boards', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (622, 43567, 43571, 'Applications Request Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (623, 43567, 43572, 'ARTICLES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (624, 43560, 43573, 'Monthly Programming Challenge', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (625, 43573, 43574, 'About The Challenge and Prizes', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (626, 43573, 43575, 'General Rules and Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (627, 43573, 43576, '(Month) Challenge', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (628, 43573, 43577, 'Previous Challenge Winners', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (629, 43560, 43578, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (630, 43578, 43579, 'C-128 Software', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (631, 43579, 43580, 'Starter Kit', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (632, 43579, 43581, 'Machine Language', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (633, 43579, 43582, 'Programming Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (634, 43579, 43583, 'M/L Sub-Routines Source', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (635, 43579, 43584, 'Demos and Other Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (636, 43578, 43585, 'C-64 Starter Kit', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (637, 43578, 43586, 'BASIC', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (638, 43578, 43587, 'FORTH', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (639, 43578, 43588, 'C', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (640, 43578, 43589, 'PASCAL', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (641, 43578, 43590, '65xx', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (642, 43578, 43591, 'Other Languages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (643, 43578, 43592, 'Odds And Ends', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (644, 43578, 43593, 'Conference Topics and Notes', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (645, 43560, 43594, 'Library Highlights', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (646, 43594, 43595, 'About The Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (647, 43594, 43596, 'How to Upload', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (648, 43594, 43597, 'C64  Programming File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (649, 43594, 43598, 'C128 Programming File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (650, 43594, 43599, 'All Time Top Downloads', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (651, 43594, 43600, 'New This Week', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (652, 43594, 43601, 'Uploader Spotlight A - K', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (653, 43594, 43602, 'Uploader Spotlight L - Z', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (654, 43594, 43603, 'Weekly Upload Guides', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (655, 43560, 43604, 'Workshop and HELP Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (656, 43604, 43605, 'About the Workshop', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (657, 43604, 43606, 'Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (658, 43604, 43607, 'Workshop Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (659, 43604, 43608, 'Beta Test Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (660, 43604, 43609, 'Programming HELP Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (661, 43604, 43610, 'Formal Conference Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (662, 43560, 43611, 'COMAL', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (663, 43611, 43612, 'About COMAL Today', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (664, 43611, 43613, 'Message Board and Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (665, 43613, 43614, 'Q & A Message Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (666, 43613, 43615, 'COMAL 0.14', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (667, 43613, 43616, 'COMAL 2.0', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (668, 43611, 43617, 'COMAL Conference Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (669, 43246, 43618, 'Telecommunications', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (670, 43618, 43619, 'About this Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (671, 43619, 43620, 'Welcome', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (672, 43619, 43621, 'About the Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (673, 43619, 43622, 'Meet the Staff', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (674, 43619, 43623, 'Join the Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (675, 43618, 43624, 'News and Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (676, 43624, 43625, 'What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (677, 43624, 43626, 'Group Conference Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (678, 43624, 43627, 'BBS SysOp''s Conference Sch.', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (679, 43618, 43628, 'BBS List and Member Survey', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (680, 43628, 43629, 'Member Verified BBS Lists', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (681, 43628, 43630, 'Add to Q-Link''s BBS List', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (682, 43628, 43631, 'About the Member Survey', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (683, 43628, 43632, 'General Member Survey', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (684, 43618, 43633, 'Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (685, 43633, 43634, 'General', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (686, 43633, 43635, 'C-64 Software/Hardware', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (687, 43633, 43636, 'C-128 Software/Hardware', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (688, 43633, 43637, 'BBS (Bulletin Board Systems)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (689, 43637, 43638, 'Image BBS Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (690, 43637, 43639, 'BBS Listings', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (691, 43637, 43640, 'BBS SysOps Forum', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (692, 43618, 43641, 'Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (693, 43641, 43642, 'Article Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (694, 43641, 43643, 'General Telecommunications Info', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (695, 43641, 43644, 'General BBS Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (696, 43641, 43645, 'File Transfer Info & Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (697, 43641, 43646, 'Common Question', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (698, 43618, 43647, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (699, 43647, 43648, 'C-128 Software', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (700, 43648, 43649, '80-Column Terminal', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (701, 43648, 43650, '40-Column Terminal', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (702, 43648, 43651, '40/80-Column Terminal', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (703, 43648, 43652, 'Protocol ML Source', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (704, 43648, 43653, 'Protocol Source Code', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (705, 43648, 43654, 'BBS Programs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (706, 43648, 43655, 'C-Net BBS Modification', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (707, 43648, 43656, 'Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (708, 43648, 43657, 'Miscellaneous Telecom Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (709, 43647, 43658, 'BBS Programs & Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (710, 43647, 43659, 'BBS Program Modules', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (711, 43647, 43660, 'Terminal Programs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (712, 43647, 43661, 'Protocol ML Source', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (713, 43647, 43662, 'Other Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (714, 43647, 43663, 'Telecom Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (715, 43647, 43664, 'Text and Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (716, 43618, 43665, 'Library Highlights', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (717, 43665, 43666, 'About the Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (718, 43665, 43667, 'Uploading Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (719, 43665, 43668, 'C64  Telecom File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (720, 43665, 43669, 'C128 Telecom File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (721, 43665, 43670, 'All Time Top Downloads', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (722, 43665, 43671, 'New This Week', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (723, 43665, 43672, 'Weekly Upload Guides', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (724, 43618, 43673, 'Help/Chat & Conference Rooms', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (725, 43673, 43674, 'Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (726, 43673, 43675, 'The Telecom Help/Chat Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (727, 43673, 43676, 'Formal Conferences', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (728, 423102, 423103, 'C64 Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (729, 423103, 423104, 'About the C64 Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (730, 423104, 423105, 'Welcome', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (731, 423104, 423106, 'About The C-64 Hardware Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (732, 423104, 423107, 'Meet The Staff', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (733, 423104, 423108, 'Join The Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (734, 423103, 423109, 'News and Events', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (735, 423109, 423110, 'What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (736, 423109, 423111, 'Conference Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (737, 423103, 423112, 'C64 Hardware Message Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (738, 423103, 423113, 'Conference Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (739, 423103, 423114, 'Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (740, 423114, 423115, '(list of articles)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (741, 423103, 423116, 'C64 Hardware Support Library', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (742, 423103, 423117, 'C64 Hardware File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (743, 423102, 423118, 'C128 By Twin Cities 128', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (744, 423118, 423119, 'About the Twin Cities 128 Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (745, 423119, 423120, 'About the Twin Cities 128 Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (746, 423119, 423121, 'What is Twin Cities 128', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (747, 423119, 423122, 'How to Subscribe to TC-128', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (748, 423119, 423123, 'Meet Loren Lovhaug', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (749, 423119, 423124, 'How to get C-128 Help', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (750, 423118, 423125, 'Articles, Excerpts and Updates', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (751, 423125, 423126, '(list of articles)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (752, 423118, 423127, 'Slick Tips', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (753, 423127, 423128, '(list of articles)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (754, 423118, 423129, 'Message Boards', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (755, 423129, 423130, 'General Discussions', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (756, 423129, 423131, 'News & Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (757, 423129, 423132, 'Help Key Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (758, 423129, 423133, 'Online Rumor/Opinion/Mayhem', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (759, 423118, 423134, 'Twin Cities 128 Specials Lib.', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (760, 423134, 423135, 'Lovhaug''s Specials', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (761, 423134, 423136, 'IPaint Support Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (762, 423102, 423137, 'Amiga Alliance', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (763, 423137, 423138, 'About this Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (764, 423138, 423139, 'Welcome', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (765, 423138, 423140, 'About The Amiga Alliance', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (766, 423137, 423141, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (767, 423141, 423142, 'ASCII Text', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (768, 423141, 423143, 'BASIC Programs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (769, 423141, 423144, 'CLI and WorkBench', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (770, 423141, 423145, 'Fun and Games', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (771, 423141, 423146, 'Graphics', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (772, 423141, 423147, 'Music', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (773, 423141, 423148, 'Programming', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (774, 423141, 423149, 'Telecommunications', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (775, 423141, 423150, 'Official C= Amiga Updates', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (776, 423137, 423151, 'Library Highlights', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (777, 423151, 423152, 'About The Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (778, 423151, 423153, 'Uploading Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (779, 423151, 423154, 'Amiga File Search', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (780, 423151, 423155, 'All Time Top Downloads', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (781, 423151, 423156, 'Best Of The Old Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (782, 423151, 423157, 'New This Week', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (783, 423151, 423158, 'Weekly Upload Guides', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (784, 423151, 423159, 'About The Guides', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (785, 423137, 423160, 'Workshop', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (786, 423160, 423161, 'Amiga <==> 64/128 Fast!', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (787, 423160, 423162, 'Programming The Amiga', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (788, 423102, 423163, 'PC/MS-DOS', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (789, 423163, 423164, 'What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (790, 423164, 423165, 'What''s New', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (791, 423164, 423166, 'Conference Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (792, 423163, 423167, 'MS-DOS News Corner', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (793, 423167, 423168, '(list of articles)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (794, 423163, 423169, 'Message Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (795, 423163, 423170, 'Information Center Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (796, 423170, 423171, '(list of articles)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (797, 423163, 423172, 'Conference Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (798, 423163, 423173, 'Software Libraries', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (799, 423173, 423174, 'Recommended Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (800, 423173, 423175, 'General MS-DOS Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (801, 423173, 423176, 'General Applications', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (802, 423173, 423177, 'Business Applications', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (803, 423173, 423178, 'Programming Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (804, 423173, 423179, 'Games And Entertainment', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (805, 423173, 423180, 'Telecommunications', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (806, 423173, 423181, 'Information/Text Files', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (807, 423173, 423182, 'Graphics And Sound', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (808, 423163, 423183, 'About the Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (809, 423183, 423184, 'About the Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (810, 423183, 423185, 'Meet the SysOp', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (811, 423183, 423186, 'Join the Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (812, 423183, 423187, 'Meet SYSOP JAY', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (813, 423183, 423188, 'Join the Group', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (814, 423163, 423189, 'Messages and Articles', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (815, 423189, 423190, 'General', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (816, 423189, 423191, 'Software', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (817, 423189, 423192, 'Hardware', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (818, 423189, 423193, 'ARTICLES', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (819, 423163, 423194, 'Conference Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (820, 423102, 423195, 'Hardware Company Support Area', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (821, 423195, 423196, 'About this Area', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (822, 423195, 423197, 'Xetec', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (823, 423197, 423198, 'Meet Xetec', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (824, 423197, 423199, 'Xetec Message Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (825, 423197, 423200, 'Product Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (826, 423197, 423201, 'Xetec Utility Library', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (827, 423195, 423202, 'Creative Micro Designs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (828, 423202, 423203, 'Meet CMD', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (829, 423202, 423204, 'CMD Product Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (830, 423202, 423205, 'CMD Support and Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (831, 423202, 423206, 'CMD Support Library', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (832, 423202, 423207, 'Dr Evil Product Support', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (833, 423207, 423208, 'Meet Dr. Evil', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (834, 423207, 423209, 'Dr. Evil Products', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (835, 423207, 423210, 'Ordering Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (836, 423207, 423211, 'Support and Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (837, 423207, 423212, 'Support Library', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (838, 423195, 423213, 'Aprotek', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (839, 423213, 423214, 'Meet Aprotek', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (840, 423213, 423215, 'Aprotek Message Board', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (841, 423213, 423216, 'Product Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (842, 423213, 423217, 'Aprotek Utilities', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (843, 423195, 423218, 'Schnedler Systems', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (844, 423218, 423219, 'Meet Schnedler Systems', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (845, 423218, 423220, 'Product Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (846, 423218, 423221, 'Ordering Information', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (847, 423218, 423222, 'Support and Messages', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (848, 423218, 423223, 'Utility Library', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (849, 423195, 423224, 'Dr. Evil Labs', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (850, 423224, 423225, '(see Creative Micro Designs)', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (851, 423102, 423226, 'Hardware Conference Center', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (852, 423226, 423227, 'Enter the Conference Room', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (853, 423226, 423228, 'Conference Schedule', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (854, 404, 1000000, 'Switch User Name', 1, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (855, 404, 1000001, 'Terminate Disk and Migrate User Names', 4, 'Y', '1990-04-13 00:00:00', '1990-04-13 00:00:00');
INSERT INTO `toc` VALUES (905, 47134, 801816, 'Image 1.2A BBS', 0, 'Y', '2005-10-03 02:44:11', '2005-10-03 02:44:11');

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL auto_increment,
  `access_code` tinytext NOT NULL,
  `active` enum('N','Y') NOT NULL default 'N',
  `create_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_access` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_update` datetime NOT NULL default '0000-00-00 00:00:00',
  `orig_account` tinytext NOT NULL,
  `orig_code` tinytext NOT NULL,
  `name` varchar(40) default NULL,
  `city` varchar(40) default NULL,
  `state` varchar(40) default NULL,
  `country` varchar(40) default NULL,
  `email` varchar(40) default NULL,
  PRIMARY KEY  (`user_id`)
) TYPE=MyISAM PACK_KEYS=0 AUTO_INCREMENT=802 ;

