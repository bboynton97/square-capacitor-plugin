import { WebPlugin } from '@capacitor/core';
import type { ISquareReaderSDK2Plugin } from './definitions';
export declare class SquareReaderSDK2Plugin extends WebPlugin implements ISquareReaderSDK2Plugin {
    initialize(options: {
        app_id: string;
    }): Promise<{
        success: boolean;
    }>;
    authorizeReaderSdk(options: {
        auth_code: string;
    }): Promise<{
        success: boolean;
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
