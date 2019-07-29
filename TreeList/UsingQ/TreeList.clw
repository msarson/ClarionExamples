                    PROGRAM

 

                    MAP

RandomAlphaData         PROCEDURE(*STRING Field)

                    END

TreeDemo            QUEUE,PRE() !Data list box FROM queue
FName                   STRING(20)
ColorNFG                LONG       !Normal Foreground color for FName
ColorNBG                LONG       !Normal Background color for FName
ColorSFG                LONG       !Selected Foreground color for FName
ColorSBG                LONG       !Selected Background color for FName
IconField               LONG       !Icon number for FName
TreeLevel               LONG       !Tree Level
LName                   STRING(20)
Init                    STRING(4)

                    END

 

Win                 WINDOW('List Box'),AT(0,0,374,283),GRAY,SYSTEM,FONT('Segoe UI',8,, |
                        FONT:regular,CHARSET:ANSI),DOUBLE
                        LIST,AT(3,4,369,254),USE(?Show),HVSCROLL,COLOR(,COLOR:Black,0E7E7E7H), |
                            FROM(TreeDemo),GRID(0e7e7e7H),FORMAT('121L(2)|M*IT~First Name~14' & |
                            '9L(2)|M~Last Name~16C(2)|M~Initials~')
                        BUTTON('Contract All'),AT(2,262,50,19),USE(?btnContract)
                        BUTTON('Expand All'),AT(56,262,50,19),USE(?btnExpand)
                    END

x                   long

    CODE

    LOOP x = 1 to 20
        RandomAlphaData(FName)
        ColorNFG = COLOR:Black                     !Assign FNAME's colors
        ColorNBG = 0F0FFFFH
        ColorSFG = COLOR:White
        ColorSBG = COLOR:Silver
        IconField = ((x-1) % 4) + 1               !Assign icon number
        TreeLevel = ((x-1) % 4) + 1               !Assign tree level
        RandomAlphaData(LName)
        RandomAlphaData(Init)
        ADD(TreeDemo)
    END

    OPEN(Win)

    ?Show{prop:lineheight} = 10
    ?Show{PROP:iconlist,1} = ICON:VCRback       !Icon 1 = <
    ?Show{PROP:iconlist,2} = ICON:VCRrewind     !Icon 2 = <<
    ?Show{PROP:iconlist,3} = '~VCRdown.ico'      !Icon 3 = > MS Added to projec so it is linked in
    ?Show{PROP:iconlist,4} = '~VCRnext.ico'     !Icon 4 = >>linked into project

    ACCEPT
        CASE ACCEPTED()
        of ?btnContract
            LOOP i# = 1 to RECORDS(TreeDemo)
                GET(TreeDemo,i#)
                if TreeDemo.TreeLevel > 0
                    TreeDemo.TreeLevel = -TreeDemo.TreeLevel   !Set to negative value
                    PUT(TreeDemo)
                END
            END
            DISPLAY()
        of ?btnExpand
            LOOP i# = 1 to RECORDS(TreeDemo)
                GET(TreeDemo,i#)
                if TreeDemo.TreeLevel < 0
                    TreeDemo.TreeLevel = TreeDemo.TreeLevel * -1 !Set to positive value
                    PUT(TreeDemo)
                END
            END
           ! DISPLAY()            
        END

    END

 

RandomAlphaData     PROCEDURE(*STRING Field)

 

    CODE

    y# = RANDOM(1,SIZE(Field))                  !Random fill size
    LOOP x# = 1 to y#                           !Fill each character with
        Field[x#] = CHR(RANDOM(97,122))            !a random lower case letter
    END
