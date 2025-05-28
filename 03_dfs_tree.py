class TreeNode:
    def __init__(self, value):
        self.value = value
        self.children = []

def dfs(node):
    if node is None:
        return
    print(node.value, end=" ")
    for child in node.children:
        dfs(child)

root = TreeNode('A')
node_b = TreeNode('B')
node_c = TreeNode('C')
node_d = TreeNode('D')
node_e = TreeNode('E')
node_f = TreeNode('F')

root.children = [node_b, node_c]
node_b.children = [node_d, node_e]
node_c.children = [node_f]

dfs(root)