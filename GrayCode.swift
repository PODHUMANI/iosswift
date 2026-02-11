class Solution {
    func grayCode(_ n: Int) -> [Int] {
        var result: [Int] = []
        let size = 1 << n   // 2^n
        
        for i in 0..<size {
            result.append(i ^ (i >> 1))
        }
        
        return result
    }
}
