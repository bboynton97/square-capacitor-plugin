import { registerPlugin } from '@capacitor/core';

import type { SquarePlugin } from './definitions';

const Square = registerPlugin<SquarePlugin>('Square', {
  web: () => import('./web').then(m => new m.SquareWeb()),
});

export * from './definitions';
export { Square };
