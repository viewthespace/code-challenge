moves = [[4,6],[6,8],[7,9],[4,8],[3,9,0],[], [1,7,0],[2,6],[1,3],[2,4]]

modulus = 10**9 + 7

def solver(N):
    memo = [
        [ 0 for y in range(10) ]
        for x in range(N)
    ]

    def aux(i, N):
        print(i)
        if N == 2:
            return moves[i]

        for dest in moves[i]:
            print("evaluating", dest)
            if (memo[N - 1][dest] == 0):
                memo[N-1][dest] = aux(dest, N - 1)

    for start in range(len(moves)):
        aux(start, N-1)
    print(memo)

solver(5)
