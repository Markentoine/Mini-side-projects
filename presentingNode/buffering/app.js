var fs = require('fs');

var greet = fs.readFileSync(__dirname + '/greet.txt', 'utf8'); // encoding protocol is necessary to produce a string readable instead of a buffer
                                                                // with binaries
console.log(`${greet} : synchronously`); // Hello World! : synchronously

const callback = (error, result) => console.log(`${result} : asynchronously`); // see the Error-First Callback pattern here
var greet2 = fs.readFile(__dirname + '/greet.txt', 'utf8', callback);

console.log('I arrive earlier than expected no?');
// the problem here could be that this buffer is stored in the heap memory and so with multiple requests or big files, in can produce a large amount
// of memory consumed

