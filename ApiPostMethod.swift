import Foundation
import SwiftUI

// MARK: - Model
struct Student: Codable, Identifiable {
    let id: Int
    let studentName: String
    let age: Int
    let className: String
    let markList: [MarkList]
    let pass: Bool
}

struct MarkList: Codable {
    let subjectName: String
    let mark: Double
    
    enum CodingKeys: String, CodingKey {
        case subjectName = "Subject Name"
        case mark = "Mark"
    }
}

// MARK: - ViewModel
class StudentViewModel: ObservableObject {
    @Published var studentInfo: [Student] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Replace with your actual API endpoint
    let baseURL = "https://yourapi.com/students/"
    
    // Fetch
    func fetchStudent() async {
        guard let url = URL(string: baseURL) else { return }
        DispatchQueue.main.async { self.isLoading = true }
        defer { DispatchQueue.main.async { self.isLoading = false } }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            let decodedData = try JSONDecoder().decode([Student].self, from: data)
            DispatchQueue.main.async { self.studentInfo = decodedData }
        } catch {
            DispatchQueue.main.async { self.errorMessage = "Error: \(error.localizedDescription)" }
        }
    }
    
    // Post
    func postNewStudentItem(newPost: Student) async {
        guard let url = URL(string: baseURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let jsonData = try JSONEncoder().encode(newPost)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse,
               (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
                let decodedData = try JSONDecoder().decode(Student.self, from: data)
                DispatchQueue.main.async { self.studentInfo.append(decodedData) }
            } else {
                DispatchQueue.main.async { self.errorMessage = "Server responded with error" }
            }
        } catch {
            DispatchQueue.main.async { self.errorMessage = "POST Error: \(error.localizedDescription)" }
        }
    }
    
    // Update
    func updateStudent(updatedUser: Student) async {
        let urlString = "\(baseURL)\(updatedUser.id)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(updatedUser)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let decodedUser = try JSONDecoder().decode(Student.self, from: data)
                DispatchQueue.main.async {
                    if let index = self.studentInfo.firstIndex(where: { $0.id == decodedUser.id }) {
                        self.studentInfo[index] = decodedUser
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Update failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)"
                }
            }
        } catch {
            DispatchQueue.main.async { self.errorMessage = "PUT Error: \(error.localizedDescription)" }
        }
    }
    
    // Delete
    func deleteStudent(id: Int) async {
        let urlString = "\(baseURL)\(id)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async { self.studentInfo.removeAll { $0.id == id } }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Delete failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)"
                }
            }
        } catch {
            DispatchQueue.main.async { self.errorMessage = "DELETE Error: \(error.localizedDescription)" }
        }
    }
}

// MARK: - View
struct StudentView: View {
    @StateObject private var viewModel = StudentViewModel()
    
    @State private var studentName = ""
    @State private var studentid = ""
    @State private var className = ""
    @State private var studentAge = ""
    @State private var subjectName = ""
    @State private var mark = ""
    @State private var pass = false
    
    var body: some View {
        ZStack {
            Image("bag")
                .resizable()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Group {
                        CustomTextField(title: "Student Id", text: $studentid)
                        CustomTextField(title: "Student Name", text: $studentName)
                        CustomTextField(title: "Student Age", text: $studentAge)
                        CustomTextField(title: "Class Name", text: $className)
                        CustomTextField(title: "Subject Name", text: $subjectName)
                        CustomTextField(title: "Mark", text: $mark)
                    }
                    
                    Toggle("Pass", isOn: $pass)
                        .padding()
                    
                    Button(action: {
                        guard let id = Int(studentid),
                              let age = Int(studentAge),
                              let markValue = Double(mark) else { return }
                        
                        let markList = [MarkList(subjectName: subjectName, mark: markValue)]
                        
                        let newStudent = Student(
                            id: id,
                            studentName: studentName,
                            age: age,
                            className: className,
                            markList: markList,
                            pass: pass
                        )
                        
                        Task {
                            await viewModel.postNewStudentItem(newPost: newStudent)
                        }
                    }) {
                        Text("Add Student")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Divider().padding(.vertical)
                    
                    // Display Students
                    ForEach(viewModel.studentInfo) { student in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Name: \(student.studentName)")
                                .font(.headline)
                            Text("Class: \(student.className)")
                                .font(.subheadline)
                            Text("Pass: \(student.pass ? "✅" : "❌")")
                                .font(.subheadline)
                            
                            HStack {
                                Button("Delete") {
                                    Task {
                                        await viewModel.deleteStudent(id: student.id)
                                    }
                                }
                                .foregroundColor(.red)
                                
                                Spacer()
                                
                                Button("Edit") {
                                    // Future: Add edit logic
                                }
                                .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchStudent()
            }
        }
    }
}

// MARK: - Custom TextField
struct CustomTextField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 15))
                .bold()
            TextField(title, text: $text)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .padding()
                .frame(height: 50)
                .background(Color.white.opacity(0.8))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.6), lineWidth: 2))
                .cornerRadius(10)
        }
    }
}

//#Preview {
//    StudentView()
//}
