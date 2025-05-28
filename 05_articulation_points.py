from collections import defaultdict

def find_articulation_points(graph):
    def dfs(vertex, parent):
        nonlocal time
        visited.add(vertex)
        discovery_time[vertex] = low[vertex] = time
        time += 1
        children = 0
        for neighbor in graph[vertex]:
            if neighbor == parent:
                continue
            if neighbor not in visited:
                children += 1
                dfs(neighbor, vertex)
                low[vertex] = min(low[vertex], low[neighbor])
                if parent is None and children > 1:
                    articulation_points.add(vertex)
                if parent is not None and low[neighbor] >= discovery_time[vertex]:
                    articulation_points.add(vertex)
            else:
                low[vertex] = min(low[vertex], discovery_time[neighbor])

    visited = set()
    discovery_time = {}
    low = {}
    articulation_points = set()
    time = 0
    for vertex in graph:
        if vertex not in visited:
            dfs(vertex, None)
    return articulation_points

graph = {
    'A': ['B', 'C'],
    'B': ['A', 'D', 'E'],
    'C': ['A', 'F'],
    'D': ['B'],
    'E': ['B', 'F'],
    'F': ['C', 'E']
}

articulation_points = find_articulation_points(graph)
print("Articulation points:", articulation_points)