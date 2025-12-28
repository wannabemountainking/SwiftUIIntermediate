//
//  IfLetGuardInter.swift
//  SwiftUIIntermediate
//
//  Created by yoonie on 12/29/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct IfLetGuardInter: View {
    
    // MARK: -  PROPERTY
    @State private var displayText: String? = nil
    @State private var currentUserID: String?

    // MARK: -  BODY
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Safe Code 연습하기")
//                Text(displayText)
//                    .font(.title2)
                // 1. Optional 값을 처리하는 방법1: if let 구문을 써서 text 라는 상수를 선언하고 그것이 displayText 연결
                if let text = displayText { // displayText가 True 즉 nil이 아닐 때
                    Text(text)
                        .font(.title2)
                } else { // displayText 가 false 즉 nil일 때
                    ProgressView()
                        .font(.title2)
                }
                
                Spacer()
            } //:VSTACK
            .navigationTitle("Optional 처리하기")
            .onAppear {  // .onAppear  는 초기화 될 때 실행
//                loadData()
                loadData2()
            }
//            .task {
//                try? await loadData()
//            }
        } //:NAVSTACK
    }//: body
    
    // MARK: -  FUNCTION
    // 3초 뒤에 결과 실행
//    private func loadData() {
//        
//        // loadData하기 전에 currentUserID 체크 -> String인지 nil인지
//        if let userID = currentUserID {
//            // 3초 뒤 실행
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                displayText = "데이터를 성공적으로 가져왔습니다.\n당신의 이름은 \(userID)"
//            }
//        } else { //currentUserID가 nil인 경우
//            displayText = "Error, 로그인이 되지 않았습니다."
//            
//        }
//    }
    
    private func loadData2() {
        //2. Optional 을 처리하는 방법 2: guard문은 먼저 else 부분 즉 nil일 경우 먼저처리하고 끝난 후에 반드시 return 처리를 해줘야 함
        guard let userID = currentUserID else {
            displayText = "Error, 로그인이 되지 않았습니다"
            return
        }
        //else문에 걸리지 않고 return 이 안되면 currentUserID가 nil이 아니기 때문에 String 출력-> 다음 코드가 실행이 됨
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) {
            displayText = "데이터를 성공적으로 가져왔습니다.\n당신의 이름은 \(userID)"
        }
    }
    
//    private func loadData() async throws {
//        try? await Task.sleep(for: .seconds(3))
//        displayText = "데이터를 성공적으로 가져왔습니다."
//    }
}

// MARK: -  PREVIEW
@available(iOS 16.0, *)
#Preview {
    IfLetGuardInter()
}
