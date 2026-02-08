//
//  SwiftUIIntermediateApp.swift
//  SwiftUIIntermediate
//
//  Created by yoonie on 12/29/25.
//

import SwiftUI
import CoreData

@main
@available(iOS 16.0, *)
struct SwiftUIIntermediateApp: App {
    
    // PersistenceController
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CoreDataInter()
            // environment 로 하위뷰 전체에 persistenceController.container 접속하게 함
            // viewContext: NSManagedObjectContext 타입으로 container 의 안에 있는 data를 가리킴
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
