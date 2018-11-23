//taifuu.js
//D048
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
    saCycle(lines)
  )
});
//---------main関数---------
//
function saCycle(arrIntIn){
  arrIntOut = [];
  for(i = 0; i < arrIntIn.length - 1; i++){
    arrIntOut.push(arrIntIn[i + 1] - arrIntIn[i])
  }
  return(arrIntOut.join('\n'));
}
