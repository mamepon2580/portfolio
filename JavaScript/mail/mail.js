//mail.js
//D010
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
     makeMail(lines[0],lines[1])
  )
});
//---------main関数---------
//
function makeMail(local,domain){
  let mail = local + "@" + domain;
  return(mail);
}
