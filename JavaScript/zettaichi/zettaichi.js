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
    abs(lines[0].split(" ").map(Number))
  )
});

function abs(arr){
  if(arr[0] >= 0){
    return(arr[0]);
  }else{
    return(arr[0] * (-1));
  }
}
