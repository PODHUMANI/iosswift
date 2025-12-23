class Solution {
    func romanToInt(_ s: String) -> Int {

        let values: [Character: Int] = [
            "I": 1,
            "V": 5,
            "X": 10,
            "L": 50,
            "C": 100,
            "D": 500,
            "M": 1000
        ]

        let chars = Array(s)
        var result = 0

        for i in 0..<chars.count {
            let currentValue = values[chars[i]]!

            if i + 1 < chars.count,
               currentValue < values[chars[i + 1]]! {
                result -= currentValue
            } else {
                result += currentValue
            }
        }

        return result
    }
}
