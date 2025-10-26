class MyClass {
    var onComplete: (() -> Void)?

    func start() {
        doLongTask {     // escaping closure
            print(self)  // ← self used inside closure
        }
    }

    func doLongTask(_ completion: @escaping () -> Void) {
        self.onComplete = completion // closure is STORED
    }
}
