import { WebPlugin } from '@capacitor/core';

import type { SquarePlugin } from './definitions';

export class SquareWeb extends WebPlugin implements SquarePlugin {

  // @ts-ignore
  authorizeReaderSdk(options: { auth_code: string }): Promise<{ success: boolean }> {
    throw new Error("Web not supported")
  }

  isAuthNeeded(): Promise<{ authorized: boolean }> {
    throw new Error("Web not supported")
  }

  // @ts-ignore
  startCheckout(options: { amount: number }): Promise<{ success: boolean }> {
    throw new Error("Web not supported")
  }

  pluginTest(): Promise<{ value: string }> {
    return Promise.resolve({value: "toost"});
  }
}
