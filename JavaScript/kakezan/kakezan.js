//kakezan.js
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
  console.log(plus(StringToInt(lines)));
});
//--------IO関数--------
function StringToInt(str){
  let arrey = str[0].split(' ');
  return(arrey);
}
//main関数
function plus(arrey){
  let result = Number(arrey[0]) * Number(arrey[1]);
  return(result);
}
