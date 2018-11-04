//book.js
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
    changeCycle(
      input1_1(lines[0]),
      input2_1(lines[1])
    )
  )
});
//--------IO関数--------
//一行目の一つめのIntを取り出す
function input1_1(str){
  arr = str.split(' ');
  return(Number(arr[0]));
}
//二行目のStringをArreyとして取り出す
function input2_1(str){
  let arr = str.split(' ');
  return(arr);
}
//--------main関数--------
//再帰的に２つの値を入れ替える関数
function changeCycle(n,arr){
  function change(n,i,arr){
    let save = i + 1;
    for(j = i + 1; j < arr.length; j++){
      if(arr[j] < arr[save]){
        save = j;
      }
    }
    //はじめに掴んだ値があとに掴んだ値より大きい場合のみ交換
    if(arr[i] > arr[save]){
      let saveArr = arr[save];
      arr[save] = arr[i];
      arr[i] = saveArr;
      //交換した回数を記録
      h++;
    }
    //nの値が0になったら終了してarrを返す
    //0でなければnの値を1減らしてループ
    if(n === 0){
      return(arr);
    }else{
      i = (i + 1) % arr.length
      return(change(n - 1,i++,arr));
    }
  }
  let h = 0;
  arr = change(n,0,arr);
  //交換した回数hを返す
  return(h);
}
