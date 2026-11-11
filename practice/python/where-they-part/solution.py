def longest_prefix(patterns):
  prefix = ''
  for chars in zip(*patterns):
    stripped_char = set(char for char in chars if char != '?')
    if len(stripped_char) == 0:
      prefix += '?'
    elif len(stripped_char) == 1:
      prefix += stripped_char.pop()
    else:
      break
    
  return prefix
