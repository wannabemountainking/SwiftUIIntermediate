//
//  BackgroundThreadInter.swift
//  SwiftUIIntermediate
//
//  Created by yoonie on 12/29/25.
//

import SwiftUI
import Combine

// MARK: - ViewModel
class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        // Background thread에서 작동하기
        DispatchQueue.global().async {
            let newData = self.downloadData()
            // 어디 thread에서 작동하고 있는지 출력하기
            print("Check 1: 메인쓰레드인가? \(Thread.isMainThread)")
            print("Check 1: 지금 쓰레드는? \(Thread.current)")
            
            // Main thread 에서 작동하기
            DispatchQueue.main.async {
                self.dataArray = newData
                // 어디 thread에서 작동하고 있는지 출력하기
                print("Check 2: 메인쓰레드인가? \(Thread.isMainThread)")
                print("Check 2: 지금 쓰레드는? \(Thread.current)")
            }
        }
    }
    
//    func fetchData() async {
//        let newData = await Task.detached {
//            await self.downloadData()
//        }.value
//        self.dataArray = newData
//    }
    
    private func downloadData() /*async*/ -> [String] {
        // sample data
        let data: [String] = Array(0..<1000).map({ "\($0)" })
//        var data: [String] = []
//        for i in 0..<1000 {
//            data.append("\(i)")
//            print(data)
//        }
        return data
    }
}

struct BackgroundThreadInter: View {
    @StateObject var vm: BackgroundThreadViewModel = .init()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                Text("데이터 로드")
                    .font(.title)
                    .fontWeight(.bold)
                    .onTapGesture {
//                        Task {
                           /* await*/ vm.fetchData()
//                        }
                    }
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }//: Loop
            } //:VSTACK
        } //:SCROLL
    }//: body
}

#Preview {
    BackgroundThreadInter()
}
