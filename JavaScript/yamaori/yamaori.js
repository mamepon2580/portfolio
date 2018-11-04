//yamaori.js
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
  console.log(origami(input1_1(lines[0])));
});
//--------IO関数--------
function input1_1(str){
  let arr = str.split(' ');
  return(Number(arr[0]));
}
//--------main関数--------
function origami(n){
  function reverce01(arr){
    let arrRev = [];
    for(let j = 0; j < arr.length; j++){
      if(arr[j] === 0){
        arrRev[arr.length - j - 1] = 1;
      }else{
        arrRev[arr.length - j - 1] = 0;
      }
    }
    return(arrRev);
  }
  let arr = [];
  for(let i = 0; i < n; i++){
    arr = (arr.concat([0]).concat(reverce01(arr)));
  }
  return(arr);
}
