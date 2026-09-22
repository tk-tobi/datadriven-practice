def batch_with_metadata(records, n):
    super_list = []
    batch_index = 0
    max_batch_index = len(records) % n
    
    for i in range(0, len(records), n):
        # If the next slice reaches or exceeds the list length, it's the last batch
        is_last = (i + n) >= len(records)
        sub_dict = { 'batch_index': batch_index, 'records': records[i : i + n],'is_last': is_last}
        super_list.append(sub_dict)
        batch_index += 1
        
    return super_list
