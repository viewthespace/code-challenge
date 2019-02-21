// Runtime O(N)
// Memory sizeof(int) * 18
//
var isValidSudoku = function(board) {
    var colUnique = [0,0,0,0,0,0,0,0,0];
    var gridUnique = [0,0,0,0,0,0,0,0,0];
    for(var i = 0; i < 9; i++){
      var rowUnique = 0;
      for(var j = 0; j < 9; j++){
        var val = board[i][j];
        if (!val) continue;
        rowUnique ^= 1 << val;
        colUnique[j] ^= 1 << val;
        var gridIndex = ((i / 3) >> 0) * 3 + ((j / 3) >> 0);
        gridUnique[gridIndex] ^= 1 << val;
        if ( (((rowUnique >> val) & 1) === 0) || (((colUnique[j] >> val) & 1) === 0) || (((gridUnique[gridIndex] >> val) & 1) === 0) ){
          return false;
        }
      }
    }
    return true;
};