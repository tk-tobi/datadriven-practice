def the_never_ending_sequence(n: int):
  if n == 1:
    return [0]
  elif n == 0:
    return []
  fibb = [0, 1]
  for i in range(2, n):
    fibb.append(fibb[i - 1] + fibb[i - 2])
 

  return fibb
