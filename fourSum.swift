class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {

        let nums = nums.sorted()
        let n = nums.count
        var result: [[Int]] = []

        if n < 4 { return result }

        for i in 0..<n-3 {

            // Skip duplicate i
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }

            for j in i+1..<n-2 {

                // Skip duplicate j
                if j > i + 1 && nums[j] == nums[j - 1] {
                    continue
                }

                var left = j + 1
                var right = n - 1

                while left < right {
                    let sum = nums[i] + nums[j] + nums[left] + nums[right]

                    if sum == target {
                        result.append([nums[i], nums[j], nums[left], nums[right]])

                        // Skip duplicate left
                        while left < right && nums[left] == nums[left + 1] {
                            left += 1
                        }

                        // Skip duplicate right
                        while left < right && nums[right] == nums[right - 1] {
                            right -= 1
                        }

                        left += 1
                        right -= 1

                    } else if sum < target {
                        left += 1
                    } else {
                        right -= 1
                    }
                }
            }
        }
        return result
    }
}
