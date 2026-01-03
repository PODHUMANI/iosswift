class Solution {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {

        var k = 0   // index for elements not equal to val

        for i in 0..<nums.count {
            if nums[i] != val {
                nums[k] = nums[i]
                k += 1
            }
        }
        return k
    }
}
