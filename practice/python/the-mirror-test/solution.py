def the_mirror_test(s: str):
  clean = ''.join(c.lower() for c in s if c.isalnum())
  
  right, left = 0, len(clean) - 1
  
  while right < left:
    if clean[right] != clean[left]:
      return False
    
    right += 1
    left -= 1
  
  return True
  
  
