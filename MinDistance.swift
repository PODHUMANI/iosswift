class Solution {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        
        let m = word1.count
        let n = word2.count
        
        let w1 = Array(word1)
        let w2 = Array(word2)
        
        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        
        // Base cases
        for i in 0...m {
            dp[i][0] = i
        }
        
        for j in 0...n {
            dp[0][j] = j
        }
        
        // Safe looping
        if m > 0 && n > 0 {
            for i in 1..<m+1 {
                for j in 1..<n+1 {
                    
                    if w1[i - 1] == w2[j - 1] {
                        dp[i][j] = dp[i - 1][j - 1]
                    } else {
                        dp[i][j] = 1 + min(
                            dp[i][j - 1],     // Insert
                            dp[i - 1][j],     // Delete
                            dp[i - 1][j - 1]  // Replace
                        )
                    }
                }
            }
        }
        
        return dp[m][n]
    }
}
