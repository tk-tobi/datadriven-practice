# def flatten_the_nest(items: list):
#   final_list = []
#   for x in items:
#     if isinstance(x, list):
#       final_list.extend(x)
#     else:
#       final_list.append(x)
#   return final_list

from itertools import chain
from typing import Iterator

def flatten_the_next(items: list) -> list | Iterator:
  iterator = (x if isinstance(x, list) else [x] for x in items)
  return list(chain.from_iterable(iterator))
