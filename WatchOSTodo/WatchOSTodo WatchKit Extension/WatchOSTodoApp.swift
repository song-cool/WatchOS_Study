//
//  WatchOSTodoApp.swift
//  WatchOSTodo WatchKit Extension
//
//  Created by 송시원 on 2022/08/01.
//

import SwiftUI

@main
struct WatchOSTodoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environment(\.managedObjectContext, PersistentController.shared.container.viewContext)
            // 접근 키와함께 앱의 뷰에 접근 가능하게됨. 이게 뭔뜻이냐??! 왜 이렇게 쓰면 다 되는거지?
        }
    }
}
