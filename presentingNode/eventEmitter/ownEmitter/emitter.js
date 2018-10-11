// building an emitter from scratch

function Emitter() { // constructor function
    this.events = {};
}

// registering the listeners; many listeners can be attached to a single type of event
Emitter.prototype.on = function on(type, listener) { // creates a listener that will respond to the event
    this.events[type] = this.events[type] || [];
    this.events[type].push(listener); // each listener is a function stored in an array for each type of event
}

//trigging the event
Emitter.prototype.emit = function emit(type) { // creates an event
  if (this.events[type]) {
      this.events[type].forEach( listener => {
          listener(); // invoke each listener for one type of event
      });
  }
}
module.exports = Emitter; // export the constructor -> can build as many emitters that I need