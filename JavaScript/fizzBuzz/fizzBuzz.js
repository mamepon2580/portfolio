var lines = [];
var reader = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});
reader.on('line', (line) => {
  lines.push(line);
});
reader.on('close', () => {
  console.log(makeArrey(Number(lines[0])).map(fizzBuzz));
});

//function
//1..nの配列作成
function makeArrey(n){
  arrey = []
  for (i = 0;i < n; i++){
    arrey[i] = i + 1
  }
  return (arrey)
}
//FizzBuzz判定
function fizzBuzz(n){
  if(n % 15 === 0){
    return("FizzBuzz");
  }else if(n % 5 === 0){
    return("Buzz");
  }else if (n % 3 === 0){
    return("Fizz");
  }else {
    return(n);
  }
}