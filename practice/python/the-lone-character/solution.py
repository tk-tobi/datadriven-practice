def the_lone_character(s: str):
  from collections import Counter
  
  seen = Counter(s)
  
  for char in s:
    if seen[char] == 1:
      return char
  
  return ""
