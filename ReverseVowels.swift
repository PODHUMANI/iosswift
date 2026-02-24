class Solution {
    func reverseVowels(_ s: String) -> String {
        
        var chars = Array(s)
        let vowels: Set<Character> = ["a","e","i","o","u",
                                      "A","E","I","O","U"]
        
        var left = 0
        var right = chars.count - 1
        
        while left < right {
            
            while left < right && !vowels.contains(chars[left]) {
                left += 1
            }
            
            while left < right && !vowels.contains(chars[right]) {
                right -= 1
            }
            
            chars.swapAt(left, right)
            
            left += 1
            right -= 1
        }
        
        return String(chars)
    }
}
