//
//  MatchedGeometryEffectInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 2/5/26.
//

import SwiftUI

struct MatchedGeometryEffectInter: View {
    
    @State private var isToggled: Bool = false
    
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !isToggled {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 100)
                //matchedGeometryEffect를 사용하려면 id와 namespace필요
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
            }

//                .offset(y: isToggled ? UIScreen.main.bounds.height * 0.7 : 0)
            Spacer()
            
            if isToggled {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 100)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
            }
        } //:VSTACK
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)
        .onTapGesture {
            withAnimation(.spring()) {
                isToggled.toggle()
            }
        }
    }
}


struct MatchedGeomtryEffectInter2: View {
    
    let categories: [String] = ["홈", "한식", "중식", "양식", "일식"]
    @State private var selectedItem: String = ""
    
    @Namespace private var namespace2
    
    var body: some View {
        ScrollView {
            HStack {
                ForEach(categories, id: \.self) { item in
                    ZStack {
                        if selectedItem == item {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green)
                                .matchedGeometryEffect(id: "food_category", in: namespace2)
                                .frame(width: 40, height: 2)
                                .offset(y: 15)
                        }
                        Text(item)
                    } //:ZSTACK
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedItem = item
                        }
                    }
                } //:LOOP
            } //:HSTACK
            .padding()
        } //:SCROLL
    }//: body
}

#Preview {
    MatchedGeometryEffectInter()
}

#Preview {
    MatchedGeomtryEffectInter2()
}
