const tool = require('./tools');
const verb = require('./verbs.json'); // require returns the object from the json file

console.log('Now, I can ' + verb.hammer + tool.hammer());
console.log('Now, I can ' + verb.screwdriver + tool.screwdriver());
console.log('Now, I can ' + verb.clamp + tool.clamp());