//
//  ViewModifierInter.swift
//  SwiftUIIntermediate
//
//  Created by yoonie on 2/4/26.
//

import SwiftUI


//TODO: 2. ViewModifier 만들기(커스텀제작)
struct DefaultButtonModifier: ViewModifier {
    
    // TODO: backgroundColor 다르게 적용하기
    let backgroundColor: Color
    // ViewModifier 의 안에서 body를 넣어줘야 하는데 일반적인 body가 아니라 some View를 리턴하는 함수 형태의 body가 필요하다.
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(.white)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10)
            .padding()
    }
    
}

struct ViewModifierInter: View {
    var body: some View {
        VStack {
            
            // 1. 일반적인 버튼 만들기
            Button {
                //action
                
            } label: {
                Text("ViewModifier 연습하기 1")
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 10)
                    .padding()
            }

            Button {
                //action
                
            } label: {
                Text("ViewModifier 연습하기 2")
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 10)
                    .padding()
            }
            
            Button {
                //action
                
            } label: {
                Text("ViewModifier 연습하기 3")
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 10)
                    .padding()
            }
            
            //TODO: ViewModifier 사용법
            Button {
                //action
            } label: {
                Text("ViewModifier 연습 4")
//                    .modifier(DefaultButtonModifier(backgroundColor: .yellow))
                    .withDefaultButtonFormat(backgroundColor: .pink)
            }

        }
    }
}

// TODO: 3. Extension을 사용해서 Modifier 쉽게 적용하기
extension View {
    func withDefaultButtonFormat(backgroundColor: Color) -> some View {
        self.modifier(DefaultButtonModifier(backgroundColor: backgroundColor))
    }
}

#Preview {
    ViewModifierInter()
}
