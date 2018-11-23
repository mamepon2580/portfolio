//btn.js
//D060
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
    expr(
      makeArrInt(lines[0])
    )
  );
});
//--------IO関数--------
//文字列を数値の配列に直す関数
function makeArrInt(str){
  let arrInt = str.split(' ').map(Number);
  return(arrInt);
}
//--------main関数--------
//いる座標を計算する関数
function expr(intArr){
  let int = 1 * intArr[0] + (-1) * 1 * intArr[1];
  return(int);
}
