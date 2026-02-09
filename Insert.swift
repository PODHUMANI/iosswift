class Solution {
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var newStart = newInterval[0]
        var newEnd = newInterval[1]
        var i = 0
        let n = intervals.count

        //  Left side (no overlap)
        while i < n && intervals[i][1] < newStart {
            result.append(intervals[i])
            i += 1
        }

        //  Overlapping intervals (merge)
        while i < n && intervals[i][0] <= newEnd {
            newStart = min(newStart, intervals[i][0])
            newEnd = max(newEnd, intervals[i][1])
            i += 1
        }
        result.append([newStart, newEnd])

        // Right side
        while i < n {
            result.append(intervals[i])
            i += 1
        }

        return result
    }
}
