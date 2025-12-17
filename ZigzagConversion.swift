class Solution {
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows == 1 || s.count <= numRows {
            return s
        }
        
        var rows = Array(repeating: "", count: numRows)
        var currentRow = 0
        var goingDown = false
        
        for ch in s {
            rows[currentRow].append(ch)
            
            if currentRow == 0 || currentRow == numRows - 1 {
                goingDown.toggle()
            }
            
            currentRow += goingDown ? 1 : -1
        }
        
        return rows.joined()
    }
}
