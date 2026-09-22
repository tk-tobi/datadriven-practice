# import pandas a pd
def the_deep_config(config: dict):
  
  # flat_config = pd.json_normalize(config, separator=".", errors='ignore')
  # return flat_config
  
  
  def flatten_config(config_dict, parent_field=''):
    flat_config = {}
    for name, value in config_dict.items():
      field_name = f"{parent_field}.{name}" if parent_field else name
      
      if isinstance(value, dict):
        flat_config.update(flatten_config(value, parent_field=field_name))
      elif not value:
        flat_config[field_name] = None
      else:
        flat_config[field_name] = value
    return flat_config
  return flatten_config(config)
      
