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
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            WeakSelfInter()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
