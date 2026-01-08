class Solution {
    func climbStairs(_ n: Int) -> Int {
        if n <= 2 { return n }

        var prev1 = 1   // ways to reach step 1
        var prev2 = 2   // ways to reach step 2

        for _ in 3...n {
            let current = prev1 + prev2
            prev1 = prev2
            prev2 = current
        }

        return prev2
    }
}
