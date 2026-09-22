def most_frequent(items: list) -> list:
  from collections import Counter
  counter = Counter(items)
  max_count = max(counter.values())
  
  return sorted([item for item in counter if counter[item] == max_count])
