class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        
        // Ensure nums1 is smaller
        if nums1.count > nums2.count {
            return findMedianSortedArrays(nums2, nums1)
        }
        
        let m = nums1.count
        let n = nums2.count
        
        var low = 0
        var high = m
        
        while low <= high {
            let i = (low + high) / 2
            let j = (m + n + 1) / 2 - i
            
            let left1 = (i == 0) ? Int.min : nums1[i - 1]
            let right1 = (i == m) ? Int.max : nums1[i]
            
            let left2 = (j == 0) ? Int.min : nums2[j - 1]
            let right2 = (j == n) ? Int.max : nums2[j]
            
            if left1 <= right2 && left2 <= right1 {
                if (m + n) % 2 == 0 {
                    return Double(max(left1, left2) + min(right1, right2)) / 2.0
                } else {
                    return Double(max(left1, left2))
                }
            } else if left1 > right2 {
                high = i - 1
            } else {
                low = i + 1
            }
        }
        
        return 0.0
    }
}
