import CryptoKit

func encryptData(message: String, keyString: String) -> Data? {
    let key = SymmetricKey(data: keyString.data(using: .utf8)!)
    let sealedBox = try? AES.GCM.seal(message.data(using: .utf8)!, using: key)
    return sealedBox?.combined
}

func decryptData(encryptedData: Data, keyString: String) -> String? {
    let key = SymmetricKey(data: keyString.data(using: .utf8)!)
    if let sealedBox = try? AES.GCM.SealedBox(combined: encryptedData),
       let decryptedData = try? AES.GCM.open(sealedBox, using: key) {
        return String(data: decryptedData, encoding: .utf8)
    }
    return nil
}

// ✅ Usage
let secretKey = "1234567890123456"  // 16 bytes key
let text = "Hello Swift!"

if let encrypted = encryptData(message: text, keyString: secretKey) {
    print("🔒 Encrypted:", encrypted.base64EncodedString())
    
    if let decrypted = decryptData(encryptedData: encrypted, keyString: secretKey) {
        print("🔑 Decrypted:", decrypted)
    }
}
