var Emitter = require('./emitter');

var myEmitter = new Emitter();

myEmitter.on('trigger', function () {
    console.log('As you trigged me.')
});

myEmitter.on('trigger', function () {
    console.log('I can respond!')
});

myEmitter.emit('trigger');

// elegant and simple way to control flow
// Event Emitter in Node is build on the same idea