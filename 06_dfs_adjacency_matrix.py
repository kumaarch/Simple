def dfs_from_adjacency_matrix(matrix, start):
    def dfs(vertex, visited):
        visited.add(vertex)
        print(vertex, end=" ")
        for neighbor, is_connected in enumerate(matrix[vertex]):
            if is_connected and neighbor not in visited:
                dfs(neighbor, visited)

    visited = set()
    dfs(start, visited)

adjacency_matrix = [
    [0, 1, 1, 0],
    [1, 0, 0, 1],
    [1, 0, 0, 1],
    [0, 1, 1, 0]
]

dfs_from_adjacency_matrix(adjacency_matrix, 0)