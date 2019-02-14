let arr = [1, 3, 4, 2, 3, 5, 4, 5]

function volume(xs) {
  const max = Math.min(xs[0], xs[xs.length - 1])
  const helper = xs => xs.reduce((agg, x) => agg + (max - x), 0)

  return helper(xs.slice(1, -1))
}

const isLocalMaxima = (i, xs) => xs[i] > xs[i - 1] && xs[i] > xs[i + 1]

const isLocalMinima = (i, xs) => xs[i] < xs[i - 1] && xs[i] < xs[i + 1]

function WhatsInTheBox(arr) {
  const xs = [-Infinity, ...arr, -Infinity]

  const maxima = xs.reduce(
    (agg, x, i, xs) => (isLocalMaxima(i, xs) ? [...agg, i] : agg),
    []
  )

  const peaks = maxima.reduce(
    (agg, i, _j, maxima) => (isLocalMinima(i, maxima) ? agg : [...agg, i]),
    []
  )

  let vol = 0

  return peaks.slice(1).reduce(
    (agg, x) => ({
      volume: agg.volume + volume(xs.slice(agg.previous, x + 1)),
      previous: x
    }),
    { previous: peaks[0], volume: 0 }
  ).volume
}

module.exports = {
  isLocalMaxima,
  isLocalMinima,
  WhatsInTheBox,
  volume
}
