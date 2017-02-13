/*
* Ax = B
* A is the encryption matrix with 1s everywhere except the diagonals, which are zero
* x are the decrypted numbers
* B are the encrypted numbers
*
* We find x by multiplying by the inverse of A, the encryption matrix
* The inverse of A turns out to be a nice symmetric matrix which is implemented below 
*/
function decrypt(nums) {
  var decrypted = [];
  var n = nums.length;
  var diagonal =  (2 - n) / (n - 1);
  var offDiagonal = 1 / (n - 1);
  for(let i = 0; i < n; i++) {
    var decryptedNum = 0;
    for(let j = 0; j < n; j++) {
      if(i === j) {
        decryptedNum += diagonal * nums[j];
      } else {
        decryptedNum += offDiagonal * nums[j];
      }
    }
    decrypted.push(decryptedNum);
  }
  return decrypted;
}