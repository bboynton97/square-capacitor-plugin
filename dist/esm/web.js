import { WebPlugin } from '@capacitor/core';
export class SquareWeb extends WebPlugin {
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
//# sourceMappingURL=web.js.map