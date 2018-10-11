'use strict';

var EventEmitter = require('events');

module.exports = class Car extends EventEmitter {
    constructor(brand) {
        this.brand = brand
    }

    start(method) {
        console.log(`${method} and...`);
        this.emit('start', method);
    }
}