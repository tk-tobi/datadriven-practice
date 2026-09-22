def parse_log(line):
  parts = line.split(' ', 2)
  return {
      "level": parts[0],
      "message": parts[2],
      "timestamp": parts[1],
    }
