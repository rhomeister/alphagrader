const readline = require('readline');

let result = 0;
let i = 0;

// Create interface of readline
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Listen for stdin
rl.on('line', (input) => {

  i++;
  result += parseInt(input);

  // After receiving two numbers
  if (i >= 2) {
    console.log(result);
    // Stop listening
    rl.close();
  }
});
