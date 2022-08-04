//
//  FolderView.swift
//  WatchOSTodo WatchKit Extension
//
//  Created by 송시원 on 2022/08/01.
//

import SwiftUI

struct FolderView: View {
    
    @FetchRequest(entity: Folder.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Folder.dateAdded, ascending: false)], animation: .easeInOut)
    
    var results: FetchedResults<Folder>
    
    var body: some View {
        
        List {
            ForEach(results) { item in
                HStack {
                    // 데이터 페치로 작동하기 때문에 ?? "" 로 예외처리를 습관처럼 해야함.
                    NavigationLink(destination: TodoListView(folderName: item.title ?? "", accentColor: item.colorString ?? "blue"), label: {
                        Text(item.title ?? "")
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .contentShape(Rectangle())
                    // 넣은 이유는 선택영역때문임.
                    .background(LinearGradient(gradient: Gradient(colors: [Color(item.colorString ?? "blue"),
                                                                           Color(item.colorString ?? "blue").opacity(0.8),
                                                                           Color(item.colorString ?? "blue")]),
                                               startPoint: .top, endPoint: .bottom))
                    .cornerRadius(5)
                }
            }
            
            NavigationLink(destination: AddNewFolder(), label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("New Folder")
                    Spacer()
                }
            })
        }
        .listStyle(CarouselListStyle())
        .navigationBarTitle("Folders")
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}
