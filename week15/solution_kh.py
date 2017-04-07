import functools

def money(arr):
    return functools.reduce(
        lambda agg, x: [min(agg[0], x), max(agg[1], x), max(x - agg[0], agg[2])],
        arr,
        [float('inf'), float('-inf'), float('-inf')]
    )[2]

print(money([ 220, 214, 60, 110, 55, 126, 42 ]))
