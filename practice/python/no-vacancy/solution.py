def min_rooms(meetings: list[tuple[int, int]]) -> int:
    
    '''
    create a list 'event_triggers'
    
    'event_triggers' is a break down of each meeting paired with a +1/-1 trigger
      [[start, +1], [end, -1] for every event in meetings]
    
    sort event_triggers by their timestamps and trigger ASCENDING
    
    create a 'max_count' and a 'rolling_count' variable set to 0
    
    
    for 'event' in 'event_triggers':
      rolling_count is a rolling sum of event[1]
      max_count = max(rolling_count, max_count)
      
    
    return max_count
    
    '''
    
    event_triggers = [[x[0], +1] for x in meetings] + [[x[1], -1] for x in meetings]
    
    event_triggers.sort(key=lambda x: (x[0], x[1]))
    rolling_sum = 0
    max_sum = 0
    
    
    for event in event_triggers:
      rolling_sum += event[1]
      max_sum = max(max_sum, rolling_sum)
      
      
    return max_sum
      
    
    
    
