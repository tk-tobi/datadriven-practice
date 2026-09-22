def forward_fill(values: list) -> list:
  most_recent = None
  for i, value in enumerate(values):
    if value is None:
      values[i] = most_recent
    else:
      most_recent = value
  return values
      
