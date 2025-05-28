def minmax(a, l, r):
    if l == r:
        return a[l], a[l]
    if r == l + 1:
        return (a[l], a[r]) if a[l] < a[r] else (a[r], a[l])
    m = (l + r) // 2
    mn1, mx1 = minmax(a, l, m)
    mn2, mx2 = minmax(a, m + 1, r)
    return (mn1 if mn1 < mn2 else mn2), (mx1 if mx1 > mx2 else mx2)

# example
a = [12, 3, 5, 7, 19, 1, 10]
mn, mx = minmax(a, 0, len(a) - 1)
print("Minimum:", mn)
print("Maximum:", mx)
