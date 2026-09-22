def longest_unique_substr(s):
  
  window_start, max_len = 0, 0
  seen_vals = {}
  
  for curr_index, val in enumerate(s):
    
    if val in seen_vals and seen_vals[val] >= window_start:
      window_start = curr_index
      
    seen_vals[val] = curr_index
    max_len = max(max_len, curr_index - window_start + 1)


  return max_len
