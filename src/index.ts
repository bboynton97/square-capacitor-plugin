import { registerPlugin } from '@capacitor/core';

import type { ISquareReaderSDK2Plugin } from './definitions';

const SquareReaderSDK2Plugin = registerPlugin<ISquareReaderSDK2Plugin>('SquareReaderSDK2Plugin', {
  web: () => import('./web').then(m => new m.SquareReaderSDK2Plugin()),
});

export * from './definitions';
export { SquareReaderSDK2Plugin };
