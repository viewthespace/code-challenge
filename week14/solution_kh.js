function (a, b) {
  let parse = (str) => str.split('.').map(parseInt)
  let as = parse(a), bs = parse(b)

  let maxList,minlist
  if(as.length > bs.length){maxlist=as;minlist=bs}
  for (let i = maxList.length; i > -1; i--) {
    let x=maxList[i], y=minList[i]
    if [x, y].includes(null) break
    if (x != y) return !!(x > y)
  }
  return 0
}
