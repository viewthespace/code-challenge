# The Knight's Tour

A knight's tour is a sequence of moves of a knight on a chessboard such that the knight visits every square only once.

# Example

Visually, here's what a Knight's tour looks like. The X's denote squares that have been visited by the Knight. Note, this is on a 5x5 chess board which is smaller than the standard 8x8 board.

![knights-tour-animation](https://user-images.githubusercontent.com/4043433/43399576-695a7a60-93d9-11e8-8fe7-62ab12d581d8.gif)

# Challenge

Write a program that computes a valid Knight's Tour given a starting square on an 8x8 chess board. Here is an example move sequence that started in the top left corner (00). The move number shows the position that the Knight was in after that move (Look for 00 -> 01 -> 02, etc):

```
00   59   38   33   30   17   08   63
37   34   31   60   09   62   29   16
58   01   36   39   32   27   18   07
35   48   41   26   61   10   15   28
42   57   02   49   40   23   06   19
47   50   45   54   25   20   11   14
56   43   52   03   22   13   24   05
51   46   55   44   53   04   21   12
```

Hint: On an 8x8 chess board, a Knight's Tour will always consist of exactly 64 moves.

# Legal Knight Moves 

For reference, here are the 8 legal moves that a Knight can make from a given square:

![knight-moves](https://user-images.githubusercontent.com/4043433/43399992-841e8ffc-93da-11e8-9316-c4f4bdb15e09.jpg)

In one motion, it can move one of two ways:
- 2 horizontal spaces and 1 vertical space
- 1 vertical space and 2 horizontal spaces

It can do each of those in all directions, i.e. 2 horizontal spaces to the right, and 1 vertical space down or 2 vertical spaces down and 1 horizontal space left, resulting in 8 moves. 

It cannot move off of the board.

# Supplemental Information

Here is the song "Night Moves" by Bob Seger: https://www.youtube.com/watch?v=BFRVegQZ_r0

It's not going to help with this problem, but it's a great song :D
