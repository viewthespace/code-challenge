((world) => {
  let outerCount = 0;
  let innerCount = 0;

  function makeDatPaper(stocks, source, store = {}) {
    console.time("execution time");
    if (stocks.length === 1 || store.done) {
      console.log(
      `
=====================================
--------- Making Dat Paypah ---------
=====================================
There are ${source.length} days.
Buying for \$${store.buy} on day ${source.indexOf(store.buy) + 1}.
Selling for \$${store.sell} on day ${source.indexOf(store.sell) + 1}.
Profit is \$${store.profit}.
There were ${outerCount} iterations and ${innerCount} comparisons.
      `);
      console.timeEnd("execution time");
      return;
    }

    outerCount = outerCount + 1;
    if (!store.profit) store.profit = 0;
    if (!source) source = Array.from(stocks);

    const [head, ...tail] = stocks.sort((a,b) => a - b);
    const list = Array.from(tail).reverse();

    list.some(function(val) {
      innerCount = innerCount + 1;
      const qualifies = source.indexOf(val) > source.indexOf(head);
      const profit = val - head;
      if (qualifies && profit > store.profit) {
        store = {
          buy: head,
          sell: val,
          profit: profit,
          done: true
        };
        return true;
      }
    });

    makeDatPaper(tail, source, store);
  }

  return world.makeDatPaper = makeDatPaper;
})(window);

makeDatPaper([ 220, 214, 60, 110, 55, 126, 42 ]);
makeDatPaper([ 9, 12, 4, 10, 11 ]);
