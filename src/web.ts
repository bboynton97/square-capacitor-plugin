import { WebPlugin } from '@capacitor/core';

import type { SquarePlugin } from './definitions';

export class SquareWeb extends WebPlugin implements SquarePlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
