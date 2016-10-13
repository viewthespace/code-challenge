size = int(input().rstrip())
def neighbors(i,j):
    fin = []
    for x in [-1,1]:
        if i + x > -1 and i + x < size:
            fin.append((i+x,j))
        if j + x > -1 and j + x < size:
            fin.append((i,j+x))
    return fin


def traverse(i,j,count):
    higher = [(x,y) for (x,y) in neighbors(i,j) if par[x][y] is orig[i][j] and not marked[x][y]]
    for (x,y) in higher:
        marked[x][y] = True
    marked[i][j] = True
    if higher:
        count += len(higher)
    else:
        return count
    for (x,y) in higher:
        count = traverse(x,y,count)
    return count

marked = [[False for _ in range(size)] for _ in range(size)]


orig = []

for _ in range(size):
    orig.append(list(map(lambda x: int(x), input().rstrip().split(' '))))

par = [[None for _ in range(size)] for _ in range(size)]

for i in range(size):
    for j in range(size):
        cur_neighbors = [orig[x][y] for (x,y) in neighbors(i,j)]
        min_neigh = min(cur_neighbors)
        if min_neigh < orig[i][j]:
            par[i][j] = min_neigh

for i in range(size):
    for j in range(size):
        if par[i][j] is None:
            count = 1
            print("basins: %s"%traverse(i,j,count))
print()


