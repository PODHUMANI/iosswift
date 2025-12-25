class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {

        if strs.isEmpty { return "" }

        var prefix = strs[0]

        for word in strs {
            while !word.hasPrefix(prefix) {
                prefix.removeLast()
                if prefix.isEmpty {
                    return ""
                }
            }
        }
        return prefix
    }
}
