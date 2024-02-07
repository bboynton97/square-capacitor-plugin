import { WebPlugin } from '@capacitor/core';
import type { ISquareReaderSDK2Plugin } from './definitions';
export declare class SquareReaderSDK2Plugin extends WebPlugin implements ISquareReaderSDK2Plugin {
    authorizeReaderSdk(options: {
        auth_code: string;
    }): Promise<{
        success: boolean;
    }>;
    isAuthorized(): Promise<{
        authorized: boolean;
    }>;
    startCheckout(options: {
        amount: number;
    }): Promise<{
        success: boolean;
    }>;
    pluginTest(): Promise<{
        value: string;
    }>;
}
