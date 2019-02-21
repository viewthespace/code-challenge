/**
 * dedup()
 * runtime: O( N )
 * memory: O( N LOGK(N) ) K being the average number of edges per node
 */
function dedup(n, cache) {
  if(!cache) cache = {};
  var values = [];
  for(var i = 0; i < n.edges.length; i++){
    var key = dedup(n.edges[i], cache).hash;
    if(cache[key]) {
      n.edges[i] = cache[key];
    } else {
      cache[key] = n.edges[i];
    }
    values.push(key);
  }
  n.hash = '[' + n.val + '-' + values.join(':') + ']';
  return n;
}
