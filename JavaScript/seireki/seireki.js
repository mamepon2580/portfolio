//seireki.js
//D009
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
    sa(
      toIntArr(lines[0])
    )
  )
});
//--------IO関数--------
//文字列を数値の配列に直す関数
function toIntArr(strIn){
  let intArrOut = strIn.split(' ').map(Number);
  return(intArrOut);
}
//--------main関数--------
//配列の2つの要素を引き算する関数
function sa(intArr){
  int = intArr[1] - intArr[0];
  return(int)
}
