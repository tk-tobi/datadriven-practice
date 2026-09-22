def precision_and_recall(actual: list[int], predicted: list[int]):
  TP = 0
  FP = 0
  FN = 0
  for a, p in zip(actual, predicted):
    if a == p and a == 1:
      TP += 1
    elif a != p and a == 1:
      FN += 1
    elif a != p and a == 0:
      FP += 1
  
  try:
    precision = TP / (TP + FP)
  except ZeroDivisionError:
    precision = 0
  try:
    recall = TP / (TP + FN)
  except ZeroDivisionError:
    recall = 0
    
  return {"recall":recall, "precision":precision}
  
    
