import SwiftUI

struct DotoListHomeView: View {
    @State var tasks: [ToDoTask] = []
    @State var showAddTaskView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
       //         VStack(alignment: .leading) {
//                    Text("Tasks")
//                        .font(.system(size: 40, weight: .bold))
//                        .foregroundColor(.black)
//                        .padding()
                    
                    List {
                        ForEach(tasks) { task in
                            Button(action: {
                                if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                    tasks[index] = ToDoTask(title: task.title, priority: task.priority, isCompleted: !task.isCompleted)
                                }
                            }) {
                                TaskRowView(task: task)
                            }
                        }.onDelete(perform: delete )
                    }
                    Spacer()
              //  }
            }
            .navigationTitle(Text("Tasks"))
            .sheet(isPresented: $showAddTaskView) {
                AddTaskView(tasks: $tasks)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showAddTaskView = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.black)
                    }
                }
            }
        }
    }
    private func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

struct TaskRowView: View {
    var task: ToDoTask
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle" : "circle")
                .font(.system(size: 16))
                .foregroundStyle(.black)
            
            Text(task.priority.title)
                .font(.system(size: 15, weight: .bold))
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .foregroundStyle(task.priority.color)
                .background(task.priority.color.opacity(0.2))
                .cornerRadius(8)
        }
    }
}

#Preview {
    
    DotoListHomeView()
}
