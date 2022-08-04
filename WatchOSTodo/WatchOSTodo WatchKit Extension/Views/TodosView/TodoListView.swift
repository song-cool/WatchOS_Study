//
//  TodoListView.swift
//  WatchOSTodo WatchKit Extension
//
//  Created by 송시원 on 2022/08/02.
//

import SwiftUI

struct TodoListView: View {
    
    var accentColor: String
    var folderName: String
    
    @FetchRequest var results: FetchedResults<Todo>
    
    init(folderName: String, accentColor: String) {
        self.accentColor = accentColor
        self.folderName = folderName
        
        let predicate = NSPredicate(format: "folder == %@", folderName)
        self._results = FetchRequest(entity: Todo.entity(),
                                     sortDescriptors: [NSSortDescriptor(keyPath: \Todo.dateAdded, ascending: false)],
                                     predicate: predicate,
                                     animation: .easeInOut)
    }
    
    var body: some View {
        List {
            ForEach(results) { item in
                HStack {
                    NavigationLink(destination: AddNewTodo(todoItem: item, accentColor: accentColor, folderName: folderName), label: {
                        Text(item.title ?? "")
                            .bold()
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .contentShape(Rectangle())
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color(accentColor), Color(accentColor).opacity(0.8), Color(accentColor)]), startPoint: .top, endPoint: .bottom), lineWidth: 4)
                    )
                }
            }
            NavigationLink(destination: AddNewTodo(accentColor: accentColor, folderName: folderName), label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("New Todo")
                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 5)
                    .fill(Color.accentColor)
                    .frame(height: 40)
                )
            })
        }
        .listStyle(CarouselListStyle())
        .navigationBarTitle(folderName)
    }
}
//
//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}
