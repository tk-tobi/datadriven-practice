def top_n_per_category(n: int, records: list[dict]) -> dict[str, list[dict]]:
  
  from collections import defaultdict
  shortlist = defaultdict(list)
  sshortlist = {}
  
  if not records:
    return sshortlist
  
  for record in records:
    shortlist[record["category"]].append(record)
  
  
  for category, record in shortlist.items():
    sshortlist[category] = sorted(record, key=lambda x:x["value"], reverse=True)[:n]
    
  return sshortlist

'''
def top_n_per_category(n, records):
  groups = {}
  for record in records:
    groups.setdefault(record["category"], []).append(record)
  result = {}
  for category, bucket in groups.items():
    ranked = sorted(bucket, key=lambda r: r["value"], reverse=True)
    result[category] = ranked[:n]
  return result
'''
