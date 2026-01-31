class Solution {
    func nextPermutation(_ nums: inout [Int]) {
        let n = nums.count
        if n <= 1 { return }

        // Step 1: Find pivot
        var i = n - 2
        while i >= 0 && nums[i] >= nums[i + 1] {
            i -= 1
        }

        // Step 2: Find successor
        if i >= 0 {
            var j = n - 1
            while nums[j] <= nums[i] {
                j -= 1
            }
            nums.swapAt(i, j)
        }

        // Step 3: Reverse suffix
        reverse(&nums, i + 1, n - 1)
    }

    private func reverse(_ nums: inout [Int], _ left: Int, _ right: Int) {
        var l = left
        var r = right
        while l < r {
            nums.swapAt(l, r)
            l += 1
            r -= 1
        }
    }
}
