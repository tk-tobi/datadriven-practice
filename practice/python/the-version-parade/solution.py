def the_version_parade(versions: list[str]):
  return sorted(versions, key= lambda x: [int(p) for p in x.split(".")])
    
