const useThis = function () {
    return 'I use this.'
};

module.exports.useThis = useThis;

//------MAIN FILE------//

const useThis = require().useThis;