export interface SquarePlugin {
    pluginTest(): Promise<{
        value: string;
    }>;
    isAuthNeeded(): Promise<{
        authorized: boolean;
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
}
