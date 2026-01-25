//
//  ScrollViewReaderInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 1/25/26.
//

import SwiftUI

struct ScrollViewReaderInter: View {
    @State private var indexScrollTo: Int = 0
    @State private var textFieldText: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            
            TextField(" 이동할 박스 #번호를 입력하세요", text: $textFieldText)
                .font(.headline)
                .frame(height: 35)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .keyboardType(.numberPad)
            
            Button {
                //acton
                if let textToInt = Int(textFieldText) {
                    indexScrollTo = textToInt
                } else {
                    showAlert = true
                }
            } label: {
                Text("이동하기")
            }

            
            ScrollView(.vertical, showsIndicators: false) {
                // 여기서 ScrollViewProxy scrollView에서 id를 기반으로 item 위치를 추적해주는 것이다. item의 id 값을 알면 ScrollViewProxy 객체가 메서드로 이동시켜줌.
                ScrollViewReader { proxy in
    //                Button {
    //                    //action
    //                    withAnimation(.spring()) {
    //                        proxy.scrollTo(30, anchor: .top)
    //                    }
    //                } label: {
    //                    Text("여기를 클릭하면 30번 박스로 이동합니다.")
    //                }
                    
                    
                    ForEach(1..<51) { index in
                        Text("이 박스의 번호는 # \(index) 입니다")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10)
                            .padding()
                            // 각각의 id에 index값을 주어서 proxy가 index를 통해 id로 item의 위치를 찾아가게 함
                            .id(index)
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderInter()
}
