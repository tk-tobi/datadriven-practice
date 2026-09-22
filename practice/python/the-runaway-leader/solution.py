def dominant_element(readings: list[int]):
    
    # Boye Moore voting Algorithm
    candidate = None
    count = 0
    
    for elem in readings:
      if count == 0:
        candidate = elem
      
      count += 1 if candidate == elem else -1
    
    return candidate
  
    '''
    threshold = len(readings)/2
    reading_count = {}
    for elem in readings:
      reading_count[elem] = reading_count.setdefault(elem, 0) + 1
    
    for key,val in reading_count.items():
      if val >= threshold:
        return key
    '''
