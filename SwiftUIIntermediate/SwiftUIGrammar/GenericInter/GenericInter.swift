//
//  GenericInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 12/31/25.
//

import SwiftUI
import Combine

// MARK: - Model
//SwiftUI의 특징(모델이 사라지고 다시 생성되면 화면이 바뀐다)을 반영하여 struct의 불변성의 유지와 화면 바꾸기를 할 수 있는 구조체를 만든 것으로 보임(기존 인스턴스(삭제되겠지)는 안건드리고 새로 생성)
struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        return StringModel(info: nil)
    }
}

// case 1. Model에서 Bool값을 추가하려고 할 때, 단순하게 struct 하나 더 만들어서 사용하기
// 이렇게 하면 반복적으로 불필요한 code를 만들고, struct를 다시 만들었기 때문에 메모리 낭비 -> 앱속도 저하

struct BoolModel {
    let info: Bool?
    
    func removeInfo() -> Self {
        return BoolModel(info: nil)
    }
}

// case 2. Generic 사용하기
// Generic Type 을 사용하게 되면 결국 anyType 혹은 T 타입으로 생성하기
// 실전에서는 anyType을 통일되게 사용하기 위해서 대문자 T 로 표시

struct GenericModel<T> {
    let info: T?
    
    func removeInfo() -> GenericModel {
        return GenericModel(info: nil)
    }
}

// case 3. 그렇다면 View 타입에서 Generic은 어떻게 사용해야 되는 걸까?
// Generic View에서 content를 anyType으로 설정하는데 이것을 특정 type 되게 지정해줄수 있습니다.
// 그래서 content를 사용할 때 View type 사용 가능
struct GenericView<T: View>: View {
    let title: String
    let content: T
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

// MARK: - ViewModel
class GenericInterViewModel: ObservableObject {
    @Published var stringModel2 = StringModel(info: "Hello, World")
    @Published var boolModel2 = BoolModel(info: true)
    @Published var genericStringModel = GenericModel(info: "Hello, swift")
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        self.stringModel2 = stringModel2.removeInfo()
        self.boolModel2 = boolModel2.removeInfo()
        self.genericStringModel = genericStringModel.removeInfo()
        self.genericBoolModel = genericBoolModel.removeInfo()
    }
}


// MARK: - View
struct GenericInter: View {
    @StateObject var vm: GenericInterViewModel = .init()
    
    var body: some View {
        VStack(spacing: 20) {
            GenericView(title: "GenericView", content: Text("New Contents"))
            
            Divider()
            
            VStack(spacing: 20) {
                Text("1. 일반적인 반복되는 Model 예시")
                    .font(.title2)
                Text(vm.stringModel2.info ?? "NO DATA")
                Text(vm.boolModel2.info?.description ?? "NO DATA")
            } //:VSTACK
            
            Divider()
            
            VStack(spacing: 20) {
                Text("2. Generic  사용함")
                    .font(.title2)
                Text(vm.genericStringModel.info ?? "NO DATA")
                Text(vm.genericBoolModel.info?.description ?? "NO DATA")
            } //:VSTACK
        } //:VSTACK
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    GenericInter()
}
