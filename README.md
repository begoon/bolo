Vintage game BOLO
=================

This project is dedicated for remastering of the classic Apple's game called "BOLO".

![](https://raw.github.com/begoon/bolo/master/bolo-screenshot.png)

- - -

The original README
-------------------

**BOLO**
by Elvyn Software, 1982

Unofficial IBM PC port of original game for Apple II by MrRm, 1993.
It's for MS-DOS, but runs in Windows XP too.

You have to destroy 6 enemy bases. Find them in the maze with your radar and
hit the center.

Keys:

cursor keys - move tank
1, 2 - turn your gun
3 - fire
ESC - exit game

- - -

The game perfectly works on modern systems via DOSBox:

    dosbox -exit BOLO.COM

- - -

A patch for lazy players
------------------------

If you want to check what happens after we win, checkout the patch below.

After the patch you can play like this: http://www.youtube.com/watch?v=pcqygeYP4qs

Unlimited lives (by WiseGuy)
BOLO.COM
00000174: 4F 00
00000178: DF 4A
00000179: FE FF

Unlimited fuel (by WiseGuy)
BOLO.COM
00000A38: 06 04

Immortality & pass through the walls (by WiseGuy)
BOLO.COM
00000C61: 01 00
0000172D: 01 00
00001817: 01 00

### Applying the patch

    cd patch
    cp ../BOLO.COM .
    ruby patch-xck.rb BOLO.XCK

Answer YES to the questions and then run `BOLO_patched.EXE`.

- - -

Re-mastering
------------

The plan is to re-implemented the game "as is" as multiplayer.

So, if you can share the sources of the this implementation of BOLO,
it would be great.
