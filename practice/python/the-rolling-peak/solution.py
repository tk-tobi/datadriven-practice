def max_avg_subarray(nums, k):
     
    if len(nums) < k:
      return None
    
    curr_sum = sum(nums[0:k])
    max_sum = curr_sum
    
    for i in range(k, len(nums)):
      curr_sum += nums[i] - nums[i - k]
      max_sum = max(max_sum, curr_sum)

    return max_sum/k
    
    
