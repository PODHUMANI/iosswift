class MyClass {
    private var task: Task<Void, Never>?

    func start() {
        task = Task { [weak self] in
            guard let self else { return }

            for await item in stream {
                try Task.checkCancellation()
                self.process(item)
            }
        }
    }

    deinit {
        task?.cancel()
    }
}
