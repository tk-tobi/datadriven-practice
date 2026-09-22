def longest_consecutive(nums: list[int]) -> int:
    
    '''
    if 'nums' is empty:
      return 0
    
    dedup_nums = w/ set(nums)
    sorted_nums = sort 'dedup_nums' ascending
    'current_run' = 1
    'longest_run' = 1
    
    for 'i' from 1 to end of 'sorted_nums:
      current_number = sorted_nums[i]
      previous_number = sorted_nums[i - 1]
      
      if 'current_number' is exactly 1 greater than 'previous_number':
        increase 'current_run' by 1
      else:
        longest_run = maximum(current_run, longest_run)
        current_run = 1
   
    return maximum('longest_run', 'current_run')
    '''
    if not nums:
      return 0
    
    dedup_nums = set(nums)
    sorted_nums = sorted(list(dedup_nums))
    
    current_run = 1
    longest_run = 1
    
    for i in range(1, len(sorted_nums)):
      curr_num = sorted_nums[i]
      prev_num = sorted_nums[i - 1]
      
      if curr_num == prev_num + 1:
        current_run += 1
      else:
        longest_run = max(current_run, longest_run)
        current_run = 1
    
    return max(current_run, longest_run)
    
    
