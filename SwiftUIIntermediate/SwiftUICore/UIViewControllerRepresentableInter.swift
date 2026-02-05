//
//  UIViewControllerRepresentableInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 2/7/26.
//

import SwiftUI


// 1. UIViewControllerRepresentable 생성
struct FirstUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    let labelText: String
    
    // UIKit 의 UIViewController 생성. 수정
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIViewController()
        
        // 배경색 설정
        vc.view.backgroundColor = .systemGreen
        // text 넣기
        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.black
        label.frame = vc.view.frame
        vc.view.addSubview(label)
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

// 2. UIImagePickerController 만들기
struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Binding var showScreen: Bool
    
    // 1. UIImagePickerController 생성
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = context.coordinator
        return picker
    }
    
    // 2. SwiftUI -> UIKit update
    func updateUIViewController(_ imagePicker: UIImagePickerController, context: Context) {
        
    }

    // 3. UIKit (Coordinator) -> SwiftUI update
    func makeCoordinator() -> ImagePickerControllerCoordinator {
        return ImagePickerControllerCoordinator(selectedImage: $selectedImage, showScreen: $showScreen)
    }
    
    class ImagePickerControllerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var selectedImage: UIImage?
        @Binding var showScreen: Bool
        
        init(selectedImage: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._selectedImage = selectedImage
            self._showScreen = showScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else {return}
            
            // selectedImage 에 선택된 image 넣기
            selectedImage = image
            
            // image 선택되면 sheet 닫기
            showScreen = false
        }
    }
}


struct UIViewControllerRepresentableInter: View {
    
    @State private var showScreen: Bool = false
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            }
            
            Button {
                //action
                showScreen.toggle()
            } label: {
                Text("Sheet 열기")
                    .withDefaultButtonFormat(backgroundColor: .red)
            }
            .sheet(isPresented: $showScreen) {
//                FirstUIViewControllerRepresentable(labelText: "UIViewController 연결됨")
                UIImagePickerControllerRepresentable(selectedImage: $selectedImage, showScreen: $showScreen)
            }
        }
    }
}

#Preview {
    UIViewControllerRepresentableInter()
}
