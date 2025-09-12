import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    
    // Add new task
    func addTask(title: String, notes: String, date: Date, category: String) {
        let newTask = TaskModel(title: title, notes: notes, date: date, category: category)
        tasks.append(newTask)
    }
    
    // Mark as complete
    func toggleComplete(task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isComplete.toggle()
        }
    }
    
    // Delete Task
    func deleteTask(task: TaskModel) {
        tasks.removeAll { $0.id == task.id }
    }
    
    // Filter
    var completedTasks: [TaskModel] {
        tasks.filter { $0.isComplete }
    }
    
    var inCompleteTasks: [TaskModel] {
        tasks.filter { !$0.isComplete }
    }
}
