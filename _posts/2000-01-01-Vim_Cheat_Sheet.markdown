Also check out my <Vimrc>

Movement
--------

    h   move one character left
    j   move one row down
    k   move one row up
    l   move one character right
    w   move to beginning of next word
    b   move to beginning of previous word
    e   move to end of word
    W   move to beginning of next word after a whitespace
    B   move to beginning of previous word before a whitespace
    E   move to end of word before a whitespace

All the above movements can be preceded by a count; e.g. `4j` will move
down 4 lines.

    0   move to beginning of line
    $   move to end of line
    ^   move to first non-blank char of the line
    _   same as above, but can take a count to go to a different line
    g_  move to last non-blank char of the line (can also take a count as above)

    gg  move to first line
    G   move to last line
    nG  move to n'th line of file (where n is a number)

    H   move to top of screen
    M   move to middle of screen
    L   move to bottom of screen

    Ctrl-D  move half-page down
    Ctrl-U  move half-page up
    Ctrl-B  page up
    Ctrl-F  page down
    Ctrl-o  jump to last cursor position

    n   next matching search pattern
    N   previous matching search pattern
    *   next word under cursor
    #   previous word under cursor
    g*  next matching search pattern under cursor
    g#  previous matching search pattern under cursor

    %   jump to matching bracket { } [ ] ( )

* * * * *

All Content from
[<http://vim.wikia.com/wiki/Vim_Tips_Wiki>](http://vim.wikia.com/wiki/Vim_Tips_Wiki)
CC - BY - SA

<Category:Vim>
