from collections import defaultdict
class StreamAverager:
  
  def __init__(self):
    self.sensors = defaultdict(lambda:[0,0])
  
  def add(self, key, value):
    self.sensors[key][0] += value
    self.sensors[key][1] += 1
     
  def get_averages(self):
    sensor_average = {}
    for key, value in self.sensors.items():
      sensor_average[key] = value[0]/value[1]
    return sensor_average
    
def run_stream_averager(operations):
  averager = StreamAverager()
  result = []
  for operation in operations:
    
    if operation[0] == "add":
      result.append(averager.add(operation[1], operation[2]))
      
    elif operation[0] == "get_averages":
      result.append(averager.get_averages())
  return result
      
  
