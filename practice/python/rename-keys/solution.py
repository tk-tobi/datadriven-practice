def rename_keys(record: dict, mapping: dict) -> dict:
  
  # return_record = {}
  # for key, val in record.items():
  #   return_record[mapping.get(key, key)] = val
  # return return_record
  return {mapping.get(k, k): v for k, v in record.items()}
