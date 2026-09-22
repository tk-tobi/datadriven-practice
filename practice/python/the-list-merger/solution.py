def merge_sorted(a: list[int], b: list[int]) -> list[int]:
  sorted_list = []
  i, j = 0, 0
  while i < len(a) and j < len(b):
    
    if a[i] < b[j]:
      sorted_list.append(a[i])
      i += 1
    else:
      sorted_list.append(b[j])
      j += 1
  
  sorted_list.extend(a[i:])
  sorted_list.extend(b[j:])
  
  return sorted_list
    
