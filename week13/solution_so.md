![hi pdf_2017-02-13_20-53-54](https://cloud.githubusercontent.com/assets/439933/22911844/fdc578aa-f22f-11e6-8ed8-af25aeec2159.png)
```Javascript
function decrypt(nums) {
  var decrypted = [];
  var c = 0;
  for(let i = 0; i < nums.length; i++) {
    c += 1 / (nums.length - 1) * nums[i];
  }
  for(let i = 0; i < nums.length; i++) {
    decrypted.push(c - nums[i]);
  }
  return decrypted;
}
```
