class Solution {
    func plusOne(_ digits: [Int]) -> [Int] {

        var result = digits

        for i in stride(from: result.count - 1, through: 0, by: -1) {
            if result[i] < 9 {
                result[i] += 1
                return result
            }
            result[i] = 0
        }

        // All digits were 9
        result.insert(1, at: 0)
        return result
    }
}
