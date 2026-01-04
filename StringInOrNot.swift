class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {

        let h = Array(haystack)
        let n = Array(needle)

        if n.count > h.count { return -1 }

        for i in 0...(h.count - n.count) {
            var j = 0

            while j < n.count && h[i + j] == n[j] {
                j += 1
            }

            if j == n.count {
                return i
            }
        }
        return -1
    }
}
