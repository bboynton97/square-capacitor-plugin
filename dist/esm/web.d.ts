import { WebPlugin } from '@capacitor/core';
import type { SquarePlugin } from './definitions';
export declare class SquareWeb extends WebPlugin implements SquarePlugin {
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
