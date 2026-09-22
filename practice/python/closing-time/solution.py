def brackets_balanced(expr):
  brackets = {'(':')', '[':']', '{':'}' }
  expr_stack = []
  ignore_flag = -1
    
  for char in expr:
    if ignore_flag == -1 and char in brackets.keys():
      expr_stack.append(char)
      
    if ignore_flag == -1 and char in brackets.values():
      if not expr_stack or brackets[expr_stack[-1]] != char:
        return False
      del expr_stack[-1]
        
    if char == "'":
      ignore_flag *= -1
    
  if expr_stack:
    return False
  return True
