def char_freq(s):
  
  char_map = {}
  for char in s:
    char_map[char] = char_map.setdefault(char, 0) + 1
  
  return char_map
