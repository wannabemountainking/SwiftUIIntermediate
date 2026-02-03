//
//  ViewBuilderMaking.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 2/3/26.
//

import SwiftUI

struct ViewBuilderInter: View {
    var body: some View {
        VStack {
            HeaderComponent(title: "일반적인 Component 사용", description: "Component 사용해서 사용되지 않는 것들은 optional 처리해 줌", iconName: "gear")
            HeaderComponent(title: "일반적인 Component 시용2", description: nil, iconName: nil)
            
//            // 2번 Generic 적용 -> View를 명시하지 않아도 되는 제네릭 뷰를 넣을 수 있음
//            // content 는. View 타입이기 때문에 View 에서 사용할 수 있는 것을 다 사용할 수 있음
//            HeaderGeneric(title: "Generic Component1", content: Text("Generic 을 사용해서 필요할 때마다 사용할 수 있음"))
//            HeaderGeneric(title: "Generic Component2", content: Image(systemName: "camera"))
//            HeaderGeneric(title: "Generic Component3", content: HStack {
//                Text("Stack 도 사용해서 여러가지 내용을 넣을 수 있습니다")
//                Image(systemName: "photo.stack")
//            })
            
            // 3. @ViewBuilder 사용하기 -> 여러 뷰를 직관적으로 잘 사용할 수 있음
            // content를 Content return 할 수 있게 function을 만들어서 보다 쉽게 View를 사용할 수 있게 됨
            // --> 클로저 안에서 content 를 쉽게 만들 수 있음
            HeaderGeneric(title: "@ViewBuilder Component") {
                HStack {
                    Text("ViewBuilder 사용해보기")
                    Image(systemName: "building")
                }
            }
            
            // 4. ViewBuilder 커스터마이징한 것 사용하기
            CustomHStack {
                Text("Hello")
                Text("boy")
            }
            
            HStack {
                Text("Hello")
                Text("boy")
            }
            
            Spacer()
        
        }
    }
}

// TODO: 1. 이전까지의 View를 따로 만들어서 component 단위로 사용하기(기존 방식 ->View)
struct HeaderComponent: View {
    let title: String
    var description: String?
    var iconName: String?
    
    var body: some View {
        // 1. Header 만들기
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                
                if let description = description {
                    Text(description)
                        .font(.body)
                }
                
                if let iconName = iconName {
                    Image(systemName: iconName)
                }
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
            } //:VSTACK
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        } //:VSTACK
    }//:body
}

// TODO: 2. Generic을 사용해서 Component 사용하기
struct HeaderGeneric<Content: View>: View {
    let title: String
    let content: Content
    
    // TODO: 3.  Generic을 좀 더 확장해서 사용하기 -> @ViewBuilder 사용하기 => generic 에서 삽입되는 View를 후행 클로져로 편하게 만들어줌.
    // 초기화 해주고 content에서 ViewBuilder 선언하기
    // content 안에 function 사용할 수 있는 클로져를 만들고 Content를 return 해주기 ??
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()   // content()로 해서 함수 초기화
    }
    
    var body: some View {
        // 1. Header 만들기
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                
                content

                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
            } //:VSTACK
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        } //:VSTACK
    }
}

// TODO: 4. ViewBuilder 커스터마이징하기
struct CustomHStack<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}

// TODO: 5. Local ViewBuilder 사용하기
struct LocalViewBuilder: View {
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            
        }
    }
    
    @ViewBuilder private var numberPlate: some View {
        switch type {
        case .one:
            view1
        case .two:
            view2
        case .three:
            view3
        }
    }
    
    private var view1: some View {
        Text("Number1")
    }
    
    private var view2: some View {
        VStack {
            Text("Number2")
            Image(systemName: "2.circle")
        }
    }
    
    private var view3: some View {
        Image(systemName: "3.circle")
    }
}

#Preview {
    ViewBuilderInter()
}
#Preview {
    LocalViewBuilder(type: .one)
}

