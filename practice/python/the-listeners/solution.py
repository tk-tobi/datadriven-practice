from collections import defaultdict
class EventEmitter:
  
  def __init__(self):
    self.subscriptions = defaultdict(list)
  
  def on(self, event, listener):
    self.subscriptions[event] = self.subscriptions.setdefault(event, [])
    self.subscriptions[event].append(listener)
    return None
  
  def off(self, event, listener):
    if event in self.subscriptions:
      if listener in self.subscriptions[event]:
        self.subscriptions[event].remove(listener)
    return None
  
  def emit(self, event, payload):
    if event not in self.subscriptions:
      self.subscriptions[event] = []
      return []
    else:
      listener_count = len(self.subscriptions[event])
      return listener_count * [payload]
    
def event_broadcaster(op_names: list[str], op_args: list[list]) -> list:
  results = []
  if op_names[0] == "EventEmitter" and op_args[0] == []:
    op_names.remove("EventEmitter")
    op_args.remove([])
    emitter = EventEmitter()
    results.append(None)
  
  for event_op_attributes in zip(op_names, op_args):
    op_name = event_op_attributes[0]
    op_arg = event_op_attributes[1]
    if op_name == 'on':
      result = emitter.on(*op_arg)
    elif op_name == 'off':
      result = emitter.off(*op_arg)
    elif op_name == 'emit':
      result = emitter.emit(*op_arg)
    results.append(result)
    
  return results
  
  
    
