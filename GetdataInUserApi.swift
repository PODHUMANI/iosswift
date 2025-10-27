import Foundation
import CommonCrypto

func aesEncrypt(plainText: String, key: String, iv: String) -> String? {
    guard let data = plainText.data(using: .utf8),
          let keyData = key.data(using: .utf8),
          let ivData = iv.data(using: .utf8) else { return nil }
    
    let bufferSize = data.count + kCCBlockSizeAES128
    var buffer = [UInt8](repeating: 0, count: bufferSize)
    var numBytesEncrypted = 0
    
    let cryptStatus = CCCrypt(CCOperation(kCCEncrypt),
                               CCAlgorithm(kCCAlgorithmAES128),
                               CCOptions(kCCOptionPKCS7Padding),
                               (keyData as NSData).bytes, kCCKeySizeAES128,
                               (ivData as NSData).bytes,
                               (data as NSData).bytes, data.count,
                               &buffer, bufferSize,
                               &numBytesEncrypted)
    
    if cryptStatus == CCCryptorStatus(kCCSuccess) {
        let encryptedData = Data(bytes: buffer, count: numBytesEncrypted)
        return encryptedData.base64EncodedString()
    } else {
        print("Encryption failed")
        return nil
    }
}
import Alamofire

class InsertViewModel {
    
    func sendEncryptedData(params: [String: Any]) {
        // 1️⃣ Convert params → JSON string
        guard let jsonData = try? JSONSerialization.data(withJSONObject: params, options: []),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            print("Invalid JSON")
            return
        }
        
        // 2️⃣ Generate IV (random 16 bytes)
        let iv = "1234567890123456" // Demo (normally random)
        let key = "mysecretkey12345" // 16 chars = AES128 key size
        
        // 3️⃣ Encrypt
        guard let encryptedText = aesEncrypt(plainText: jsonString, key: key, iv: iv) else {
            print("Encryption failed")
            return
        }
        
        // 4️⃣ Prepare final body
        let body: [String: Any] = [
            "iv": iv,
            "data": encryptedText
        ]
        
        // 5️⃣ Send using Alamofire
        AF.request("YOUR_API_URL",
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let json):
                print("✅ Success:", json)
            case .failure(let err):
                print("❌ Error:", err)
            }
        }
    }
}

struct InsertView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var age = ""
    
    let vm = InsertViewModel()
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
            TextField("Age", text: $age)
            
            Button("Encrypt & Send") {
                let params: [String: Any] = [
                    "table_name": "raja_table",
                    "id": 8,
                    "coloumns_name": ["name","email","age"],
                    "values": [
                        "name": name,
                        "email": email,
                        "age": Int(age) ?? 0
                    ]
                ]
                
                vm.sendEncryptedData(params: params)
            }
        }
        .padding()
    }
}
