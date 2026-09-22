def merge_windows(windows: list) -> list:
  merged_windows = []
 
  if not windows:
    return merged_windows
  
  windows.sort(key=lambda x:x[0])
  merged_windows.append(windows[0])
  
  for window in windows[1:]:
    curr_start, curr_end = merged_windows[-1]
    next_start, next_end = window
    
    if curr_end >= next_start:
      merged_windows[-1][1] = max(curr_end, next_end)
    else:
      merged_windows.append(window)
    
  return merged_windows
