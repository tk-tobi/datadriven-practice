def most_frequent(lst):
  dist_dict = {}
  for item in lst:
    dist_dict[item] = dist_dict.setdefault(item, 0) + 1
  
  mode = max(dist_dict.values())

  return next((k for k,v in dist_dict.items() if v == mode), None)
