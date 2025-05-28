def is_safe(b, r, c, n):
    for i in range(r):
        if b[i][c]:
            return False
    for i, j in zip(range(r-1, -1, -1), range(c-1, -1, -1)):
        if b[i][j]:
            return False
    for i, j in zip(range(r-1, -1, -1), range(c+1, n)):
        if b[i][j]:
            return False
    return True

def solve(b, r, n):
    if r == n:
        return True
    for c in range(n):
        if is_safe(b, r, c, n):
            b[r][c] = 1
            if solve(b, r+1, n):
                return True
            b[r][c] = 0
    return False

def n_queens(n):
    b = [[0]*n for _ in range(n)]
    if not solve(b, 0, n):
        print("No solution")
        return False
    for row in b:
        print(" ".join('Q' if x else '.' for x in row))
    return True

# Example usage
n_queens(4)
