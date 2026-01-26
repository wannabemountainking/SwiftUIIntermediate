//
//  DragGestureInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 1/30/26.
//

import SwiftUI

struct DragGestureInter: View {
    
    // offset: 기준이 되는 주소(위치)에 더해지는 값. View타입에서 x, y축 값 입력을 통해서 View의 위치를 조정할 수 있음
    // type CGSize 에서 .zero는 x: 0, y: 0 위치라는 의미
    
    /* -> My Opinion
     offset 변수는 위치를 계속 바꾸는 드레그 포인트
     */
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(offset.width)")
                Spacer()
            } //:VSTACK
            
            /* -> Method/Modifier 설명
             도형.offset(위치 CGSize): 객체를 띄워서 해당 위치로 이동시킴
                - 원래 위치공간은 도형이 없어도 차지한 것이되어 다른 뷰가 못들어감
                - 다른 뷰가 아래에 있어 겹칠 수 있음
             도형.scaleEffect(): 뷰의 보이는 크기를 확대하거나 축소하는 modifier
                - 1.0 원래크기 0.5 절반크기 ...음수의 경우 뷰가 뒤집힘
                - offset처럼 **레이아웃 공간은 원래 크기 그대로** 유지
                - anchor 파라미터는 확대 축소 시에 고정되는 점임.
             도형.gesture(여기에 Gesture 프로토콜을 채택한 객체): 파라미터로 Gesture protocol 채택 객체 사용
                - Gesture 프로토콜을 채택한 구조체 들: TapGesture, DragGesture, LongPressGesture, MagnificationGesture, RotationGesture 등
                - .gesture()는 '탈 것 주차장'이고 DragGesture, TapGesture 등은 자전거, 기차 같은 구체적 탈것
                - DragGesture().onChanged { value in ... } 위치가 변하면 무슨 일이 생기나
                - DragGesture().onEnded {value in ...} 드레그가 끝나면 무슨 일이 생기나
             */
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                offset = value.translation
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        })
                )
        } //:ZSTACK
    }//:body
    
    // MARK: - Function
    private func getScaleAmount() -> CGFloat {
        let maxWidth = UIScreen.main.bounds.width / 2
        // 절대값으로 abs 메서드 사용
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / maxWidth
        // 줄어들다가 최소값이 0.5만큼만 줄게 함
        return 1.0 - min(percentage, 0.5)
    }
}

struct DragGestureInter2: View {
    
    @State private var startOffsetY: CGFloat = UIScreen.main.bounds.height * 0.8
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            // 초기화면
            FrontView()
            
            // 로그인 화면
            LoginView()
                .offset(y: startOffsetY)
                .offset(y: currentDragOffsetY)
                .offset (y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                withAnimation(.spring()) {
                                    if currentDragOffsetY < -150 {
                                       //cancel offset
                                         endingOffsetY = -startOffsetY
                                    } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                        endingOffsetY = 0
                                    }
                                }
                            }
                        })
                )
        } //:ZSTACK
    }//:body
}

// MARK: - Extention
struct FrontView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Swift World")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 70)
            
            Image(systemName: "swift")
                .resizable()
                .foregroundStyle(.pink.opacity(0.7))
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Swift World에 오신 여러분 환영합니다.")
                .multilineTextAlignment(.center)
            
            Button {
                //action
            } label: {
                Text("Guest로 로그인하기")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .padding(10)
                    .padding(.horizontal)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Spacer()
        } //:VSTACK
        .frame(maxWidth: .infinity)
        .background(Color.green)
        .ignoresSafeArea()
    }//:body
}

struct LoginView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("위로 드레그해서 로그인하기")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom)
            
            Text("Login")
                .font(.title)
                .padding()
            
            TextField("ID", text: $id)
                .padding()
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            SecureField("PASSWORD", text: $password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            
            Button {
                //action
            } label: {
                Text("로그인")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
            }

            Spacer()
            
            Text("아래로 드레그 해서 창 닫기")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom)
            
            Image(systemName: "chevron.down")
                .padding(.bottom)
        } //:VSTACK
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }//:body
}

#Preview {
    DragGestureInter()
}

#Preview {
    DragGestureInter2()
}
