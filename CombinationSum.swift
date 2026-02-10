class Solution {
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result = [[Int]]()
        var path = [Int]()
        
        func backtrack(_ index: Int, _ remaining: Int) {
            // If target reached
            if remaining == 0 {
                result.append(path)
                return
            }
            
            // If target exceeded
            if remaining < 0 {
                return
            }
            
            // Try each candidate starting from index
            for i in index..<candidates.count {
                path.append(candidates[i])
                backtrack(i, remaining - candidates[i]) // reuse allowed
                path.removeLast() // backtrack
            }
        }
        
        backtrack(0, target)
        return result
    }
}
