def decode_rle(encoded: str) -> str:
  decoded = []
  i = 0
  
  while i < len(encoded):
    j = i
    while encoded[j].isdigit() and j < len(encoded):
      j += 1
    
    if i != j:
      decoded.append(int(encoded[i:j]) * encoded[j]) 
    else:
      decoded.append(encoded[i])
    i = j + 1


  return ''.join(decoded)
