// Exist also some native modules : see node.js doc api

// some are global and can be used immediately like `console`

// others must be required in the code, example `utilities`

var util = require('util'); // no location needed here; location just for custom modules
// now I can use format eg

var name = 'Jerome';
var greeting = util.format('Bonjour %s', name); 
console.log(greeting); // "Bonjour Jerome"
util.log(greeting); // 4 Oct 08:47:19 - Bonjour Jerome --> add a timestamp