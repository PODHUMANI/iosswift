import SwiftUI

struct TaskView: View {
    @State var tasks: [ToDoTask] = []
    @State var showAddTaskView = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(tasks) { task in
                        Button(action: {
                            if let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) {
                                tasks[taskIndex] = ToDoTask(title: task.title, priority: task.priority, isCompleted: !task.isCompleted)
                            }
                        }, label: {
                            TaskRowView(task: task)
                        })
                    }.onDelete(perform: delete )
                }
                
            }
            .navigationTitle("Tasks")
            .sheet(isPresented: $showAddTaskView) {
                AddTaskView(tasks: $tasks)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showAddTaskView = true
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.black)
                    })
                }
            }
        }
    }
    private func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    TaskView()
}
