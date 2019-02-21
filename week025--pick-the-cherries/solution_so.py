def pick_cherries(grid):
  return pick(grid, len(grid), len(grid[0]), 0, 0, {})

def pick(grid, m, n, x, y, visited):
  if (x >= n or y >= m or x < 0 or y < 0 or (x,y) in visited or grid[y][x] == -1):
    return
  if (x == 0 and y == 0 and (n-1, m-1) in visited):
    return
  picked = grid[y][x]
  grid[y][x] = 0
  visited =  { (x,y): None } if (x == n-1 and y == m-1) else { (x,y): None, **visited }
  l = pick(grid, m, n, x+1, y, visited)
  r = pick(grid, m, n, x-1, y, visited)
  u = pick(grid, m, n, x, y+1, visited)
  d = pick(grid, m, n, x, y-1, visited) 
  return picked + max([x for x in [l,r,u,d] if x != None]) if (l or r or u or d) else picked
