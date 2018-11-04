//bonus.js
//D098
//100
//--------IO処理--------
var lines = [];
var reader = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});
reader.on('line', (line) => {
  lines.push(line);
});
reader.on('close', () => {
  console.log(
    seki(
      makeArrInt(lines[0])
    )
  );
});
//--------IO関数--------
//配列の2つの要素を掛け算する関数
//文字列を数値の配列に直す関数
function makeArrInt(str){
  let arrInt = str.split(' ').map(Number);
  return(arrInt);
}
//--------main関数--------

function seki(arrInt){
  let int = arrInt[0] * arrInt[1];
  return(int);
}
