const useThat = function () {
    return 'I can also use that.';
}

console.log(useThat());

module.exports = useThat; //exposes the useThat method outside

// module.exports is just an empty object available on the module object that is created
// when we 'require'.
// Node wrap this code inside an IIFE that return the module.exports object