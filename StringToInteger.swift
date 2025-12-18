class Solution {
    func myAtoi(_ s: String) -> Int {
        let chars = Array(s)
        let n = chars.count
        var i = 0
        
        // 1. Skip leading spaces
        while i < n && chars[i] == " " {
            i += 1
        }
        
        // 2. Sign
        var sign = 1
        if i < n && (chars[i] == "-" || chars[i] == "+") {
            sign = chars[i] == "-" ? -1 : 1
            i += 1
        }
        
        // 3. Convert digits
        var result = 0
        while i < n, let digit = chars[i].wholeNumberValue {
            
            // 4. Overflow check
            if result > Int(Int32.max) / 10 ||
               (result == Int(Int32.max) / 10 && digit > 7) {
                return sign == 1 ? Int(Int32.max) : Int(Int32.min)
            }
            
            result = result * 10 + digit
            i += 1
        }
        
        return result * sign
    }
}
