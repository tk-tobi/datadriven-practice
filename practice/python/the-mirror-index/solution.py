def invert_dict(d: dict) -> dict:
  
  output_d = {}
  
  for key, value in d.items():
    
    if str(value) in output_d:
      output_d[str(value)].append(key)
    else:
      output_d[str(value)] = [key]
  for value in output_d.values():
    value.sort()
    
    
  return output_d
