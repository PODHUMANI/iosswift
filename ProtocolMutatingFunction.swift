protocol Toggleable {
    mutating func toggle()
}

enum Switch: Toggleable {
    case on, off

    mutating func toggle() {
        self = (self == .on) ? .off : .on
    }
}

var s = Switch.on
s.toggle()   // becomes .off
