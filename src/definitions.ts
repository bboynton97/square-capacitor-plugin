export interface ISquareReaderSDK2Plugin {
  initialize(options: {app_id: string}): Promise<{success: boolean}>;
  pluginTest(): Promise<{ value: string }>;
  authorizeReaderSdk(options: { auth_code: string, loc_id: string }): Promise<{ success: boolean }>;
  startCheckout(options: { amount: number }): Promise<{ success: boolean }>;
  startPairingReader(): Promise<void>;
  stopPairingReader(): Promise<void>;
  getReaderStatus(): Promise<{status: string, error: string}>;
}
