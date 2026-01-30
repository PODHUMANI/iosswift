class Solution {
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        // Overflow case
        if dividend == Int32.min && divisor == -1 {
            return Int(Int32.max)
        }

        // Determine sign
        let isNegative = (dividend < 0) != (divisor < 0)

        // Convert to positive Int64
        var dvd = abs(Int64(dividend))
        let dvs = abs(Int64(divisor))

        var result: Int64 = 0

        // Main logic using bit shifting
        while dvd >= dvs {
            var temp = dvs
            var multiple: Int64 = 1

            while dvd >= (temp << 1) {
                temp <<= 1
                multiple <<= 1
            }

            dvd -= temp
            result += multiple
        }

        return isNegative ? -Int(result) : Int(result)
    }
}
