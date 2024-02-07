import { WebPlugin } from '@capacitor/core';

import type { ISquareReaderSDK2Plugin } from './definitions';

export class SquareReaderSDK2Plugin extends WebPlugin implements ISquareReaderSDK2Plugin {

  // @ts-ignore
  initialize(options: { app_id: string; }): Promise<{ success: boolean; }> {
    throw new Error('Web not supported');
  }

  // @ts-ignore
  authorizeReaderSdk(options: { auth_code: string }): Promise<{ success: boolean }> {
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
