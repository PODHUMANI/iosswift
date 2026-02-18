class Solution {
    func longestValidParentheses(_ s: String) -> Int {
        var stack: [Int] = []
        stack.append(-1)   // Base for length calculation
        
        var maxLength = 0
        let chars = Array(s)
        
        for i in 0..<chars.count {
            if chars[i] == "(" {
                stack.append(i)
            } else {
                stack.removeLast()
                
                if stack.isEmpty {
                    stack.append(i)
                } else {
                    maxLength = max(maxLength, i - stack.last!)
                }
            }
        }
        
        return maxLength
    }
}
