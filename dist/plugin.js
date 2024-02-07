var capacitorSquare = (function (exports, core) {
    'use strict';

    const SquareReaderSDK2Plugin$1 = core.registerPlugin('SquareReaderSDK2Plugin', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.SquareReaderSDK2Plugin()),
    });

    class SquareReaderSDK2Plugin extends core.WebPlugin {
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
        SquareReaderSDK2Plugin: SquareReaderSDK2Plugin
    });

    exports.SquareReaderSDK2Plugin = SquareReaderSDK2Plugin$1;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
