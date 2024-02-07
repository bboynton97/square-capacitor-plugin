import { registerPlugin } from '@capacitor/core';
const SquareReaderSDK2Plugin = registerPlugin('SquareReaderSDK2Plugin', {
    web: () => import('./web').then(m => new m.SquareReaderSDK2Plugin()),
});
export * from './definitions';
export { SquareReaderSDK2Plugin };
//# sourceMappingURL=index.js.map