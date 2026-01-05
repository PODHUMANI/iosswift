class Solution {
    func lengthOfLastWord(_ s: String) -> Int {

        let chars = Array(s)
        var length = 0
        var i = chars.count - 1

        // Skip trailing spaces
        while i >= 0 && chars[i] == " " {
            i -= 1
        }

        // Count last word characters
        while i >= 0 && chars[i] != " " {
            length += 1
            i -= 1
        }

        return length
    }
}
