import UIKit


struct Employee: Codable {
    let name: String
    let salary: String
    let age: String
}


struct ResponseData: Codable {
    let status: String
    let data: EmployeeResponse
    let message: String
}

struct EmployeeResponse: Codable {
    let name: String
    let salary: String
    let age: String
    let employeeID: Int

    enum CodingKeys: String, CodingKey {
        case name, salary, age
        case employeeID = "id"
    }
}

class ViewController: UIViewController {

    // Connect this to your UILabel in storyboard
    @IBOutlet weak var employeeInfoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Connect this to your button in storyboard
    @IBAction func createEmployeeTapped(_ sender: UIButton) {
        createEmployee()
    }

    func createEmployee() {
        guard let url = URL(string: "https://dummy.restapiexample.com/api/v1/create") else {
            print(" Invalid URL")
            return
        }

        let newEmployee = Employee(name: "test", salary: "123", age: "23")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(newEmployee)
            request.httpBody = jsonData
        } catch {
            print(" JSON encoding error: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(" Request failed: \(error)")
                return
            }

            guard let data = data else {
                print(" No data returned")
                return
            }

            do {
                let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                print(" Response: \(responseData)")

                // Update UI on main thread
                DispatchQueue.main.async {
                    let id = responseData.data.employeeID
                    let name = responseData.data.name
                    let age = responseData.data.age
                    let salary = responseData.data.salary

                    // Show Alert
                    let alert = UIAlertController(
                        title: "Success",
                        message: "Employee created with ID: \(id)",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)

                    // Update UILabel with employee data
                    self.employeeInfoLabel.text = """
                     Name: \(name)
                     Age: \(age)
                     Salary: \(salary)
                     ID: \(id)
                    """
                }
            } catch {
                print(" Decoding error: \(error)")
                print(String(data: data, encoding: .utf8) ?? " Invalid response format")
            }
        }

        task.resume()
    }
}
