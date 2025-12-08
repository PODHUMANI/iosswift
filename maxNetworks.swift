func maxNetworks(_ speeds: [Int], _ minComps: Int, _ threshold: Int) -> Int {
    let n = speeds.count
    var count = 0
    var i = 0

    while i < n {
        var sum = 0
        var j = i
        var comps = 0
        
        // Step 1: Add minimum required computers
        while j < n && comps < minComps {
            sum += speeds[j]
            comps += 1
            j += 1
        }
        
        // If minimum computers not possible → break
        if comps < minComps {
            break
        }
        
        // Step 2: If sum below threshold, extend window
        while j < n && sum < threshold {
            sum += speeds[j]
            j += 1
        }
        
        // Valid network formed
        if sum >= threshold {
            count += 1
            i = j   // Skip used computers
        } else {
            break  // No more networks possible
        }
    }

    return count
}
