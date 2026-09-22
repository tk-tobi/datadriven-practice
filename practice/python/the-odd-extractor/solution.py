def extract_odd_numbers(s):
  tokenized_s = s.split()
  
  odd_tokens = []
  
  for token in tokenized_s:
    if token.isdecimal() and int(token) % 2 != 0:
      odd_tokens.append(int(token))

  return odd_tokens
