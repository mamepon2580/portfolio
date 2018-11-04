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

//function
function StringToInt(str){
  let arrey = str[0].split(' ');
  return(arrey);
}

function plus(arrey){
  let result = Number(arrey[0]) * Number(arrey[1]);
  return(result);
}
