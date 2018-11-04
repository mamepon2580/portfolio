//janken.js
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
    makeYuki(
      8,//input1_2(lines[0]),
      [4,5,6,1,3,5]//input2_1(lines[1])
    )
  )
});
//--------IO関数--------
//一行目の二つめのIntを取り出す関数
function input1_2(str){
  let arr = str.split(' ');
  return(Number(arr[1]));
}
//二行目のStringをArreyとして取り出す関数
function input2_1(str){
  let arr = str.split(' ');
  return(arr.map(Number));
}
//--------main関数--------
//小さい順にソートする関数
function sortFunc(arr){
  let arr = arr.sort(function(x,y){
          if( x < y ) return -1;
          if( x > y ) return 1;
          return 0;
  });
  return(arr);
}
//雪だるまの組み合わせを見つけ作る数を数える関数
function makeYuki(k,arr){
  function makeCycle(arr){
    n = 0;
    while(arr.length !== 1){
      for(i = 0; i <= arr.length; i++){
        //雪だるまを作る組み合わせがないのでその数を配列から取り除く
        if (arr[i] === undefined) {
          arr.shift()
          break;
        //雪だるまを作り使った数を配列から取り除く
        }else if(arr[1] + arr[i] >= k){
          arr.splice(i,1);
          arr.shift();
          n++;
          console.log(arr);
          break;
        }
      }
    }
    //while文を抜けたので作った雪だるまの数を返す
    return(n);
  }
  let m = makeCycle(arr);
  return(m);
}
