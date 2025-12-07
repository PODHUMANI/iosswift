func reduceCapacity(_ model: [Int]) -> Int {
    let n = model.count
    let target = (n + 1) / 2   // ceil(n/2)

    var freq: [Int: Int] = [:]
    for m in model {
        freq[m, default: 0] += 1
    }

    let sortedCounts = freq.values.sorted(by: >)

    var sum = 0
    var countModels = 0

    for c in sortedCounts {
        sum += c
        countModels += 1
        if sum >= target {
            return countModels
        }
    }

    return countModels
}
