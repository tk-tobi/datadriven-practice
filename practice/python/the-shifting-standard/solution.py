def the_shifting_standard(batches: list[list[float]]):
  
  '''
    [[10, 20], [30], [40, 50, 60]]
    [15, 20, 35]
  '''
  count = 0
  result = []
  num_sum = 0
  
  # for batch in batches:
  #   for num in batch:
  #     num_sum += num
  #     count += 1
  #   result.append(num_sum/count)
  
  # return result
  
  for batch in batches:
    num_sum += sum(batch)
    count += len(batch)
    
    running_avg = num_sum / count if count > 0 else 0.0
    result.append(running_avg)
    
  return result
      
    
