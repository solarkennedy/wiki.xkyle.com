---
categories:

---
Haunted Cemetery was the puzzle on the cover page of the Games Magazine
issue for October 2010. It is not a very difficult puzzle, but a fun one
to right a quick program for.\
![](HauntedCemetery.jpg "image")

Enter the cemetery at the bottom (location \#2). Stay on the path, exit
in the top left (location \#50). Whenever you reach an intersection with
a ghost, you must turn left or right. At all other intersections, go
straight. No U-turns allowed.

Code:

    #!/usr/bin/env python
    # -*- coding: latin-1 -*-
    # HauntedCemetery
    # Code under the GPL, copywright Kyle Anderson 2010
    # See http://wiki.xkyle.com/Haunted_Cemetery for context

    NORTH=0
    EAST=1
    SOUTH=2
    WEST=3

    StartingLocation = 2
    WinningLocation = 50
    StartingDirection = NORTH
    InitialPath = ""

    DeadZones=[0,1,2,3,4,5,6,7,13,14,20,21,27,28,34,35,41,42,48,49,51,52,53,54,55]
    GhostLocations=[8,10,11,16,19,23,25,29,32,36,38,40,44,46,47]

    def ParsePath(Path):
        Path=Path.replace("0","↑",100)
        Path=Path.replace("1","→",100)
        Path=Path.replace("2","↓",100)
        Path=Path.replace("3","←",100)
        return Path

    def Travel(Location, Direction, Path):
        Path += str(Direction)
        if len(Path)==50:
            #There are an infinite number of solutions, we are only intested in the short ones
            return 50
        
        #Move in the right step
        if Direction == NORTH:
            Location += 7
        elif Direction == EAST:
            Location += 1
        elif Direction == SOUTH:
            Location -= 7
        elif Direction == WEST:
            Location -= 1

        #Check Where we are:
        if Location in DeadZones:
            return 1
        elif Location == WinningLocation:
            print str(len(Path)) + " moves: " + ParsePath(Path)
            return 0
        elif Location in GhostLocations:
            #At a ghost we make a left or a right
            RightDirection = (Direction + 1) % 4
            Travel(Location,RightDirection,Path)
            LeftDirection = (Direction - 1) % 4
            Travel(Location,LeftDirection,Path)
        else:
            #All other locations we keep going straight
            Travel(Location,Direction,Path)

    #Start us off
    Travel(StartingLocation,StartingDirection,InitialPath)

Official code repository is
[<https://dev.xkyle.com/listing.php?repname=Games+Magazine>+-+Programs+to+solve+Games+Magazine+puzzles+(gamesmagazine)&path=/Haunted+Cemetery/
here]

Solutions (limited to 50 moves):

    kyle@kyle:~$ ./haunted.py | sort
    42 moves: ↑↑→→→↑↑↑←←↓↓↓↓←←↑↑↑→→→↑↑←←↓↓↓→→↓↓←↑↑↑↑←←↑↑
    42 moves: ↑↑→→→↑↑↑←←↓↓↓↓→↑↑←←↑↑↑→→↓↓←←←↓↓↓→→↑↑↑↑←←↑↑
    48 moves: ↑↑→→→↑↑↑←←↓↓↓↓←←↑↑↑→→→↑↑←←↓↓↓→→↑←←←↓↓↓→→↑↑↑↑←←↑↑
    48 moves: ↑↑→→→↑↑↑←←↓↓↓↓←←↑↑↑→→→↓←←↑↑↑→→↓↓←←←↓↓↓→→↑↑↑↑←←↑↑

[Category:Games Magazine](Category:Games Magazine "wikilink")
