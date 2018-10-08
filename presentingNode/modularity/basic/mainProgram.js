const useThis = function () {
    return 'I use this.'
};

console.log(useThis());
// require('./myModelu');

// if I execute the mainProgram. The output is:
// I use this.

// but I cannot invoke the method useThat directly
// If I invoke the function rigth now
//useThat();  // => not defined

// the code in the module is encapsulated.
// but it is possible...with module.exports
// Now...
const useThat = require('./myModelu');
useThat();
// I use this.
// I can also use that.

// now i can use the code that was inside the body of the useThat function in my module.
