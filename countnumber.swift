let number = 9876
var temp = number
var count = 0

while temp > 0 {
    count += 1          // increment digit count
    temp /= 10          // remove last digit
}

print("Number of digits in \(number) is \(count)")
