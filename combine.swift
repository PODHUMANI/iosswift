class Solution {
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var result = [[Int]]()
        var current = [Int]()
        
        func backtrack(_ start: Int) {
            if current.count == k {
                result.append(current)
                return
            }
            
            // Calculate safely
            let remaining = k - current.count
            let upperBound = n - remaining + 1
            
            // If invalid range, stop recursion
            if start > upperBound { return }
            
            for i in start...upperBound {
                current.append(i)
                backtrack(i + 1)
                current.removeLast()
            }
        }
        
        backtrack(1)
        return result
    }
}
