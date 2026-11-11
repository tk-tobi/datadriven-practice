def remove_dupes(items):
  seen = set()
  result = []
  for i in items:
    if i not in seen:
      result.append(i)
      seen.add(i)
  return result
