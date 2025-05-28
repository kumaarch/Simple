from collections import deque
def bfs(graph, start):
    queue = deque([start])
    visited = set()

    while queue:
        vertex = queue.popleft()
        if vertex not in visited:
            visited.add(vertex)
            print(vertex, end=" ")  # Print the visited vertex
            for neighbor in graph[vertex]:  # Correct indentation for the 'for' loop
                if neighbor not in visited:
                    queue.append(neighbor)
graph = {
    'A': ['B', 'C'],
    'B': ['A', 'D'],
    'C': ['A', 'D'],
    'D': ['B', 'C']
}
bfs(graph, 'A')

