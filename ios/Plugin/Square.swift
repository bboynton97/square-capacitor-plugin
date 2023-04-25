import Foundation

@objc public class Square: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
