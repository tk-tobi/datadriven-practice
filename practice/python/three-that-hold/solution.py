def triangle_validator(lengths: list[int]):
  '''
  group of three rods that form a triangle
  side_x < side_y + side_z
  
  order does not matter, but contigous 
  '''
  from itertools import combinations
  
  count = 0
  lengths.sort()
  
  for a, b, c in combinations(lengths, 3):
    if a + b > c:
      count += 1
  
  return count
    
