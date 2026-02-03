class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var path = [Int]()
        var used = Array(repeating: false, count: nums.count)

        backtrack(nums, &path, &used, &result)
        return result
    }

    private func backtrack(
        _ nums: [Int],
        _ path: inout [Int],
        _ used: inout [Bool],
        _ result: inout [[Int]]
    ) {
        // Base case
        if path.count == nums.count {
            result.append(path)
            return
        }

        for i in 0..<nums.count {
            if used[i] { continue }

            // Choose
            used[i] = true
            path.append(nums[i])

            // Explore
            backtrack(nums, &path, &used, &result)

            // Un-choose (Backtrack)
            path.removeLast()
            used[i] = false
        }
    }
}
