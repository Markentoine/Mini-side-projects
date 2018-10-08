function UseThis() {
    this.use = 'Use That';
};

module.exports = new useThis;

//-------MAIN FILE-----//

const useThis = require();
useThis.use() // Use That

const useAlso = require()
useThis.use = 'Use also that';
useAlso.use() // Use also that

// Node cache the value of the first evaluation of require and just give a reference
// for the other invocations

// in case I want a new object

module.exports = Usethis; // this time I give the constructor itself

const UseAlso = require();
const useTheConstructor = new UseAlso();
useTheConstructor.use() // Use That

// quite popular pattern to avoid exposition of certain datas
// the revealing module pattern : exposing only the methods and the properties you want via
// the returned object

var data = 'Private';
function expose() {
    return data;
}

module.exports = expose; // by this way I can keep private certain datas