import Foundation
print("before the network call")
URLSession.shared.downloadTask(with: URLRequest(url:URL(string:"https://swapi.dev/api/people/1")!)){_,_,_ in
    print("Inside the network call")
}.resume()

print("after the network call")
