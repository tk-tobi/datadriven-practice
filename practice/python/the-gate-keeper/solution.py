def is_valid_parens(s):
  # Empty string counts as valid
  if not s:
    return True
  
  s_stack = []
  brackets = {
    ')':'(',
    ']':'[',
    '}':'{'
    }
  
  for char in s:
    
    if char in brackets:
      if not s_stack or s_stack.pop() != brackets[char]:
        return False
    else:
      s_stack.append(char)
   
  return not s_stack
