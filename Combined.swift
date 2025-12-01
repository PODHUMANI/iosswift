import Combine

var cancellable: AnyCancellable?

cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://api.github.com")!)
    .map { $0.data }
    .decode(type: [String: Any].self, decoder: JSONDecoder())
    .sink(receiveCompletion: { completion in
        print(completion)
    }, receiveValue: { value in
        print(value)
    })
