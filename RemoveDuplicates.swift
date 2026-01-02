class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {

        if nums.isEmpty { return 0 }

        var k = 1   // index for unique elements

        for i in 1..<nums.count {
            if nums[i] != nums[i - 1] {
                nums[k] = nums[i]
                k += 1
            }
        }

        return k
    }
}
