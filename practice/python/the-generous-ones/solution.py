def biggest_tipper(user_ids: list[str], tips: list[float]) -> str:
  from collections import defaultdict
  import heapq
  user_dict = defaultdict(float)
  
  
  for tip, id in zip(tips, user_ids):
    user_dict[id] += tip
  
  max_tip = max(user_dict.values())
  return min(user for user, tip in user_dict.items() if tip == max_tip)
  # return ''.join(heapq.nlargest(1, user_dict, key=lambda x:user_dict[x]))
