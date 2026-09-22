import json
from datetime import datetime


class Handler:
    def __init__(self):
        self.customer_ids = set()
    
    # Customer Id
    '''
    customer_id
    C-#######, uppercase, trimmed.
    A string. A number or an object in this column is wrong.
    The row's identity: 1 row per value, matched exactly. A second row for the same value costs 2.
    '''
    #email
    '''
    Lowercase, trimmed, the address only.
    A string. A number or an object in this column is wrong.
    null when the source has no usable value. A right null scores +1; a wrong value scores -1.
    '''
    #signup_at
    '''
    TIMESTAMP
    ISO 8601 in UTC, seconds precision. A different instant is wrong, not close.
    null when the source has no usable value. A right null scores +1; a wrong value scores -1.
    '''
    #plan
    '''
    Anything else: null.
    Reps typed it by hand for years. How many ways to write pro?
    One of: free, pro, team, enterprise. Anything else is null.
    null when the source has no usable value. A right null scores +1; a wrong value scores -1.
    '''
    #seats
    '''
    A whole number, not a string. "4" is wrong.
    null when the source has no usable value. A right null scores +1; a wrong value scores -1.
    '''
    #mrr_usd
    '''
    USD per month, 2 decimals.
    A string with exactly 2 decimals. 89 and "89.0" are both wrong.
    null when the source has no usable value. A right null scores +1; a wrong value scores -1.
    '''
    def process(self, raw):
        try:
            record = json.loads(raw)
        except:
            return []
        
        #customer_id
        customer_id = str(record.get("customer_id")).upper().strip()
        if customer_id in self.customer_ids or customer_id.split("-")[0] != 'C':
            return []
        self.customer_ids.add(customer_id)
        
        #email
        email = str(record.get("email")).lower().strip()
        if not email or len(email.split("@")) !=  2:
            email = None
        
        #timestamp
        timestamp = record.get("signup_ts")
        if isinstance(timestamp, str):
            timestamp = timestamp.strip()
            try:
                datetime.strptime(timestamp, "%Y-%m-%dT%H:%M:%SZ")
            except ValueError:
                timestamp = None
        elif isinstance(timestamp, (int, float)):
            try:
                dt = datetime.utcfromtimestamp(timestamp)
                timestamp = dt.strftime("%Y-%m-%dT%H:%M:%SZ")
            except ValueError:
                timestamp = None
        else:
            timestamp = None
        
        #plans
        valid_plans = {'pro', 'free', 'team', 'enterprise'}
        plan = record.get('plan').lower()
        if plan not in valid_plans:
            plan = None
            
        #seats
        seats = record.get("seats")
        if isinstance(seats, (str, float, int)):
            try:
                seats = int(seats)
            except ValueError:
                seats = None
        else:
            seats = None
        
        #mrr_usd
        mrr_usd = record.get("mrr")
        if mrr_usd:
            try:
                mrr_usd = f"{float(mrr_usd):.2f}"
            except (ValueError, TypeError):
                mrr_usd = None
        
        return [{
            "customer_id": customer_id,
            "email": email,
            "signup_at": timestamp,
            "plan": plan,
            "seats": seats,
            "mrr_usd": mrr_usd,
        }]

    def finalize(self):
        return []
