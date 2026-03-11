class Solution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        
        var graph = Array(repeating: [Int](), count: numCourses)
        var indegree = Array(repeating: 0, count: numCourses)
        
        // Build graph
        for pair in prerequisites {
            let a = pair[0]
            let b = pair[1]
            
            graph[b].append(a)
            indegree[a] += 1
        }
        
        var queue = [Int]()
        
        // Add courses with 0 indegree
        for i in 0..<numCourses {
            if indegree[i] == 0 {
                queue.append(i)
            }
        }
        
        var count = 0
        
        while !queue.isEmpty {
            let course = queue.removeFirst()
            count += 1
            
            for next in graph[course] {
                indegree[next] -= 1
                
                if indegree[next] == 0 {
                    queue.append(next)
                }
            }
        }
        
        return count == numCourses
    }
}
