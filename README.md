**HeadUnit-GUI**
============
----------
This is the development repository for the headunit app's GUI. This is only the GUI and there are no actual functions assigned to the buttons etc. However you can interact with the UI as all the buttons and sliders work.

Side note: I'm not a UX developer neither a graphics designer (I can use most graphics packages to a satisfactory level). I'm open to any suggestions. If you have an idea I'm more than happy to discuss it with you. 

Some thoughts on the implementation details
---------------------------------------

For details on implementing Android Auto please see my fork of Mike Reid's Android Auto at:  https://github.com/viktorgino/headunit/tree/aa-qt5-test I'm currently developing on the aa-qt5-test branch.

The radio functionality (DAB and FM) will probably be implemented using a Software Define Radio (SDR) using a cheap Realtek DVB-T dongle see: http://www.rtl-sdr.com/

A/C control is just an idea and would have to be implemented for each car individually. I have looked into the how these work for different cars (I have access to quiet a few cars and their different electronic modules such as A/C controllers) also managed to get some signal out of one A/C controller just by hooking it up to the ECU. Certain cars have the A/C control panel and the actual control module separated, these are the most suitable for retrofitting. Also very old cars that use literally a potentiometer and a bowden cable could be possible candidates as it wouldn't be to hard to replace the A/C controls with a servo/stepper motor and some basic electronics. Cars that have an "all-in-one" A/C control (front panel and the control  module are one unit) are probably the toughest nuts to crack, as you'd have to keep some parts of the module - which sometimes can be bulky - in order for the A/C to operate (you could replace it with your own electronics, but that's way out of the scope of this project).

----------
You can reach out to me on the XDA developers forum (http://forum.xda-developers.com/member.php?u=6642908) 

----------

Screenshots:
------------
Below you can see some screenshots of the current state of the GUI.

![A/C view](https://raw.githubusercontent.com/viktorgino/headunit-gui/master/screenshots/1.png)

![A/C temerature control view](https://raw.githubusercontent.com/viktorgino/headunit-gui/master/screenshots/2.png)

![Radio view](https://raw.githubusercontent.com/viktorgino/headunit-gui/master/screenshots/3.png)
