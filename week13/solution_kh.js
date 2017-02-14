function d(xs) {
  return xs.map((el => (this.sum = this.sum || xs.reduce((agg, el) => agg + el) / (xs.length - 1)) - el ));
}

