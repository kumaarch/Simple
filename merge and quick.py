import random
import time
import matplotlib.pyplot as plt

def merge_sort(a):
    if len(a) <= 1:
        return a
    m = len(a) // 2
    L = merge_sort(a[:m])
    R = merge_sort(a[m:])
    i = j = 0
    res = []
    while i < len(L) and j < len(R):
        if L[i] < R[j]:
            res.append(L[i]); i += 1
        else:
            res.append(R[j]); j += 1
    return res + L[i:] + R[j:]

def quick_sort(a):
    if len(a) <= 1:
        return a
    p = a[len(a) // 2]
    L = [x for x in a if x < p]
    E = [x for x in a if x == p]
    G = [x for x in a if x > p]
    return quick_sort(L) + E + quick_sort(G)

def time_sort(f, a):
    t0 = time.perf_counter()
    f(a)
    return time.perf_counter() - t0

ns = range(100, 1001, 100)
mt = []
qt = []
for n in ns:
    arr = [random.randint(1, 10000) for _ in range(n)]
    mt.append(time_sort(merge_sort, arr.copy()))
    qt.append(time_sort(quick_sort, arr.copy()))

plt.plot(ns, mt, label="Merge Sort")
plt.plot(ns, qt, label="Quick Sort")
plt.xlabel("Number of elements (n)")
plt.ylabel("Time (seconds)")
plt.legend()
plt.show()
