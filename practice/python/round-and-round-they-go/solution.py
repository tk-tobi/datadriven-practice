def distribute(values: list[int], containers: list[str]) -> list[dict]:
    
    tracker_dict = {}
    next_container = 0
    next_index = 0
    last_container_index = len(containers)
    result = []

    for val in values:
        
      
        if next_container == last_container_index:
          next_container = 0
      
        if val in tracker_dict:
          index = tracker_dict[val]
          if result[index]["container"] == 'set':
              continue
          else:
              result[index]["values"].append(val)
        else:
          tracker_dict[val] = next_index
          result_dict = {"values": [val], "container": containers[next_container]}
          result.append(result_dict)
          next_container += 1
          next_index += 1
  
    return result
