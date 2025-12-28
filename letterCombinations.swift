class Solution {
    func letterCombinations(_ digits: String) -> [String] {

        if digits.isEmpty { return [] }

        let phoneMap: [Character: [String]] = [
            "2": ["a","b","c"],
            "3": ["d","e","f"],
            "4": ["g","h","i"],
            "5": ["j","k","l"],
            "6": ["m","n","o"],
            "7": ["p","q","r","s"],
            "8": ["t","u","v"],
            "9": ["w","x","y","z"]
        ]

        let digitsArray = Array(digits)
        var result: [String] = []

        func backtrack(_ index: Int, _ current: String) {
            if index == digitsArray.count {
                result.append(current)
                return
            }

            let letters = phoneMap[digitsArray[index]]!
            for letter in letters {
                backtrack(index + 1, current + letter)
            }
        }

        backtrack(0, "")
        return result
    }
}
