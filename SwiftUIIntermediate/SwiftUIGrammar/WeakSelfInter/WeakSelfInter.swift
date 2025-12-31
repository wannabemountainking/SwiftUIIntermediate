//
//  WeakSelfInter.swift
//  SwiftUIIntermediate
//
//  Created by yoonie on 12/29/25.
//

import SwiftUI
import Combine

// MARK: - ViewModel : data 를 담는 구조체
class WeakSelfInterViewModel: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("초기화 시작")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("초기화 해제")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    private func getData() {
        
        // 100초 뒤에 작업이 실행된다고 딜레이를 가상으로 주고 데이터가 업데이트 된다고 가정하면 초기화 해제가 일어나지 않음
        
        /*
         Strong Reference 예시
         
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            // UI 업데이트를 할 것이므로 main thread에서 작업이 진행되어야 함
            DispatchQueue.main.async {
                // 기본적으로 self.data는 Strong Reference가 됨(기본값)
                self.data = "NEW DATA!"
            }
        }
         */
        
        // Weak Reference 예시
        DispatchQueue.main.asyncAfter(deadline: .now() + 100) { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async {
                // weak reference로 할 때는 optional 값으로 참조함으로 self 뒤에 ? 붙여줘야 함 그래서 guard let으로 없앰
                self.data = "NEW DATA"
                
            }
        }
        
    }
}

// MARK: - SCREEN 1
@available(iOS 16.0, *)
struct WeakSelfInter: View {
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationStack {
            NavigationLink("2번째 페이지로 이동", destination: {
                WeakSelfInter2()
            })
            .navigationTitle("1번째 페이지")
        } //:NAVSTACK
        .overlay(alignment: .topTrailing) {
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
        }
    }
}

// MARK: - SCREEN 2
@available(iOS 16.0, *)
struct WeakSelfInter2: View {
    @StateObject var vm: WeakSelfInterViewModel = .init()
    var body: some View {
        VStack {
            Text("2번째 페이지")
                .font(.largeTitle)
                .foregroundColor(.red)
        } //:VSTACK
        
        // data에 String타입의 요소가 있는 경우 등 처리
        if let data = vm.data {
            Text(data)
        }
    }//: body
}

@available(iOS 16.0, *)
#Preview {
    WeakSelfInter()
}

@available(iOS 16.0, *)
#Preview {
    WeakSelfInter2()
}
