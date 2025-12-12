class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var set = Set<Character>()
        let chars = Array(s)
        var left = 0
        var maxLength = 0

        for right in 0..<chars.count {
            while set.contains(chars[right]) {
                set.remove(chars[left])
                left += 1
            }
            
            set.insert(chars[right])
            maxLength = max(maxLength, right - left + 1)
        }
        
        return maxLength
    }
}
