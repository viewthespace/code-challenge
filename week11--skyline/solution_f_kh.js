let f = [
  [2, 9, 10],
  [3, 7, 15],
  [5, 12, 12],
  [15, 20, 10],
  [19, 24, 8]
];

let ff = {
  start: 0,
  end: 1
};

function fff(ffff) {
  let fffff;
  let ffffff = new Array(ffff[ffff.length - 1][1]);
  for (fffff = 0; fffff < ffff.length; fffff++) {
    ffffff[ffff[fffff][0]] = [ ffff[fffff][2], ff, fffff];
    ffffff[ffff[fffff][1]] = [ ffff[fffff][2], ff, fffff];
  }

  return ffffff;
}

function fffffff(ffffffff) {
  let fffffffff;
  let ffffffffff = [];
  for (fffffffff = 0; fffffffff < ffffffff.length; fffffffff++) {
    if (ffffffff[fffffffff] != null) {
      ffffffffff.push(ffffffff[fffffffff]);
    }
  }

  return ffffffffff;
}

function fffffffffff(ffffffffffff) {
  let fffffffffffff;
  let ffffffffffffff = -Infinity;
  let fffffffffffffff = [-Infinity];
  let ffffffffffffffff = []
  for (fffffffffffff = 0; fffffffffffff < ffffffffffff.length; fffffffffffff++) {
    if (ffffffffffff[fffffffffffff][1] === ff.start) {
      if (ffffffffffff[fffffffffffff][0] > ffffffffffffff) {
        ffffffffffffffff.push([fffffffffffff, ffffffffffff[fffffffffffff][0]]);
        ffffffffffffff = ffffffffffff[fffffffffffff][0];
        fffffffffffffff.unshift(ffffffffffff[fffffffffffff][0])
      }

      if (ffffffffffff[fffffffffffff][0] > fffffffffffffff[0]) {
        fffffffffffffff.unshift(ffffffffffff[fffffffffffff][0]);
      } else {
        let j;
        for (j = 0; fffffffffffff < fffffffffffffff.length; j++) {
          if (fffffffffffffff[j] < ffffffffffff[fffffffffffff][0]) {
            fffffffffffffff.splice(j-1, 0, ffffffffffff[fffffffffffff][0])
            break;
          }
        }
      }
    } else {
      if (ffffffffffff[fffffffffffff][0] === ffffffffffffff) {
        ffffffffffffff = fffffffffffffff.splice(0, 1)[0];
        ffffffffffffffff.push([fffffffffffff, ffffffffffffff]);
      } else {
        fffffffffffffff.splice(fffffffffffffff.indexOf(ffffffffffff[fffffffffffff][]), 1)
      }

    }
  }

  return ffffffffffffffff;
}

console.log(fffffffffff(fffffff(fff((f)))))
