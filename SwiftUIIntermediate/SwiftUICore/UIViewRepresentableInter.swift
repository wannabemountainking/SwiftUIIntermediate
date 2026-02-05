//
//  UIViewRepresentableInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 2/6/26.
//

import SwiftUI


struct FirstUIViewRepresentable: UIViewRepresentable {
    
    // UIKit의 UIVIew를 생성하는 함수
    func makeUIView(context: Context) -> some UIView {
        let view = UIView() // UIView 초기화
        view.backgroundColor = .green
        return view // UIView 리턴
    }
    
    // SwiftUI -> UIKit으로 보내는 것으로 UIKit에 update를 요청함
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}


struct UITextFieldRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    
    let placeholder: String
    let placeholderColor: UIColor
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    //SwiftUI -> UIKit으로 데이터 알림(전달)
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor : placeholderColor
        ])
        textField.attributedPlaceholder = placeholder
        return textField
    }
    
    // Coordinator는 UIKit -> SwiftUI로 데이터 전달. UIKit의 Delegate 의 역할을 함.
    func makeCoordinator() -> UITextFieldCoordinator {
        return UITextFieldCoordinator(text: $text)
    }
    
    class UITextFieldCoordinator:NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}


struct UIViewRepresentableInter: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            HStack(spacing: 20) {
                Text("SwiftUI")
                TextField("SwiftUI TextField", text: $text)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            } //:HSTACK
            
            HStack {
                Text("UIKit")
                UITextFieldRepresentable(text: $text, placeholder: "UIKit TextField", placeholderColor: UIColor.red)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        } //:VSTACK
        .padding()
    }//:body
}

#Preview {
    UIViewRepresentableInter()
}
