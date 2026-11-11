def extract_diagonal(cells: list, size: int) -> list:
  result = []
  
  for i in range(size):
    result.append(cells[(i * size) + i])
  
  return result
