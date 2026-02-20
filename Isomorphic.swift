class Solution {
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        
        if s.count != t.count {
            return false
        }
        
        var mapST: [Character: Character] = [:]
        var mapTS: [Character: Character] = [:]
        
        let sArray = Array(s)
        let tArray = Array(t)
        
        for i in 0..<sArray.count {
            let ch1 = sArray[i]
            let ch2 = tArray[i]
            
            // Check s -> t mapping
            if let mappedChar = mapST[ch1] {
                if mappedChar != ch2 {
                    return false
                }
            } else {
                mapST[ch1] = ch2
            }
            
            // Check t -> s mapping
            if let mappedChar = mapTS[ch2] {
                if mappedChar != ch1 {
                    return false
                }
            } else {
                mapTS[ch2] = ch1
            }
        }
        
        return true
    }
}
