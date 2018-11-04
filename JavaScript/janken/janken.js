//janken.js
//IO処理
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
    winMax(
      //winMaxの第一引数
      makeGCPset(
        //makeGCPsetの第一引数
        input1_1(lines[0]),
        //makeGCPsetの第二引数
        input1_2(lines[0])
      ),
      //winMaxの第二引数
      countGCP(input2_1(lines[1]))
    )
  )
});
//関数
//IO関数
//一行目の一つめのIntを取り出す
function input1_1(str){
  arr = str.split(' ');
  return(Number(arr[0]));
}
//一行目の二つめのIntを取り出す
function input1_2(str){
  let arr = str.split(' ');
  return(Number(arr[1]));
}
//二行目のStringをArreyとして取り出す
function input2_1(str){
  let arr = str.split('');
  return(arr);
}
//main関数
//出せる手の組み合わせのArreyを作る(xは試合回数、yは全体の指の本数)
function makeGCPset(x,y){
  let assArr = [];
  for(i = 0; 5 * i <= y; i++){
    let p = i;
    if((y - (5 * p)) % 2 === 0){
      let c = (y - (5 * 1)) / 2;
      let g = (x - p - c);
      assArr.push({G:g,C:c,P:p});
    }
  }
  return(assArr);
}
//相手の出して来た手を数える
function countGCP(arr){
  let ass = {G: 0, C: 0, P: 0};
  for(i = 0; i <= arr.length; i++){
    switch(arr[i]){
      case "G":
        ass.G = ass.G + 1;
        break;
      case "C":
        ass.C = ass.C + 1;
        break;
      case "P":
        ass.P = ass.P + 1;
        break;
    }
  }
  return(ass);
}
//最大のかつ数を数える
function winMax(assArr,assYou){
  let winMaxNum = 0;
  for(i = 0; i < assArr.length; i++){
    let assI = assArr[i];
    //グーで勝った数
    function ()if(assI.G > assYou.C){
      let winG = assYou.C;
    }
    else{
      let winG = assI.G;
    }
    //チョキで買った数
    if(assI.C > assYou.P){
      let winC = assYou.P;
    }
    else{
      let winC = assI.C;
    }
    //パーで買った数
    if(assI.P > assYou.G){
      let winP = assYou.G;
    }
    else{
      let winP = assI.P;
    }
    //買った数の合計
    let winNum = winG + winC + winP
    if(winMaxNum < winNum){
      let winMaxNum = winNum;
    }
  }
  return(winMaxNum);
}
