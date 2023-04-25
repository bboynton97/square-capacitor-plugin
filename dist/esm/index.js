import { registerPlugin } from '@capacitor/core';
const Square = registerPlugin('Square', {
    web: () => import('./web').then(m => new m.SquareWeb()),
});
export * from './definitions';
export { Square };
//# sourceMappingURL=index.js.map