import SwiftUI

struct AddTaskView: View {
    @State var title = ""
    @State var priority: Priority = .normal
    @State var showInvalidTileError = false
    @State var priorityType = false
    @Binding var tasks: [ToDoTask]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading,spacing: 30) {
                Text("Task Tittle")
                
                TextField("Enter Task Tittle", text: $title)
                Text("Priority")
                Picker("Priority", selection: $priority) {
                    ForEach(Priority.allCases){priorityType in
                        Text(priorityType.title)
                            .tag(priorityType)
                    }
                }
                .padding(.bottom)
                
                Button(action: {
                    guard title.count > 2 else{
                        showInvalidTileError = true
                        return
                    }
                    let newTask = ToDoTask ( title: title, priority: priority, isCompleted: false)
                    tasks.append(newTask)
                    dismiss()
                    
                }, label: {
                    Text("Add Task").foregroundStyle(.white)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .frame(height:40 )
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                .padding(.horizontal)
                .alert("Invaild Title",isPresented: $showInvalidTileError,actions:{
                    Button(action:{},label:{
                        Text("OK")
                    })
                },message:{
                    Text("Title must be greater than 2 characters")
                })
                Spacer()
            }
            
        }
    }
}
    

#Preview {
    
    AddTaskView(tasks:.constant([]))
}
