class LRUCache:
  def __init__(self, capacity: int):
    from collections import OrderedDict
    
    self.capacity = capacity
    self._cache = OrderedDict()
        
  def get(self, key: int) -> int:
    value = self._cache.get(key, -1)
    if value != -1: self._cache.move_to_end(key, last=False)
    return value
        
  def put(self, key: int, value: int) -> None:
    self._cache[key]=value
    self._cache.move_to_end(key, last=False)
    if len(self._cache) > self.capacity:
      self._cache.popitem(last=True)
        
def LRUCache_driver(capacity, ops):
  cache = LRUCache(capacity)
  result = []
  
  for op in ops:
    if op[0] == "put":
      cache.put(op[1], op[2])
    elif op[0] == "get":
      result.append(cache.get(op[1]))
  # Apply ops to an LRUCache(capacity) and return the list of get() results.
  return result
