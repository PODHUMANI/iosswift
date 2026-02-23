class Solution {
    func isHappy(_ n: Int) -> Bool {
        var num = n
        var seen = Set<Int>()
        
        while num != 1 && !seen.contains(num) {
            seen.insert(num)
            num = sumOfSquares(num)
        }
        
        return num == 1
    }
    
    private func sumOfSquares(_ n: Int) -> Int {
        var number = n
        var sum = 0
        
        while number > 0 {
            let digit = number % 10
            sum += digit * digit
            number /= 10
        }
        
        return sum
    }
}
