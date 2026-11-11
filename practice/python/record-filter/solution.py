def filter_records(records, criteria):
  result = []
  if len(criteria) == 0:
    return records
  
  
  for record in records:
    check_flag = True
    for key,value in criteria.items():
      if record.get(key) != value:
        check_flag = False
        break
    if check_flag:
      result.append(record)
  
  return result
