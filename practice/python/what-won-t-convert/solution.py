def cast_to_int(values: list) -> list:
  output = []
  for value in values:
    try:
      entry = int(value)
    except (ValueError, TypeError):
      entry = None
    finally:
      output.append(entry)
  return output
