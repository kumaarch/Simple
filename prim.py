import heapq

def prim(g, start=None):
    if start is None:
        start = next(iter(g))
    visited = {start}
    pq = [(w, start, v) for v, w in g[start].items()]
    heapq.heapify(pq)
    mst = []
    while pq:
        w, u, v = heapq.heappop(pq)
        if v in visited:
            continue
        visited.add(v)
        mst.append((u, v, w))
        for v2, w2 in g[v].items():
            if v2 not in visited:
                heapq.heappush(pq, (w2, v, v2))
    return mst

graph = {
    'A': {'B': 4, 'C': 2},
    'B': {'A': 4, 'C': 5, 'D': 10},
    'C': {'A': 2, 'B': 5, 'D': 3},
    'D': {'B': 10, 'C': 3}
}

res = prim(graph, 'A')
total = sum(w for _, _, w in res)

print("MST edges:", res)
print("Total cost:", total)
