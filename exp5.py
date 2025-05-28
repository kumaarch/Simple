from collections import deque

# BFS function to traverse the graph
def bfs(graph, start):
    # Initialize a set to track visited nodes
    visited = set()
    # Create a queue to manage the BFS traversal
    queue = deque([start])
    # Mark the start node as visited
    visited.add(start)

    # Traverse the graph
    while queue:
        # Dequeue a node from the queue
        node = queue.popleft()
        print(node, end=" ")

        # Visit all unvisited neighbors of the node
        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)

# Example usage of the BFS function
# Graph representation using an adjacency list
graph = {
    'A': ['B', 'C'],
    'B': ['A', 'D', 'E'],
    'C': ['A', 'F'],
    'D': ['B'],
    'E': ['B', 'F'],
    'F': ['C', 'E']
}

# Starting BFS from node 'A'
print("BFS Traversal starting from node 'A':")
bfs(graph, 'A')
