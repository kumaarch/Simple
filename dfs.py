def dfs(g, u, v=None):
    if v is None:
        v = set()
    v.add(u)
    order = [u]
    for w in g.get(u, []):
        if w not in v:
            order += dfs(g, w, v)
    return order

# example graph
graph = {
    'A': ['B', 'C'],
    'B': ['A', 'D', 'E'],
    'C': ['A', 'F'],
    'D': ['B'],
    'E': ['B', 'F'],
    'F': ['C', 'E']
}

print("DFS order:", dfs(graph, 'A'))
