# Drop it Low

Given an N x N elevation map (matrix where each element represents a height),
for each basin in the the map output the size of the basin.

Caveats:

- Imagine water flows from high to low. Given that a point has multiple
different neighbor points that are lower than itself, it is considered part
of the basin that the lowest neighbor is a part of.
- Water only flows to its lowest neighbor
- You do not have to output the partitions themselves, only the size of the
basins.
- Extra points if you do it in N time

Example 1:

Input:
```
3 
1 5 2 
2 4 7 
3 6 9 
```

Output:
```
7 2
```

Explanation:

In this case, there are two basins:
```
A A B 
A A B 
A A A 
```

---

Example 2:

Input:
```
1 
10 
```

Output:
```
1
```

Explanation:

There is only one point here so that's the basin

---

Example 3:

Input:
```
5 
1 0 2 5 8 
2 3 4 7 9 
3 5 7 8 9 
1 2 5 4 2 
3 3 5 2 1 
```

Output:
```
11 7 7
```

Explanation:

There are three different basins here:
```
A A A A A 
A A A A A 
B B A C C 
B B B C C 
B B C C C 
```

---

Example 4:

Input:
```
4 
0 2 1 3 
2 1 0 4 
3 3 3 3 
5 5 2 1 
```

Output:
```
7 5 4
```

Explanation:

There are once again three different basins here:

```
A A B B 
A B B B 
A B B C 
A C C C
```

