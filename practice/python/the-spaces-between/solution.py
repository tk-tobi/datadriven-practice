def kth_missing(ids, k):
  start = ids[0]
  for x in ids[1:]:
    gap = x - start - 1
    if k <= gap:
      return start + k
    k -= gap
    start = x
  return start + k
