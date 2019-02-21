![hi pdf_2017-02-14_08-03-44](https://cloud.githubusercontent.com/assets/439933/22929970/37672c14-f28c-11e6-8d4c-5c7c576a21b1.png)

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
