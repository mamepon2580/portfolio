//tashizan.js
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
  console.log(plus(lines));
});
//--------main関数--------
function plus(lines){
  let result = Number(lines[0]) + Number(lines[1]);
  return(result);
}
