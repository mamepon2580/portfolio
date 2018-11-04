//count.js
var lines = [];
var reader = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});
reader.on('line', (line) => {
  lines.push(line);
});
reader.on('close', () => {
  console.log(count(lines));
});

//main関数
//単語の数をカウント
function count(arrey){
  //関数部分
  //Stringがすでにあれば+1なければ1を代入
  function plus(associative,string){
    if(associative[string] === undefined){
      associative[string] = 1;
    }else {
      associative[string] = associative[string] + 1;
    }
    return(associative)
  }
  //スクリプト部分
  let associative = {};
  //連鎖的にplusを適応
  for(i = 0; i < arrey.length; i++){
    associative = plus(associative,arrey[i]);
  }
  return(associative);
}
