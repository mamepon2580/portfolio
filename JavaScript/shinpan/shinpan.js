//shinpan.js
//100点
//--------IO処理--------
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
    play(lines)
  )
});
//関数
function play(arrIn){
  //
  board = {ball:0,strike:0};
  arrOut = [];
  //
  function ball(){
    if (board.ball + 1 == 4){
      board.ball++;
      arrOut.push("fourball!");
    }else{
      board.ball++;
      arrOut.push("ball!");
    }
  }
  //
  function strike(){
    if (board.strike + 1 == 3){
      board.strike++;
      arrOut.push("out!");
    }else{
      board.strike++;
      arrOut.push("strike!");
    }
  }
  //
  for(i = 1; i <= lines[0]; i++){
    if(arrIn[i] == "ball"){
      ball();
    }else if(arrIn[i] == "strike"){
      strike();
    }
  }
  return(arrOut.join('\n'));
}
