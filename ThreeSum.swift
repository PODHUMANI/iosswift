class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {

        let nums = nums.sorted()
        var result: [[Int]] = []
        let n = nums.count

        for i in 0..<n-2 {

            // Skip duplicate values for i
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }

            var left = i + 1
            var right = n - 1

            while left < right {
                let sum = nums[i] + nums[left] + nums[right]

                if sum == 0 {
                    result.append([nums[i], nums[left], nums[right]])

                    // Skip duplicates for left
                    while left < right && nums[left] == nums[left + 1] {
                        left += 1
                    }

                    // Skip duplicates for right
                    while left < right && nums[right] == nums[right - 1] {
                        right -= 1
                    }

                    left += 1
                    right -= 1

                } else if sum < 0 {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        return result
    }
}
