//kamakura.
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
    volume(lines[0].split(" ").map(Number))
  )
});
//---------main関数---------
function volume(arr){
  int = (arr[0] * arr[0] * arr[0]) - (arr[1] * arr[1] * arr[1]);
  return(int);
}
