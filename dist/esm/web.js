import { WebPlugin } from '@capacitor/core';
export class SquareReaderSDK2Plugin extends WebPlugin {
    // @ts-ignore
    initialize(options) {
        throw new Error('Web not supported');
    }
    // @ts-ignore
    authorizeReaderSdk(options) {
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
//# sourceMappingURL=web.js.map