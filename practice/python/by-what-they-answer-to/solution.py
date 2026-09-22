def group_events(events):
  from collections import defaultdict
  event_category = defaultdict(list)
  
  
  for event in events:
    event_category[event[0]].append(event)
  
  return dict(sorted(event_category.items()))
