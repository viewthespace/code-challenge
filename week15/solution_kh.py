import functools as f
import random as r

def money(arr):
    return f.reduce(
        lambda agg, x: [min(agg[0], x), max(0, max(x - agg[0], agg[1]))],
        arr,
        [float('inf'), float('-inf')]
    )

while(True):
    l = [r.randint(0, 12) for _ in range(r.randint(2, 7))]
    x = money(l)
    print(l)
    print(x)
    print('Generated list:\n\n%s\n\nThe greatest positive sequential difference is %i\n' % (l, x[1]))
    if input("Would you like to continue? [yN] ") is not "y":
        break
    print()
