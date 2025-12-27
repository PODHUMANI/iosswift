class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {

        let nums = nums.sorted()
        let n = nums.count

        // Initial closest sum
        var closestSum = nums[0] + nums[1] + nums[2]

        for i in 0..<n-2 {

            var left = i + 1
            var right = n - 1

            while left < right {
                let sum = nums[i] + nums[left] + nums[right]

                // Update closest sum
                if abs(sum - target) < abs(closestSum - target) {
                    closestSum = sum
                }

                if sum < target {
                    left += 1
                } else if sum > target {
                    right -= 1
                } else {
                    // Exact match found
                    return sum
                }
            }
        }
        return closestSum
    }
}
