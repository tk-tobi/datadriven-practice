def align_columns(left, right):
  output = []
  left_i = None
  right_i = None
  longest = max(len(left), len(right))
  
  for i in range(longest):
    if i < len(left):
      left_i = left[i]
    if i < len(right):
      right_i = right[i]
    output.append([left_i, right_i])
    
  return output
