def return_target_minutes(targets, activities):
  
  target_sum = 0
  for activity in activities:
    if activity["name"] in targets:
      target_sum += activity["minutes"]
      
  return target_sum
