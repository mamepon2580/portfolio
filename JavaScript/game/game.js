//game.js
//B027
//100
//---------IO処理---------
var lines = [];
var reader = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});
reader.on('line', (line) => {
  lines.push(line)
});
reader.on('close', () => {
  console.log(

  )
});
//--------IO関数--------
//文字列を数値の配列に直す関数
function makeArrInt(str){
  let arrInt = str.split(' ').map(Number);
  return(arrInt);
}
//---------main関数---------
//プレイヤー数を抽出する関数
function player(str){
  let playerNum = makeArrInt(str)[2];
  return(playerNum);
}
//配列にカードを格納
function data(arrStr){
  let arrArrInt = [];
  for(i = 1; i < arrStr.length; i++){
    arrArrInt.push(makeArrInt(arrStr[i]));
  }
  return(arrArrInt);
}
//得点を定義
let arrScore = [];
for(i = 0; i < player(lines)){
  arrScore.push(0);
}
//カードをめくる
function check(i,j,k,l){
  let first = arrArrInt[i][j];
  let second = arrArrInt[k][l];
  if(first == second){
    return(true);
  }else {
    return(false);
  }
}
//ターンとプレイヤー
function play(){

}
