def coalesce(primary: dict, defaults: dict) -> dict:
  output_dict = {}
  
  for key,val in primary.items():
    output_dict[key] = val if val is not None else defaults.get(key, None)
    """
    if val is not None and key in defaults:
      output_dict[key] = val
    elif val is None and key in defaults:
      output_dict[key] = defaults[key] 
    """

  return output_dict
