# Songs About Rain

Given a list of integers representing the crossectional elevations of a line,
calculate the amount of water that would be caught after an infinite amount of
rain assuming any rain that spills of the side does not build up


## example 1

### input
```javascript
[ 1, 3, 4, 2, 3, 5, 4, 5 ]

/*

if this were land, this would look like:

     x x
  x  xxx
 xx xxxx
 xxxxxxx
xxxxxxxx

*/
```

### output
```javascript
4


/*

explanation:

given this input list, the blocks marked with a '.' would be filled with water

     x.x
  x..xxx
 xx.xxxx
 xxxxxxx
xxxxxxxx

*/
```
