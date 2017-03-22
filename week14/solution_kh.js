module.exports = function cmp(aIn, bIn) {
  let a = aIn.split('.')
  let b = bIn.split('.')

  for (let i = Math.max(a.length, b.length); i > -1; i--) {
    if (a[i] > b[i]) {
      return 1
    }
  }
  return -1
}
