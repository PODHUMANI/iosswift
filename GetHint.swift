class Solution {
    func getHint(_ secret: String, _ guess: String) -> String {
        
        var bulls = 0
        var cows = 0
        
        var secretArr = Array(secret)
        var guessArr = Array(guess)
        
        var count = Array(repeating: 0, count: 10)
        
        // First pass: count bulls and store remaining digits
        for i in 0..<secretArr.count {
            if secretArr[i] == guessArr[i] {
                bulls += 1
            } else {
                let sDigit = Int(String(secretArr[i]))!
                let gDigit = Int(String(guessArr[i]))!
                
                // If secret had extra digit before, it's a cow
                if count[sDigit] < 0 {
                    cows += 1
                }
                
                // If guess had extra digit before, it's a cow
                if count[gDigit] > 0 {
                    cows += 1
                }
                
                count[sDigit] += 1
                count[gDigit] -= 1
            }
        }
        
        return "\(bulls)A\(cows)B"
    }
}
