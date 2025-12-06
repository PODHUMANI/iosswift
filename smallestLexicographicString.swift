func smallestLexicographicString(_ s: String) -> String {
    var chars = Array(s)
    let n = chars.count

    var i = 0

    // Step 1: முதல் non-'a' character கண்டுபிடிக்கவும்
    while i < n && chars[i] == "a" {
        i += 1
    }

    // Case 2: எல்லா characters-உம் 'a' என்றால்
    if i == n {
        chars[n - 1] = "z"
        return String(chars)
    }

    // Step 3: 'a' வரும் வரை characters-ஐ 1 alphabet backward செய்யவும்
    while i < n && chars[i] != "a" {
        let ascii = chars[i].asciiValue!
        chars[i] = Character(UnicodeScalar(ascii - 1))
        i += 1
    }

    return String(chars)
}


// Example usage
let result = smallestLexicographicString("hackerranik")
print(result)
