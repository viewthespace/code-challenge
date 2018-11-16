# Runtime O(N)
# Space O(1)
def knightDialer(N):
    graph = [ [4,6], [6,8], [7,9], [4,8], [3,9,0], [], [1,7,0], [2,6], [1,3], [2,4] ]
    dp = [1] * 10
    
    for i in range(N-1):
        dp2 = [0] * 10
        for i, neighbors in enumerate(graph):
            dp2[i] = sum(dp[n] for n in neighbors)
        dp = dp2    

    return sum(dp) % (10**9 + 7)