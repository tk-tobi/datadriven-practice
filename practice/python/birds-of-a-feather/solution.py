def partition_by(records, key):
  
  dict_map = {}
  
  for record in records:
    dict_map.setdefault(record[key], []).append(record)
      
  return dict_map
