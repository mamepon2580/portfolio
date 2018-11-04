//mojiretu.js
//C016
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
    translation(lines[0])
  );
});
//--------IO関数--------

//--------main関数--------
function translation(strIn){
  charArr = strIn.split('');
  charArrOut = [];
  for(i = 0; i < charArr.length; i++){
    switch (charArr[i]) {
      case "A":
        charArrOut.push("4");
        break;
      case "E":
        charArrOut.push("3");
        break;
      case "G":
        charArrOut.push("6");
        break;
      case "I":
        charArrOut.push("1");
        break;
      case "O":
        charArrOut.push("0");
        break;
      case "S":
        charArrOut.push("5");
        break;
      case "Z":
        charArrOut.push("2");
        break;
      default:
        charArrOut.push(charArr[i]);
        break;
    }
  }
  strOut = charArrOut.join("");
  return(strOut);
}
