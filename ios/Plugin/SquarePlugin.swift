import Foundation
import Capacitor
import ReaderSDK2
import CoreBluetooth
import CoreLocation

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */

@objc(SquareReaderSDK2Plugin)
public class SquareReaderPlugin: CAPPlugin {
    //private let implementation = Square()
    var bluetoothManager: CBManager?
    private var pairingHandle: PairingHandle?
    var readerStatus: String = "disconnected"
    var readerError: String = ""

    @objc  func initialize(_ call: CAPPluginCall) {
        print("~~ initializing ~~")
        let appId = call.getString("app_id") ?? ""
        DispatchQueue.main.async {
            ReaderSDK.initialize(
                applicationLaunchOptions: nil,
                //                squareApplicationID: "sq0idp-7-D3qCLWQqCixebh8mfV3Q"
                squareApplicationID: appId
            )
        }
        self.requestLocationPermission()
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
    
    private lazy var locationManager = CLLocationManager()

       func requestLocationPermission() {
           switch CLLocationManager.authorizationStatus() {
           case .notDetermined:
               locationManager.requestWhenInUseAuthorization()
           case .restricted, .denied:
               print("Show UI directing the user to the iOS Settings app")
           case .authorizedAlways, .authorizedWhenInUse:
               print("Location services have already been authorized.")
           @unknown default:
               fatalError()
           }
       }

    @objc func pluginTest(_ call: CAPPluginCall) {
        print("📱 hit function")
        call.resolve(["value": "toost"])
    }

    func getTopViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }

    @objc func authorizeReaderSdk(_ call: CAPPluginCall) {
        let authCode = call.getString("auth_code") ?? ""
        let locationId = call.getString("loc_id") ?? ""
        guard ReaderSDK.shared.authorizationManager.state == .notAuthorized else {
            print("📱 Already authorized")
            return call.resolve(["success": true])
        }
        
        ReaderSDK.shared.authorizationManager.authorize(
            withAccessToken: authCode,
            locationID: locationId) { error in
                guard let authError = error else {
                    print("📱 Reader SDK successfully authorized.")
                    return call.resolve(["success": true])
                }

                // Handle auth error
                print("📱 ReaderSDK authorization error: \(authError.localizedDescription)")
                call.resolve(["success": false])
        }
    }
    
    @objc func identify(_ call: CAPPluginCall) {
        let readers = ReaderSDK.shared.readerManager.readers
        if (readers.count > 0) {
            let reader = readers[0]
            ReaderSDK.shared.readerManager.blink(reader)
        }
         // `ledController` controls the LEDs on the Reader.
         // `nil` if the reader doesn't have LEDs.
    }
    
    @objc func connectedReadersCount(_ call: CAPPluginCall) {
        // You can access all connected readers via
        // `ReaderSDK.shared.readerManager.readers`
        print(ReaderSDK.shared.readerManager.readers)
        call.resolve(["readers":ReaderSDK.shared.readerManager.readers.count])
    }

    @objc func startCheckout(_ call: CAPPluginCall) {
        let amountCents = call.getInt("amount")
        if amountCents == nil {
            return call.reject("Missing amount")
        }
    }

    @objc func startPairingReader(_ call: CAPPluginCall) {
        // TODO: this is being called but then the callback handlers from the ReaderDelegate are not being called
        print("📱 startPairingReader")
        self.requestBluetoothPermissions()
        self.requestLocationPermission()
        pairingHandle = ReaderSDK.shared.readerManager.startPairing(with: self)
        call.resolve()
    }

    @objc func stopPairingReader(_ call: CAPPluginCall) {
        pairingHandle?.stop()
        call.resolve()
    }
    
    @objc func getReaderStatus(_ call: CAPPluginCall) {
        call.resolve(["status":readerStatus, "error":readerError])
    }
    
    func makeTheme() -> Theme {
       let theme = Theme()
       theme.presentationStyle = .automatic
       theme.backgroundColor = .black
       theme.titleColor = .white
       theme.subtitleColor = .white
       return theme
    }
    
    private var paymentHandle: PaymentHandle?
    
    @objc func startPayment(_ call: CAPPluginCall) {
        let money = UInt(call.getInt("money") ?? 0)
        let orderId = call.getString("orderId") ?? ""
        print("Paying order ID \(orderId)")
    
        let paymentParams = PaymentParameters(
            idempotencyKey: UUID().uuidString,
            amountMoney: Money(amount: money, currency: .USD)
        )

        paymentParams.orderID = orderId
        paymentParams.referenceID = UUID().uuidString
        
        DispatchQueue.main.async {
            self.paymentHandle = ReaderSDK.shared.paymentManager.startPayment(
                paymentParams,
                theme: self.makeTheme(),
                from: self.getTopViewController()!,
                delegate: self
            )
        }
    }
}

extension SquareReaderPlugin: ReaderPairingDelegate {
    public func readerPairingDidBegin() {
        print("📱 !! pairing did begin")
        readerStatus = "searching"
    }
    
    public func readerPairingDidSucceed() {
        print("📱 !! paired!")
        readerStatus = "connected"
    }
    
    public func readerPairingDidFailWithError(_ error: Error) {
        print("📱 failed to pair")
        readerStatus = "failed"
        readerError = error.localizedDescription
    }
}

extension SquareReaderPlugin: PaymentManagerDelegate {
    public func paymentManager(
        _ paymentManager: PaymentManager, willFinish payment: Payment) {

        print("""
        willFinish
        ID: \(payment.id)
        Amount: \(payment.amountMoney.amount)
        Currency: \(payment.amountMoney.currency.currencyCode)
        Card Brand: \(payment.cardDetails?.card?.cardBrand.description)
        Last Four: \(payment.cardDetails?.card?.last4 ?? "N/A")
        Entry Method: \(payment.cardDetails?.entryMethod.description)
        """)
    }

    public func paymentManager(
        _ paymentManager: PaymentManager, didFinish payment: Payment) {

        print("""
        didFinish
        ID: \(payment.id)
        Amount: \(payment.amountMoney.amount)
        Currency: \(payment.amountMoney.currency.currencyCode)
        Card Brand: \(payment.cardDetails?.card?.cardBrand.description)
        Last Four: \(payment.cardDetails?.card?.last4 ?? "N/A")
        Entry Method: \(payment.cardDetails?.entryMethod.description)
        """)
    }

    public func paymentManager(
        _ paymentManager: PaymentManager, didStart payment: Payment) {


        print("""
        didStart
        ID: \(payment.id)
        Amount: \(payment.amountMoney.amount)
        Currency: \(payment.amountMoney.currency.currencyCode)
        Card Brand: \(payment.cardDetails?.card?.cardBrand.description)
        Last Four: \(payment.cardDetails?.card?.last4 ?? "N/A")
        Entry Method: \(payment.cardDetails?.entryMethod.description)
        """)
    }
    
    public func paymentManager(_ paymentManager: PaymentManager, didFail payment: Payment, withError error: Error) {
        print("""
        didFail withError
        Payment error: \(error.localizedDescription)
           ID: \(payment.id)
           Amount: \(payment.amountMoney.amount)
           Currency: \(payment.amountMoney.currency.currencyCode)
           Card Brand: \(payment.cardDetails?.card?.cardBrand.description)
           Last Four: \(payment.cardDetails?.card?.last4 ?? "N/A")
           Entry Method: \(payment.cardDetails?.entryMethod.description)
        """)
    }
    
    public func paymentManager(_ paymentManager: PaymentManager, willCancel payment: Payment) {
        print("""
        willCancel
        Payment will be canceled!
           ID: \(payment.id)
           Amount: \(payment.amountMoney.amount)
           Currency: \(payment.amountMoney.currency.currencyCode)
           Card Brand: \(payment.cardDetails?.card?.cardBrand.description)
           Last Four: \(payment.cardDetails?.card?.last4 ?? "N/A")
           Entry Method: \(payment.cardDetails?.entryMethod.description)
        """)
    }
    
    public func paymentManager(_ paymentManager: PaymentManager, didCancel payment: Payment) {
        print("""
        didCancel
        Payment canceled!
           ID: \(payment.id)
           Amount: \(payment.amountMoney.amount)
           Currency: \(payment.amountMoney.currency.currencyCode)
           Card Brand: \(payment.cardDetails?.card?.cardBrand.description)
           Last Four: \(payment.cardDetails?.card?.last4 ?? "N/A")
           Entry Method: \(payment.cardDetails?.entryMethod.description)
        """)
    }
}
