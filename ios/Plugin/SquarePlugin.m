#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(SquareReaderSDK2Plugin, "SquareReaderSDK2Plugin",
           CAP_PLUGIN_METHOD(pluginTest, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(initialize, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(authorizeReaderSdk, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(startCheckout, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(startPairingReader, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(stopPairingReader, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getReaderStatus, CAPPluginReturnPromise);
)
