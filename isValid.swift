class Solution {
    func isValid(_ s: String) -> Bool {

        var stack: [Character] = []
        let map: [Character: Character] = [
            ")": "(",
            "}": "{",
            "]": "["
        ]

        for ch in s {
            // Opening bracket
            if ch == "(" || ch == "{" || ch == "[" {
                stack.append(ch)
            }
            // Closing bracket
            else {
                if stack.isEmpty || stack.removeLast() != map[ch] {
                    return false
                }
            }
        }

        return stack.isEmpty
    }
}
