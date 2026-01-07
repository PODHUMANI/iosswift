class Solution {
    func addBinary(_ a: String, _ b: String) -> String {

        let aArr = Array(a)
        let bArr = Array(b)

        var i = aArr.count - 1
        var j = bArr.count - 1
        var carry = 0
        var result = ""

        while i >= 0 || j >= 0 || carry > 0 {
            var sum = carry

            if i >= 0 {
                sum += Int(String(aArr[i]))!
                i -= 1
            }

            if j >= 0 {
                sum += Int(String(bArr[j]))!
                j -= 1
            }

            result = String(sum % 2) + result
            carry = sum / 2
        }

        return result
    }
}
