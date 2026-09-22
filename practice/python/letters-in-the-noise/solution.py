# from collections import defaultdict

# def character_occurrence_map(s: str):
#   string_dict = defaultdict(int)
#   for string in s.lower():
#     if string.isalpha():
#       string_dict[string] += 1
   
#   return sorted([[key, value] for key, value in string_dict.items()], key=lambda x:x[0])
      

from collections import Counter
def character_occurence_map(s: str) -> list[list]:
  counts = Counter(char.lower() for char in s if char.isalpha())
  
  return sorted([[char, count] for char, count in counts.items()])
