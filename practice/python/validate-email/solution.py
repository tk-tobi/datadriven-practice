def is_valid_email(email: str) -> bool:
  if email.count("@") != 1:
    return False
  
  local, domain = email.split("@")
  
  if "." not in domain:
    return False
  
  if domain.startswith('.') or domain.endswith('.'):
    return False

  return True
