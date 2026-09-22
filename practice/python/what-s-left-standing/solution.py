def resolve_collisions(particles):
  survivors = [] #stack
  
  for particle in particles:
    active = True
    while active and survivors and survivors[-1] > 0 and particle < 0:
      if survivors[-1] < abs(particle):
        survivors.pop()
      elif survivors[-1] > abs(particle):
        active = False
      elif survivors[-1] == abs(particle):
        survivors.pop()
        active = False
    
    if active:
      survivors.append(particle)
  return survivors
