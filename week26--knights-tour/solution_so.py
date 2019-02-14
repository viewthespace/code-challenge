class Solution(object):
  def knightsTour(self, N, s):
    
    moves = ((2,1),(2,-1),(-2,1),(-2,-1),(1,2),(-1,2),(1,-2),(-1,-2))
    inBounds = lambda p: p[0] >= 0 and p[1] >= 0 and p[0] < N and p[1] < N
    visited = set()
    stack = [(s,[s])]

    while stack:
      p, path = stack.pop()
      if str(path) in visited: 
        continue
      if len(path) == N*N:
        return path  
      visited.add(str(path))
      nextMoves = map(lambda m: (m[0] + p[0], m[1] + p[1]), moves)
      for pos in nextMoves: 
        if pos not in path and inBounds(pos):
          stack.append((pos, path + [pos]))
    
print(Solution().knightsTour(5, (2,2)))