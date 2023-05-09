var capacitorSquare = (function (exports, core) {
    'use strict';

    const Square = core.registerPlugin('Square', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.SquareWeb()),
    });

    class SquareWeb extends core.WebPlugin {
        // @ts-ignore
        authorizeReaderSdk(options) {
            throw new Error("Web not supported");
        }
        isAuthorized() {
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

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
