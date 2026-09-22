def missing_keys(record: dict, required: list) -> list:
  
  return sorted(set(required) - set(record.keys()))
  # return sorted([req_key for req_key in required if req_key not in record])
