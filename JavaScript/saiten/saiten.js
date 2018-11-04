//saiten.js
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
    check(
      Number(lines[0].split(' ')[1]),
      makeArr(lines)
    )
  )
});
//---------IO関数---------
function makeArr(arrStr){
  arrArrInt = [];
  for(i = 1; i < arrStr.length; i++){
    let arrInt = arrStr[i].split(' ').map(Number);
    arrArrInt.push({score:arrInt[0],rest:arrInt[1]});
  }
  return(arrArrInt)
}
//---------main関数---------
function check(border,arrArrInt){
  idArr = [];
  for(i = 0; i < arrArrInt.length; i++){
    if(arrArrInt[i].score - 5 * arrArrInt[i].rest >= border || border == 0){
      idArr.push(i + 1);
    }
  }
  return(idArr.join('\n'))
}
