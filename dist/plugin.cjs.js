'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const Square = core.registerPlugin('Square', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.SquareWeb()),
});

class SquareWeb extends core.WebPlugin {
    // @ts-ignore
    authorizeReaderSdk(options) {
        throw new Error("Web not supported");
    }
    isAuthNeeded() {
        throw new Error("Web not supported");
    }
    // @ts-ignore
    startCheckout(options) {
        throw new Error("Web not supported");
    }
    pluginTest() {
        return Promise.resolve({ value: "toost" });
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    SquareWeb: SquareWeb
});

exports.Square = Square;
//# sourceMappingURL=plugin.cjs.js.map
