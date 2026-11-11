def running_total(deposits):
  balance = []
  i = 0
  for deposit in deposits:
    i += deposit
    balance.append(i)

  return balance
