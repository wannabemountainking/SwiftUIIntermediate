//
//  SwiftUIIntermediateApp.swift
//  SwiftUIIntermediate
//
//  Created by yoonie on 12/29/25.
//

import SwiftUI
import CoreData

@main
struct SwiftUIIntermediateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BackgroundThreadInter()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
