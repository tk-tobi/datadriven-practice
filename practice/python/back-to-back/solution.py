def merge_overlapping_time_ranges(intervals: list[list[int]]):
  
  
  '''
  create an empty list 'merged_sessions'
  
  sort 'intervals' by start
  
  for each 'current_interval' in 'intervals':
    if 'merged_sessions' is empty:
      append 'current_interval' to 'merged_sessions'
    
    else:
      if end of last interval in merged_sessions >= start of interval:
        end = max (end of last interval, end of interval)
        end of last interval in merged_sessions = end
      else:
        merged_sessions.append(interval)
        
   return merged_sessions
  '''
  
  merged_sessions = []
  intervals.sort()
  
  for current_interval in intervals:
    if not merged_sessions:
      merged_sessions.append(current_interval)
    else:
      last_interval_end = merged_sessions[-1][1]
      last_interval_start = merged_sessions[-1][0]
      
      if last_interval_end >= current_interval[0]:
        merged_sessions[-1][1] = max(last_interval_end, current_interval[1])
      else:
        merged_sessions.append(current_interval)
   
  return merged_sessions        
  
  
