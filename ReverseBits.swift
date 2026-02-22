class Solution {
    func reverseBits(_ n: Int) -> Int {
        var num = UInt32(n)
        var result: UInt32 = 0
        
        for _ in 0..<32 {
            result <<= 1
            result |= (num & 1)
            num >>= 1
        }
        
        return Int(result)
    }
}
