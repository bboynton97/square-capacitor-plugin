export interface ISquareReaderSDK2Plugin {
    pluginTest(): Promise<{
        value: string;
    }>;
    isAuthorized(): Promise<{
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
