class Solution {
    func multiply(_ num1: String, _ num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0"
        }

        let n = num1.count
        let m = num2.count
        var result = Array(repeating: 0, count: n + m)

        let chars1 = Array(num1)
        let chars2 = Array(num2)

        for i in stride(from: n - 1, through: 0, by: -1) {
            let digit1 = Int(String(chars1[i]))!

            for j in stride(from: m - 1, through: 0, by: -1) {
                let digit2 = Int(String(chars2[j]))!

                let mul = digit1 * digit2
                let sum = mul + result[i + j + 1]

                result[i + j + 1] = sum % 10
                result[i + j] += sum / 10
            }
        }

        // Convert result array to string (skip leading zeros)
        var index = 0
        while index < result.count && result[index] == 0 {
            index += 1
        }

        var answer = ""
        while index < result.count {
            answer.append(String(result[index]))
            index += 1
        }

        return answer
    }
}
