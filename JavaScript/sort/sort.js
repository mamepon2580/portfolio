var lines = [];
var reader = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});
reader.on('line', (line) => {
  lines.push(line);
});
reader.on('close', () => {
  console.log(sortFunc(strArrToIntArrey(lines)));
});

//function
function strArrToIntArrey(arrey1){
  arrey2 = arrey1.map(Number);
  return(arrey2);
}

function sortFunc(arrey1){
  arrey2 = arrey1.sort(function(x,y){
          if( x < y ) return -1;
          if( x > y ) return 1;
          return 0;
  });
  return(arrey2);
}