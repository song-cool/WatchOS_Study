//
//  PersistentController.swift
//  WatchOSTodo WatchKit Extension
//
//  Created by 송시원 on 2022/08/01.
//

import Foundation
import CoreData

struct PersistentController {
    static let shared = PersistentController()
    // 싱글톤이 뭔지 알아보기?! 싱글톤으로 접근되어야한대?!!!
    //이렇게 하면 생성되자마자 앱 전체에 공유될 수 있나봐.
    
    let container: NSPersistentContainer
    
    // 영구저장소 생성부.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "doit")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // 코어데이터의 모델이 초기화되지 않으면 앱을 다운시켜버림. 에러코드와 함께
        container.loadPersistentStores {(storeDesc, error) in
            if let error = error as NSError? {
                fatalError("Failed to load container \(error)")
            }
        }
    }
    
    
}
