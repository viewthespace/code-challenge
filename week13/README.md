# Read Between the Lines

Write a program that decrypts a message with the following encryption algorithm:

- An initial array of data (called A) is an array of integers.
- The encrypted array of data (called E) is the same size as A. Each entry of the encrypted array E
is the sum of all entries in A that are not in the same position as the entry being calculated. For example,
with the original array A consisting of:

`1 2 3 4 5`
- The encrypted array E will be:

`14 13 12 11 10`

## Example 1
### Input
```
5
14
13
12
11
10
```

### Output
```
1
2
3
4
5
```

### Explanation
```
1st entry: 14 = 2+3+4+5
2nd entry: 13 = 1+3+4+5
3rd entry: 12 = 1+2+4+5
4th entry: 11 = 1+2+3+5
5th entry: 10 = 1+2+3+4
```

## Example 2
### Input
```
6
322
177
240
295
322
289
```

### Output
```
7
152
89
34
7
40
```

### Explanation
```
1st entry: 322 = 152+89+34+7+40
2nd entry: 176 = 7+89+34+7+40
3rd entry: 239 = 7+152+34+7+40
4th entry: 294 = 7+152+89+7+40
5th entry: 321 = 7+152+89+34+40
6th entry: 288 = 7+152+89+34+7
```

