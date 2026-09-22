from collections import defaultdict, deque


def run_rate_limiter(operations):
  
  '''
  # initialize variables and data structures (assume init is valid)
  max_requests = operations[0][1]
  window_ms = operations[0][2]
  clients = defaultdict(deque)
  recorder = []
  
  # process operations
  for operation in operations:
    if operation[0] == "init":
      recorder.append(None)
      continue
    client = operation[1]
    timestamp = operation[2]
    curr_que = clients[client]
    if curr_que is not empty:
      latest_stamp = curr_que[0]
      while timestamp >= latest_stamp + window_ms:
        old_message_time = curr_que.popleft()
        latest_stamp = curr_que[0] if curr_que is not empty else -window_ms
      
    if length(curr_que) < max_requests:
      clients[client].append(timestamp)
      recorder.append(True)
      continue
    recorder.append(False)
      
  return recorder
  '''
  
  max_requests = operations[0][1]
  window_ms = operations[0][2]
  clients = defaultdict(deque)
  recorder = []
  
  for operation in operations:
    if operation[0] == "init":
      recorder.append(None)
      continue
    
    client = operation[1]
    timestamp = operation[2]
    curr_que = clients[client]
   
    
    while curr_que and timestamp >= curr_que[0] + window_ms:
      old_message_stamp = curr_que.popleft()
      latest_stamp = curr_que[0] if len(curr_que)>0 else -int(window_ms)
    
    if len(curr_que) < max_requests:
      clients[client].append(timestamp)
      recorder.append(True)
      continue
    
    recorder.append(False)
  return recorder
