def group_by_char_set(words: list[str]) -> list[list[str]]:
  
  sorted_words_dict = {}
  
  for input_str in words:
    temp_input_str = "".join(sorted(set(input_str)))
    
    if temp_input_str in sorted_words_dict:
      sorted_words_dict[temp_input_str].append(input_str)
    else:
      sorted_words_dict[temp_input_str] = [input_str]
      
  sorted_words_lst = []
  for sorted_lst in sorted_words_dict.values():
    sorted_words_lst.append(sorted_lst)
     
  return sorted_words_lst
