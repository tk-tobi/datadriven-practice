from collections import defaultdict

def build_tree(pairs: list[tuple[str, str]]) -> dict:
  
  '''
  manager_dict = default_dict(list)
  org_chart = empty dict {}
  manager_set, report_set = empty sets set()
  
  for 'pair' in pairs:
    'manager' and 'report' = pair[0] and pair[1]
    manager_set = add manager to manager_set
    report_set = add report to report_set
    append report to manager_dict[manager]
  
  managers = set(manager_set)
  reports = set(report_set)
  ceo = string(managers - reports)
  
  def build_branch(person):
    if 'person' is not in manager_dict:
      return {}
    else:
      local_branch = {}
      for report in managers(person):
        local_branch[report] = build_branch(report)
      return local_branch
    
  org_chart = build_branch(ceo)
  
  return org_chart
  '''
  if not pairs:
    return 0
  
  manager_dict = defaultdict(list)
  manager_set = set()
  report_set = set()
  org_chart = {}
  
  for pair in pairs:
    manager = pair[0]
    report = pair[1]
    manager_set.add(manager)
    report_set.add(report) 
    manager_dict[manager].append(report)
    
  ceo = manager_set - report_set
  ceo = next(iter(ceo))
  
  def build_branch(person):
    if person not in manager_dict:
      return {}
    else:
      local_branch = {}
      for report in manager_dict[person]:
        local_branch[report] = build_branch(report)
      return local_branch
  
  org_chart[ceo] = build_branch(ceo)
  
  return org_chart


    

 
