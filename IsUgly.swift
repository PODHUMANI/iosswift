class Solution {
    func isUgly(_ n: Int) -> Bool {
        if n <= 0 { return false }

        var num = n
        let primes = [2, 3, 5]

        for p in primes {
            while num % p == 0 {
                num /= p
            }
        }
        return num == 1
    }
}
