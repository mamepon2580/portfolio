//wine.js
//D055
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
  console.log(
    connect(lines[0])
  );
});
//--------main関数--------
function connect(strIn){
  strOut = "Best in " + strIn;
  return(strOut);
}
