func aesEncrypt(plainText: String, key: String, iv: Data){
    guard let dataToEncrypt = plainText.data(using: .utf8),
          let keyData = key.data(using: .utf8) else { return nil }
    
    let cryptLength = size_t(dataToEncrypt.count + kCCBlockSizeAES128)
    var cryptData = Data(count: cryptLength)
    
    var bytesEncrypted = 0
    let status = cryptData.withUnsafeMutableBytes { cryptBytes in
        dataToEncrypt.withUnsafeBytes { dataBytes in
            iv.withUnsafeBytes { ivBytes in
                keyData.withUnsafeBytes { keyBytes in
                    CCCrypt(CCOperation(kCCEncrypt),
                            CCAlgorithm(kCCAlgorithmAES),
                            CCOptions(kCCOptionPKCS7Padding),
                            keyBytes.baseAddress, keyData.count,
                            ivBytes.baseAddress,
                            dataBytes.baseAddress, dataToEncrypt.count,
                            cryptBytes.baseAddress, cryptLength,
                            &bytesEncrypted)
                }
            }
        }
    }
    
    guard status == kCCSuccess else { return nil }
    cryptData.removeSubrange(bytesEncrypted..<cryptData.count)
    return base64URLEncode(cryptData)
}
