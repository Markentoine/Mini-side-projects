var Emitter = require('events'); // require the build-in emitter in Node
// it returns a constructor function

var configEvents = require('./congif').events; // removes the magic string 'trigger'
// remove these magic strings helps us to debug, and avoid typos to become bug difficult to find

var myEmitter = new Emitter();

myEmitter.on(configEvents.TRIGGER, function () { // first listener
    console.log('As you trigged me.')
});

myEmitter.on(configEvents.TRIGGER, function () { // second listener
    console.log('I can respond!')
});

myEmitter.emit(configEvents.TRIGGER);s

// elegant and simple way to control flow
// Event Emitter in Node is build on the same idea