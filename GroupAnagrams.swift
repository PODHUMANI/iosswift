class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var dict = [String: [String]]()

        for word in strs {
            let sortedWord = String(word.sorted())
            
            dict[sortedWord, default: []].append(word)
        }
        
        return Array(dict.values)
    }
}
