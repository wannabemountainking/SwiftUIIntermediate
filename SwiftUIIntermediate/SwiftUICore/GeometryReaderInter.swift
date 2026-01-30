//
//  GeometryReaderInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 1/26/26.
//

import SwiftUI

struct GeometryReaderInter: View {
    var body: some View {
        
        // GeometryReader: 컨텐츠의 크기와 위치가 담긴 GeometryProxy 객체를 후행클로져로 넘겨 초기화하는 함수(후행 클로져)를 초기화로 받는 컨테이너 뷰(View 구조체) 이다.
        // proxy: 그 측정된 위치와 크기를 View에서 사용하고자 할 때 받는 값
        // proxy.size: 컨텐츠의 크기, prozy.frame: 컨텐츠의 위치
        GeometryReader { proxy in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.green)
//                    .frame(width: UIScreen.main.bounds.width * 0.6)
                    .frame(width: proxy.size.width * 0.7)
                Rectangle()
                    .fill(Color.blue)
            } //:HSTACK
            .ignoresSafeArea()
        } //:GEOMETRY
    }//:body
}

struct GeometryReaderInter2: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(1..<11) { index in
                    GeometryReader { proxy in
                        Image("NZ\(index)")
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .scaledToFit()
                            .rotation3DEffect(Angle(degrees: getPercentage(geo: proxy)), axis: (x: 0.0, y: 1.0, z: 0.0))
                    } //:GEOMETRY
                    .frame(width: 300, height: 300)
                    .padding()
                } //:LOOP
            } //:HSTACK
        } //:SCROLL
    }//: body
    
    // MARK: - Function
    /*
    // 스와이프 하면 사진의 위치가 변경되는 데 그 변경 위치에 따라 사진을 rotation 시키게 함. GeometryProxy에서 위치를 받아서 위치마다 degrees 각도를 다르게 두어서 좀더 다른 효과를 주는 함수
    func getPercentage(geo: GeometryProxy) -> Double {
        // 1. 스크린 전체의 절반 값(이게 거리상 최대거리 양수, 음수가 나옴)
        let maxDistance = geo.size.width / 2
        // 2. 사진의 현재 위치: currentX(currentY는 의미 없음)
        // currentX를 구하기 위해 GeometryProxy.frame(in: .global) 메서드로 전체 스크린에서의 사진의 위치를 구할 수 있고 midX 로 사진 중앙의 점이 화면에 어디에 있는 지 확인 가능
        let currentX = geo.frame(in: .global).midX
        
        // 3. return 값으로 사진 가운데 기준으로 right, left에 다른 값을 설정
        return (1 - (currentX / maxDistance)) * 15
    }
     */
    func getPercentage(geo: GeometryProxy) -> Double {
        // 1. 화면 중앙 x 좌표
        let screenCenter = geo.size.width / 2
        // 2. 사진의 중앙 x 좌표
        let photoCenter = geo.frame(in: .global).midX
        // 3. 1과 2의 거리 (offset)
        let offset = screenCenter - photoCenter // (<- 이 방향이니까)
        // 4. 정규화 (normalized): 범위 맞추기 -1 ~ 1로
        let normalizedOffset = offset / screenCenter
        // 5. 각도 변환 ~= 원근감 주기
        let maxRotation = 20.0
        return normalizedOffset * maxRotation
    }
}

#Preview {
    GeometryReaderInter()
}

#Preview {
    GeometryReaderInter2()
}
