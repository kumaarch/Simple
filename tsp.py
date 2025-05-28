import itertools, math, random

def dist(a, b):
    return math.hypot(a[0] - b[0], a[1] - b[1])

def bf(c):
    n = len(c)
    best = float('inf')
    best_path = ()
    for perm in itertools.permutations(range(1, n)):
        d = 0
        prev = 0
        for v in perm:
            d += dist(c[prev], c[v])
            prev = v
        d += dist(c[prev], c[0])
        if d < best:
            best = d
            best_path = (0,) + perm + (0,)
    return best, best_path

def nn(c):
    n = len(c)
    visited = [False] * n
    path = [0]
    visited[0] = True
    total = 0
    for _ in range(n - 1):
        u = path[-1]
        nxt = min((i for i in range(n) if not visited[i]),
                  key=lambda x: dist(c[u], c[x]))
        total += dist(c[u], c[nxt])
        visited[nxt] = True
        path.append(nxt)
    total += dist(c[path[-1]], c[0])
    path.append(0)
    return total, tuple(path)

def solve_tsp(n=5, seed=None):
    if seed is not None:
        random.seed(seed)
    cities = [(random.randint(0, 10), random.randint(0, 10)) for _ in range(n)]
    opt_d, opt_path = bf(cities)
    app_d, app_path = nn(cities)
    err = (app_d - opt_d) / opt_d * 100

    print(f"Cities: {cities}")
    print(f"Optimal (BF): path={opt_path}, dist={opt_d:.2f}")
    print(f"Approx (NN): path={app_path}, dist={app_d:.2f}")
    print(f"Error: {err:.2f}%")

# Example run
solve_tsp()
