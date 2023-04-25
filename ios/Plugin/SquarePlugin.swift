import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(SquarePlugin)
public class SquarePlugin: CAPPlugin {
    private let implementation = Square()

    @objc func pluginTest(_ call: CAPPluginCall) {
            print("hit function")
            call.resolve(["value": "toost"])
        }

        @objc func isAuthNeeded(_ call: CAPPluginCall) {
            call.resolve([
                "authorized": SQRDReaderSDK.shared.isAuthorized
            ])
        }

        @objc func authorizeReaderSdk(_ call: CAPPluginCall) {
            let authCode = call.getString("auth_code") ?? ""
            SQRDReaderSDK.shared.authorize(withCode: authCode) { _, error in

                if let authError = error {
                    // Handle the error
                    print(authError)
                    return call.resolve(["success": false])
                } else {
                    // Proceed to the main application interface.
                    return call.resolve(["success": true])
                }
            }
        }

        @objc func startCheckout(_ call: CAPPluginCall) {
            let amountCents = call.getInt("amount")
            if amountCents == nil {
                return call.reject("Missing amount")
            }

            // Create a money amount in the currency of the authorized Square account
            let amountMoney = SQRDMoney(amount: amountCents!)

            // Create parameters to customize the behavior of the checkout flow.
            let params = SQRDCheckoutParameters(amountMoney: amountMoney)
    //        params.additionalPaymentTypes = [.]

            // Create a checkout controller and call present to start checkout flow.
    //        let checkoutController = SQRDCheckoutController(
    //            parameters: params,
    //            delegate: self
    //        )
    //        checkoutController.present(from: self)
        }
}
