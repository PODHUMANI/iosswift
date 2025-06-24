protocol MessageDelegate: AnyObject {
    func didReceiveMessage(_ message: String)
}

class Sender {
    weak var delegate: MessageDelegate?

    func send() {
        delegate?.didReceiveMessage("Hello!")
    }
}

class Receiver: MessageDelegate {
    func didReceiveMessage(_ message: String) {
        print("Received:", message)
    }
}

let sender = Sender()
let receiver = Receiver()

sender.delegate = receiver
sender.send()  // Output: Received: Hello!
