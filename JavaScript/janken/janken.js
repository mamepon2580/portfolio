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
      makeGCPset(
        input1_1(lines[0]),
        input1_2(lines[0])
      ),
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
  arr = str.split(' ');
  return(Number(arr[1]));
}
//二行目のStringをArreyとして取り出す
function input2_1(str){
  arr = str.split('');
  return(arr);
}
//main関数
//出せる手の組み合わせのArreyを作る(xは試合回数、yは全体の指の本数)
function makeGCPset(x,y){
  assArr = [];
  for(i = 0; 5 * i <= y; i++){
    p = i;
    if((y - (5 * p)) % 2 === 0){
      c = (y - (5 * 1)) / 2;
      g = (x - p - c);
      assArr.push({G:g,C:c,P:p});
    }
  }
  return(assArr);
}
//相手の出して来た手を数える
function countGCP(arr){
  ass = {G: 0, C: 0, P: 0};
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
  winMaxNum = 0;
  for(i = 0; i < assArr.length; i++){
    assI = assArr[i];
    //グーで勝った数
    if(assI.G > assYou.C){
      winG = assYou.C;
    }
    else{
      winG = assI.G;
    }
    //チョキで買った数
    if(assI.C > assYou.P){
      winC = assYou.P;
    }
    else{
      winC = assI.C;
    }
    //パーで買った数
    if(assI.P > assYou.G){
      winP = assYou.G;
    }
    else{
      winP = assI.P;
    }
    //買った数の合計
    winNum = winG + winC + winP
    if(winMaxNum < winNum){
      winMaxNum = winNum;
    }
  }
  return(winMaxNum);
}
