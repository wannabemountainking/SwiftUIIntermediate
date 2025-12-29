//
//  IfLetGuardInterExercise.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 12/29/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct IfLetGuardInterExercise: View {
    @State private var textDisplayed: String?
    @State private var currentUser: String? = "John"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("if let & guard let 연습")
                    .font(.custom("Verdana", size: 20).bold())
                
                if let text = textDisplayed {
                    Text(text)
                        .font(.title2)
                } else {
                    ProgressView()
                        .font(.title2)
                }
                
                Spacer()
            } //:VSTACK
            .navigationTitle("Optional 처리하기")
//            .onAppear {
//                withAnimation(.easeInOut(duration: 0.5)) {
//                    loadData()
//                }//: withAnimation
//            }//: .onAppear
            .task {
                try? await asyncLoadData()
            }
        } //:NAVSTACK
    }//: body
    
//    private func loadData() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            guard let user = currentUser else {
//                textDisplayed = "Error, 로그인이 되지 않았습니다"
//                return
//            }//: guard let
//            textDisplayed = "데이터를 성공적으로 가져왔습니다\n당신의 이름은 \(user) 입니다"
//        }// : DispatchQueue main asyncAfter
//    }//: func
    
    private func asyncLoadData() async throws {
        try? await Task.sleep(for: .seconds(3))
        guard let user = currentUser else {
            textDisplayed = "Error, 로그인이 되지 않았습니다"
            return
        }
        textDisplayed = "데이터를 성공적으로 가져왔습니다\n당신의 이름은 \(user) 입니다"
    }
}

@available(iOS 16.0, *)
#Preview {
    IfLetGuardInterExercise()
}
