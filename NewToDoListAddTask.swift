//
//  NewToDoListAddTask.swift
//  MyCourseTaskInSwiftUI
//
//  Created by Netaxis_IOS on 29/07/25.
//
/*
import SwiftUI

struct NewToDoListAddTask: View {
    @State var tasks :[Task] = []
    @State var Addtasksview = false
        var body:some View {
            //NavigationStack {
                VStack {
                    List {
                        ForEach(tasks){ task in
                            Button(action:{
                                if let taskIndex = tasks.firstIndex(where: {
                                    $0.id == task.id}) {
                                    tasks[taskIndex] = Task(title:task.title,priority:task.priority,isComplete: !task.isComplete )
                                }
                            },Label:{
                                HStack {
                                    Image(systemName:task.isComplete ?
                                          "checkmark.circle":"circle")
                                    .font(.system(size:16))
                                    .foregroundStyle(.black )
                                    Text(task.title)
                                        .font(.system(size:16))
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Text(task.priority.title)
                                        .font(.system(size:15,weight:.bold ))
                                        .padding(.horizontal,12)
                                        .padding(.vertical,5)
                                        .foregroundStyle(task.priority.color)
                                        .fill(task.priority.color )
                                        .opacity(0.4)
                                }
                                })
                            
                        }
                        
                    }
                }
                .navigationTitle("Tasks")
                .sheet(ispresented:$addTasks,content:{
                    Addtaskview(tasks: $tasks )
                })
                .toolbar {
                    ToolbarItem(placement:.topBarTrailing){
                        Button(action:{
                            addTasks = true
                        },Label:{
                            Image(systemName:"plus")
                                .foregroundStyle(Color.black )
                        })
                    }
                }
            }
}

#Preview {
    NewToDoListAddTask()
}
*/
