### Week 6 Coding Challenge - Dedup DAG (Directed Acyclic Graph)

Given a DAG, write a function that makes all duplicate subtrees point
to only one instance of that subtree and then returns the original root node.

Example 1:

Input:
```
        5
      /   \
     3     6
    / \     \
   1   4     3
            / \
           1   4
```

Output:
```
        5
      /   \
     3 --- 6
    / \
   1   4
```

Example 2:

Input:
```
      4
     / \
    3   5
         \
          6
         /
        3
```

Output:
```
     4
    / \
   |   5
   \    \
    \    6
     \  /
       3
```

Example 3:

Input:
```
        5
      /   \
     3     6
    / \     \
   1   4     3
            / \
           1   5
```

Output:
```
        5
      /   \
     3     6
    / \     \
   |   4     3
    \       / \
     ------1   5
```

