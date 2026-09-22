from collections import deque

def oranges_rotting(grid):
  # Breadth-First Search (BFS)
  # 2 = rotten
  # 1 = fresh orange
  # 0 = empty
    # find the starting points: grid[x][y] == 2
      # add orange to a queue
    # Count fresh oranges: grid[x][y] == 1
  
  '''
  [
    [2, 1, 1],
    [1, 1, 0],
    [0, 1, 1]
  ]
  
  queue = [(0,0)]
  fresh_counter = 6
  
  queue = [(1, 0), (0, 1)]
  '''
  
  minutes = 0
  queue = deque()
  fresh_counter = 0
  ROWS, COLS = len(grid), len(grid[0])
  
  for x in range(ROWS):
    for y in range(COLS):
      if grid[x][y] == 2:
        queue.append((x, y))
      elif grid[x][y] == 1:
        fresh_counter += 1
        
  
  while queue and fresh_counter > 0:

    for _ in range(len(queue)):
      x, y = queue.popleft()
      
      # top orange
      if x != 0 and grid[x-1][y] == 1:
        grid[x-1][y] = 2
        fresh_counter -= 1
        queue.append((x - 1, y))
        
      # bottom orange
      if x != len(grid) - 1 and grid[x+1][y] == 1:
        grid[x+1][y] = 2
        fresh_counter -= 1
        queue.append((x + 1, y))
      
      # right orange
      if y != len(grid[0]) - 1 and grid[x][y+1] == 1:
        grid[x][y+1] = 2
        fresh_counter -= 1
        queue.append((x, y + 1))
      
      # left orange
      if y != 0 and grid[x][y-1] == 1:
        grid[x][y-1] = 2
        fresh_counter -= 1
        queue.append((x, y - 1))
    # print(queue, fresh_counter, minutes)
    minutes += 1
  
  # print(queue, fresh_counter, minutes)
  if fresh_counter == 0:
    return minutes
   
  return -1
