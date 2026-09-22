def the_rotated_array(nums: list[int], target: int) -> int:
  left, right = 0, len(nums) - 1
    
  while left <= right:
    mid = (left + right) // 2
        
    # Target found!
    if nums[mid] == target:
      return mid
            
    # Check if the left half is the strictly sorted half
    if nums[left] <= nums[mid]:
      # Is the target within this strictly sorted left half?
      if nums[left] <= target < nums[mid]:
        right = mid - 1 # Eliminate right half
      else:
        left = mid + 1  # Eliminate left half
                
    # Otherwise, the right half MUST be the strictly sorted half
    else:
      # Is the target within this strictly sorted right half?
      if nums[mid] < target <= nums[right]:
        left = mid + 1  # Eliminate left half
      else:
        right = mid - 1 # Eliminate right half
                
  return -1
