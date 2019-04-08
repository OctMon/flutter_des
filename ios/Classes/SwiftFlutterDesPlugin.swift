import Flutter
import UIKit
import CommonCrypto

public class SwiftFlutterDesPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_des", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterDesPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [Any] ?? []
        guard arguments.count > 2 else {
            result(nil)
            return
        }
        let key = arguments[1] as? String ?? ""
        let iv = arguments[2] as? String ?? ""
        switch call.method {
        case "encrypt":
            encrypt(string: arguments[0] as? String ?? "", key: key, iv: iv, result: result)
        case "encryptToHex":
            encryptToHex(string: arguments[0] as? String ?? "", key: key, iv: iv, result: result)
        case "decrypt":
            if let data = arguments[0] as? FlutterStandardTypedData {
                decrypt(data: data.data, key: key, iv: iv, result: result)
            } else {
                result(nil)
            }
        case "decryptFromHex":
            decryptFromHex(string: arguments[0] as? String ?? "", key: key, iv: iv, result: result)
        default:
            result(nil)
            break
        }
    }
    
    func encryptToHex(string: String, key: String, iv: String, result: FlutterResult) {
        result(encrypt(string: string, key: key, iv: iv)?.toHexString)
    }
    
    func encrypt(string: String, key: String, iv: String, result: FlutterResult) {
        result(encrypt(string: string, key: key, iv: iv))
    }
    
    func encrypt(string: String, key: String, iv: String) -> Data? {
        return string.data(using: .utf8)?.crypt(operation: CCOperation(kCCEncrypt), key: key, iv: iv)
    }
    
    func decryptFromHex(string: String, key: String, iv: String, result: FlutterResult) {
        result(decrypt(data: string.hexToData, key: key, iv: iv))
    }
    
    func decrypt(data: Data, key: String, iv: String, result: FlutterResult) {
       result(decrypt(data: data, key: key, iv: iv))
    }
    
    func decrypt(data: Data, key: String, iv: String) -> String? {
        guard let data = data.crypt(operation: CCOperation(kCCDecrypt), key: key, iv: iv) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
}

private extension Data {
    
    func crypt(operation: CCOperation, key: String, iv: String) -> Data? {
        let keyLength = Int(kCCKeySizeDES)
        let dataLength = count
        let cryptLength = Int(dataLength + kCCBlockSizeDES)
        let cryptPointer = UnsafeMutablePointer<UInt8>.allocate(capacity: cryptLength)
        let numBytesEncrypted = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        numBytesEncrypted.initialize(to: 0)
        
        var keyBytes: UnsafePointer<Int8>?
        key.data(using: .utf8)?.withUnsafeBytes { (bytes: UnsafePointer<Int8>) -> Void in
            keyBytes = bytes
        }
        
        var dataBytes: UnsafePointer<Int8>?
        self.withUnsafeBytes { (bytes: UnsafePointer<CChar>) -> Void in
            dataBytes = bytes
        }
        
        let cryptStatus = CCCrypt(operation, CCAlgorithm(kCCAlgorithmDES), CCOptions(kCCOptionPKCS7Padding), keyBytes, keyLength, iv, dataBytes, dataLength, cryptPointer, cryptLength, numBytesEncrypted)
        
        if CCStatus(cryptStatus) == CCStatus(kCCSuccess) {
            let len = Int(numBytesEncrypted.pointee)
            let data = Data(bytes: cryptPointer, count: len)
            numBytesEncrypted.deallocate()
            return data
        } else {
            numBytesEncrypted.deallocate()
            cryptPointer.deallocate()
            return nil
        }
    }
    
}

private extension Data {
    
    var toHexString: String {
        return toHexString()
    }
    
    var toHexLowercasedString: String {
        return toHexString(isLowercased: true)
    }
    
    private func toHexString(isLowercased: Bool = false) -> String {
        return map { String(format: "%02\(isLowercased ? "x" : "X")", $0) }.joined(separator: "")
    }
    
}

private extension String {
    
    /// 16进制字符串转为Data
    var hexToData: Data {
        let bytes = hexToBytes
        return Data(bytes: bytes)
    }
    
    /// 16进制字符串转为 [UInt8]
    var hexToBytes: [UInt8] {
        assert(count % 2 == 0, "输入字符串格式不对，8位代表一个字符")
        var bytes = [UInt8]()
        var sum = 0
        // 整形 utf8 编码范围
        let intRange = 48...57
        // 小写 a~f 的 utf8 的编码范围
        let lowercaseRange = 97...102
        // 大写 A~F 的 utf8 的编码范围
        let uppercasedRange = 65...70
        for (index, c) in utf8CString.enumerated() {
            var intC = Int(c.byteSwapped)
            if intC == 0 {
                break
            } else if intRange.contains(intC) {
                intC -= 48
            } else if lowercaseRange.contains(intC) {
                intC -= 87
            } else if uppercasedRange.contains(intC) {
                intC -= 55
            } else {
                assertionFailure("输入字符串格式不对，每个字符都需要在0~9，a~f，A~F范围内")
            }
            sum = sum * 16 + intC
            // 每两个十六进制字母代表8位，即一个字节
            if index % 2 != 0 {
                bytes.append(UInt8(sum))
                sum = 0
            }
        }
        return bytes
    }
    
}
