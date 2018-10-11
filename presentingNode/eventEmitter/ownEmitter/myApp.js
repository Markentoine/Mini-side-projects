var Emitter = require('./emitter'); // return the module.exports object that points to the constructor function

var myEmitter = new Emitter(); // create a new object which proto point to the constructor function protype

myEmitter.on('trigger', function () { // so we can now use the methods attached to the constructor function on the object created
    console.log('As you trigged me.') // first listener
});

myEmitter.on('trigger', function () { // second listener
    console.log('I can respond!')
});

myEmitter.emit('trigger'); // emitter that will execute the two listeners

// elegant and simple way to control flow
// Event Emitter in Node is build on the same idea