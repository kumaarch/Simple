import random

def partition(a, l, r):
    p = random.randint(l, r)
    a[p], a[r] = a[r], a[p]
    pv = a[r]
    i = l
    for j in range(l, r):
        if a[j] < pv:
            a[i], a[j] = a[j], a[i]
            i += 1
    a[i], a[r] = a[r], a[i]
    return i

def qs(a, l, r, k):
    if l == r:
        return a[l]
    pi = partition(a, l, r)
    if k == pi:
        return a[k]
    return qs(a, l, pi-1, k) if k < pi else qs(a, pi+1, r, k)

def kth(a, k):
    if not 1 <= k <= len(a):
        raise ValueError("k out of range")
    return qs(a, 0, len(a)-1, k-1)

# example
arr = [12, 3, 5, 7, 19, 2, 11, 17]
print("4th smallest:", kth(arr, 4))
