def the_runner_up(nums: list[int]):
  # distinct_nums = set(nums)
  
  # return sorted(distinct_nums, reverse=True)[1] if len(distinct_nums) > 1 else None
  
  largest = float("-inf")
  second = float("-inf")
  
  for num in nums:
    if num > largest:
      second = largest
      largest = num
    elif largest > num > second:
      second = num
  return second if second != float('-inf') else None
