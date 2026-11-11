def filter_records(records, criteria):
  result = []
  if len(records) == 0:
    return []
  if len(criteria) == 0:
    return records
  
  criteria_key = list(criteria.keys())
  criteria_value = list(criteria.values())
  
  for record in records:
    check_flag = True
    for key,value in zip(criteria_key, criteria_value):
      record_check = record.get(key)
      if record_check is None or record_check != value:
        check_flag = False
        break
    if check_flag is True:
      result.append(record)
  
  return result
