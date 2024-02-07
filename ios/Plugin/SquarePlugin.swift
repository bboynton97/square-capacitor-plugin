import Foundation
import Capacitor
import ReaderSDK2
import CoreBluetooth

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */

@objc(SquareReaderSDK2Plugin)
public class SquareReaderPlugin: CAPPlugin {
    //private let implementation = Square()
    var bluetoothManager: CBManager?

    @objc  func initialize(_ call: CAPPluginCall) {
        let appId = call.getString("app_id") ?? ""
        DispatchQueue.main.async {
            ReaderSDK.initialize(
                applicationLaunchOptions: nil,
                //                squareApplicationID: "sq0idp-7-D3qCLWQqCixebh8mfV3Q"
                squareApplicationID: appId
            )
        }
        call.resolve(["success": true])
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

    @objc func authorizeReaderSdk(_ call: CAPPluginCall) {
        let authCode = call.getString("auth_code") ?? ""
        let locationId = call.getString("loc_id") ?? ""
        guard ReaderSDK.shared.authorizationManager.state == .notAuthorized else {
            return
        }
        
        ReaderSDK.shared.authorizationManager.authorize(
            withAccessToken: authCode,
            locationID: locationId) { error in
                guard let authError = error else {
                    print("Reader SDK successfully authorized.")
                    return
                }

                // Handle auth error
                print("error: \(authError.localizedDescription)")
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

