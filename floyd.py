def floyd(g):
    d = {i:{j:float('inf') for j in g} for i in g}
    for i in g:
        d[i][i] = 0
        for j, w in g[i].items():
            d[i][j] = w
    for k in g:
        for i in g:
            for j in g:
                x = d[i][k] + d[k][j]
                if d[i][j] > x:
                    d[i][j] = x
    return d

# example graph
graph = {
    'A': {'B': 4, 'C': 2},
    'B': {'A': 4, 'C': 5, 'D': 10},
    'C': {'A': 2, 'B': 5, 'D': 3},
    'D': {'B': 10, 'C': 3}
}

res = floyd(graph)
print(res)
