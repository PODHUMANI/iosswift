class Solution {
    func numDecodings(_ s: String) -> Int {
        if s.isEmpty { return 0 }
        
        let chars = Array(s)
        
        // If first character is 0 → invalid
        if chars[0] == "0" { return 0 }
        
        var prev2 = 1   // dp[0]
        var prev1 = 1   // dp[1]
        
        for i in 1..<chars.count {
            var current = 0
            
            // Case 1: Single digit valid
            if chars[i] != "0" {
                current += prev1
            }
            
            // Case 2: Two digit valid
            let twoDigit = Int(String(chars[i-1]) + String(chars[i]))!
            if twoDigit >= 10 && twoDigit <= 26 {
                current += prev2
            }
            
            prev2 = prev1
            prev1 = current
        }
        
        return prev1
    }
}
