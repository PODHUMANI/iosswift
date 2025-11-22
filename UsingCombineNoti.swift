let publisher = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)

let cancellable = publisher.sink { notification in
    print("App Became Active")
}
