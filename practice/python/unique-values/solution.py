def remove_dupes(items):
  result = []
  for i in items:
    if i not in result:
      result.append(i)
  return result
