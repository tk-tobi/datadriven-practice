def hourly_event_counts(logs: list[tuple[str, str]]) -> dict[str, dict[str, int]]:
  
  event_dict = {}
  event_log = {}
  
  for log in logs:
    event_key = log[0][:13]
    event = log[1]
    
    if event_key not in event_dict:
      # reset log
      event_dict[event_key] = {}
      
    event_dict[event_key][event] = event_dict[event_key].get(event, 0) + 1
  
  return event_dict  
  
 
 
    
