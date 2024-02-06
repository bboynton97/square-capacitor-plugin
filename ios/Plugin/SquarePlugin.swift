import Foundation
import Capacitor
import SquareReaderSDK
import CoreBluetooth

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */

@objc(SquareReaderPlugin)
public class SquareReaderPlugin: CAPPlugin {
    //private let implementation = Square()
    var bluetoothManager: CBManager?

    func initialize(launchOptions: [UIApplication.LaunchOptionsKey : Any]) {
        SQRDReaderSDK.initialize(applicationLaunchOptions: launchOptions)
    }

    func requestBluetoothPermissions() {
        if bluetoothManager == nil ||
            bluetoothManager!.authorization == .notDetermined {

            // Initializing CBCentralManager results in a prompt asking the user
            // to grant access if the authorization status is `.notDetermined`.
            bluetoothManager = CBCentralManager()
        }
    }

    @objc func pluginTest(_ call: CAPPluginCall) {
            print("hit function")
            call.resolve(["value": "toost"])
        }

        @objc func isAuthorized(_ call: CAPPluginCall) {
            DispatchQueue.main.async {
                call.resolve([
                    "authorized": SQRDReaderSDK.shared.isAuthorized
                ])
            }
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
            //let amountMoney = SQRDMoney(amount: amountCents!)

            // Create parameters to customize the behavior of the checkout flow.
            //let params = SQRDCheckoutParameters(amountMoney: amountMoney)
    //        params.additionalPaymentTypes = [.]

            // Create a checkout controller and call present to start checkout flow.
    //        let checkoutController = SQRDCheckoutController(
    //            parameters: params,
    //            delegate: self
    //        )
    //        checkoutController.present(from: self)
        }


}

