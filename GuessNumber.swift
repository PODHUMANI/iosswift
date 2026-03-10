class Solution: GuessGame {
    func guessNumber(_ n: Int) -> Int {
        
        var left = 1
        var right = n
        
        while left <= right {
            
            let mid = left + (right - left) / 2
            let result = guess(mid)
            
            if result == 0 {
                return mid
            }
            else if result == -1 {
                right = mid - 1
            }
            else {
                left = mid + 1
            }
        }
        
        return -1
    }
}
