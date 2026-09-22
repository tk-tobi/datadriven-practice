def run_length_encoding(s: str) -> str:
    if not s:
        return ""

    result = []
    curr_letter = s[0]
    curr_count = 1

    # Iterate starting from the second character
    for char in s[1:]:
        if char == curr_letter:
            curr_count += 1
        else:
            result.append(f"{curr_letter}{curr_count}")
            curr_letter = char
            curr_count = 1
            
    # Append the final sequence
    result.append(f"{curr_letter}{curr_count}")
    
    # Join the list into a single string efficiently
    return "".join(result)
