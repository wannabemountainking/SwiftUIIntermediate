//
//  MatchedGeometryEffectInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 2/5/26.
//

import SwiftUI

struct MatchedGeometryEffectInter: View {
    
    @State private var isToggled: Bool = false
    
    var body: some View {
        VStack {
            if !isToggled {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 100)
                //matchedGeometryEffect를 사용하려면 id와 namespace필요
            }

//                .offset(y: isToggled ? UIScreen.main.bounds.height * 0.7 : 0)
            Spacer()
            
            if isToggled {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 100)
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

#Preview {
    MatchedGeometryEffectInter()
}
