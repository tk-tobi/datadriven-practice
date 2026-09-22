def the_indivisibles(n: int):
  
  def is_prime(num):
    import math
    if num <= 1:
      return False
    
    if num == 2:
      return True
    
    if num % 2 == 0:
      return False
    
    for i in range(3, math.isqrt(num) + 1, 2):
      if num % i == 0:
        return False
    
    return True
  
  prime_numbers = []
  
  if n <= 2:
    return prime_numbers
  
  for i in range(n):
    if is_prime(i):
      prime_numbers.append(i)
  
  return prime_numbers
