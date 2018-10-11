// INHERITING FROM THE EVENT EMITTER
// several ways to inherit in JS
// function prototype
// class extends
// Object.create
//
// Inside NODE, you can also use an other way
// from the UTIL module that is core to NODE
// It uses a function that take two parameters
// first is the function constructor that you need to extend
// second is the function constructor that you need to access
// the function constructor prototype will point to the super constructor function prototype to acces its properties

var EventEmitter = require('events');
var util = require('util');

function Car(brand) {
    EventEmitter.call(this); // ensures that if the constructor needs to create properties directly on the object constructed, it could process
    this.brand = brand;
}

util.inherits(Car, EventEmitter); // Each object constructed  by the constructor function Car will also have access to the methods of EventEmitter

Car.prototype.start = function start(method) {
    console.log(`${method} and...`);
    this.emit('start', method);
}

var myCar = new Car('Toyota');

myCar.on('start', function () {
    console.log('Vrooom Vroom!!!');
});

myCar.start('Turn the key');
myCar.start('Push the button');


// example to illustrate the line 18
function Dog() {
    this.numberPaws = 4;
    this.tail = true;
}

Dog.prototype.bark = function bark() {
    console.log('Whaff Whaff');
}

function BraqueDog() {
    Dog.call(this); // properties that are defined for each new Dog are also defined onto each BraqueDog
    this.color = 'brown';
}

BraqueDog.prototype.hunt = function () {
    console.log('Okay, I am searching for game.');
}

util.inherits(BraqueDog, Dog);


var myDog = new BraqueDog();
myDog.bark(); // 'Whaff Whaff'
console.log(myDog.numberPaws); // 4