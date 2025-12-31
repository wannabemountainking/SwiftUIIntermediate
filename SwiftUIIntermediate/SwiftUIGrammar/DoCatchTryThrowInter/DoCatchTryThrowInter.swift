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
    let isActive: Bool = true
    
    func getTitle1() -> (title: String?, error: Error?) {
        if isActive {
            return ("새로운 데이터 다운로드 완료", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    // Result 를 사용할 때 Generic을 써서 타입을 지정해 주기
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("새로운 데이터 다운로드 완료")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    // throws를 적어주면 error도 같이 리턴하라는 의미
    func getTitle3() throws -> String {
//        if isActive {
//            return "새로운 데이터 다운로드 완료"
//        } else {
            throw URLError(.badURL)
//        }
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "마지막 데이터 다운로드 완료"
        } else {
            throw URLError(.badURL)
        }
    }
}

// MARK: - VIEWMODEL
class DoCatchTryThrowInterViewModel: ObservableObject {
    
    @Published var text: String = "시작"
    let manager = DoCatchTryThrowInterDataManager()
    
    func fetchTitle1() {
        let returnedValue = manager.getTitle1()
        
        if let newTitle = returnedValue.title {
            self.text = newTitle
        } else if let error = returnedValue.error {
            self.text = error.localizedDescription
        }
    }
    
    func fetchTitle2() {
        let result = manager.getTitle2()
        
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
    }
    
    // errror가 발생하는 throw가 return 될 때는 try 를 쓰라고 표시함
    // do catch 구문을 사용하면 "do 부분에는 return 된 값"이 "catch 되는 값은 throw return된 값"이 각각 자동으로 들어감
    func fetchTitle3() {
        do {
//            let newTitle = try manager.getTitle3()
//            self.text = newTitle
            let newTitle = try? manager.getTitle3()
            if let newTitle {
                self.text = newTitle
            }
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
        } catch let error {
            self.text = error.localizedDescription
        }
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
//                vm.fetchTitle1()
//                vm.fetchTitle2()
                vm.fetchTitle3()
            }
    }
}

#Preview {
    DoCatchTryThrowInter()
}
