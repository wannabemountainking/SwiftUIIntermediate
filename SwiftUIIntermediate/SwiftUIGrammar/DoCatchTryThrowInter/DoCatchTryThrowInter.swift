//
//  DoCatchTryThrowInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 12/31/25.
//

import SwiftUI
import Combine

// MARK: - DATA MANAGER
class DoCatchTryThrowInterDataManager {
    
    func getTitle1() -> (title: String?, error: Error?) {
        return (nil, URLError(.badURL))
    }
}

// MARK: - VIEWMODEL
class DoCatchTryThrowInterViewModel: ObservableObject {
    
    @Published var text: String = "시작"
    let manager = DoCatchTryThrowInterDataManager()
    
    func fetchTitle() {
//        let returnedValue = manager.getTitle1()
//        if let newTitle = returnedValue.title {
//            self.text
//        }
//        self.text = newTitle
    }
}


// MARK: - VIEW
struct DoCatchTryThrowInter: View {
    @StateObject var vm: DoCatchTryThrowInterViewModel = .init()
    
    var body: some View {
        Text(vm.text)
            .font(.title)
            .frame(width: 300, height: 300)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .onTapGesture {
                vm.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThrowInter()
}
