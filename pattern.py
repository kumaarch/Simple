def search(pat, txt):
    n = len(txt)
    m = len(pat)
    # Loop through the text
    for i in range(n - m + 1):
    # Check if the substring matches the pattern
        if txt[i:i + m] == pat:
            print(f"Pattern found at index {i}")
    # Example usage
txt = "AABAACAADAABAABA"
pat = "AABA"
search(pat, txt)
