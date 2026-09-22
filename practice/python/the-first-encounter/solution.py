def string_to_number_mapping(s: str) -> dict:
  result = {}
  
  for i, char in enumerate(s):
    if char not in result:
      result[char] = i




  return result
