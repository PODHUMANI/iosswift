class Solution {
    func integerBreak(_ n: Int) -> Int {
        
    }
}func integerBreak(_ n: Int) -> Int {
    if n == 2 { return 1 }
    if n == 3 { return 2 }
    
    var num = n
    var product = 1
    
    while num > 4 {
        product *= 3
        num -= 3
    }
    
    return product * num
}
