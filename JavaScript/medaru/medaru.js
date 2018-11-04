var arrIn = [];
var reader = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});
reader.on('line', (line) => {
  arrIn.push(line)
});
reader.on('close', () => {
  console.log(
    makeArr(arrIn)
  )
});

//
function makeArr(arrIn){
  arrOut = [];
  arrOut[0] = "Gold " + arrIn[0];
  arrOut[1] = "Silver " + arrIn[1];
  arrOut[2] = "Bronze " + arrIn[2];
  return(arrOut.join('\n'));
}
