//guuki.js
//D101
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
    guuki(
      wa(
        makeArrInt(lines[0])
      )
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
//配列の2つの要素を足し算する関数
function wa(arrInt){
  let int = arrInt[0] + arrInt[1];
  return(int)
}
//値が奇数ならYES偶数ならNOを返す関数
function guuki(int){
  if(int % 2 === 1){
    return("YES");
  }else{
    return("NO");
  }
}
