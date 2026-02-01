class Solution {
    func countAndSay(_ n: Int) -> String {
        if n == 1 { return "1" }
        
        var result = "1"
        
        for _ in 2...n {
            var current = ""
            let chars = Array(result)
            var count = 1
            
            for i in 1..<chars.count {
                if chars[i] == chars[i - 1] {
                    count += 1
                } else {
                    current += "\(count)\(chars[i - 1])"
                    count = 1
                }
            }
            
            // Add last group
            current += "\(count)\(chars.last!)"
            result = current
        }
        
        return result
    }
}
