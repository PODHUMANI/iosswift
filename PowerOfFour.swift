class Solution {
    func isPowerOfFour(_ n: Int) -> Bool {
        if n <= 0 { return false }
        
        var num = n
        
        while num % 4 == 0 {
            num /= 4
        }
        
        return num == 1
    }
}
