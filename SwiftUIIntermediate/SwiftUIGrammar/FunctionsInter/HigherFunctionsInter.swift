//
//  HigherFunctionsInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 12/29/25.
//

import SwiftUI
import Combine

// MARK: - Model
struct UserModel: Identifiable {
    let id = UUID()
    let name: String?
    let points: Int
    let isChecked: Bool
}

// MARK: - ViewModel
class UserViewModel: ObservableObject {
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilterArray()
    }
    
    private func getUsers() {
        let user1 = UserModel(name: "Jacob", points: 88, isChecked: true)
        let user2 = UserModel(name: "Chris", points: 99, isChecked: false)
        let user3 = UserModel(name: "Ammanda", points: 75, isChecked: true)
        let user4 = UserModel(name: "Emma", points: 56, isChecked: true)
        let user5 = UserModel(name: "Jason", points: 34, isChecked: false)
        let user6 = UserModel(name: "Sarah", points: 59, isChecked: true)
        let user7 = UserModel(name: "Lisa", points: 100, isChecked: false)
        let user8 = UserModel(name: "John", points: 32, isChecked: true)
        let user9 = UserModel(name: "Steve", points: 45, isChecked: false)
        let user10 = UserModel(name: "Peter", points: 72, isChecked: true)
        
        dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5, user6, user7, user8, user9, user10
        ])
    }
    
    private func updateFilterArray() {
        // 1. Sort
        /*
         sorted: 원본 dataArray를 건드리지 않고 사본을 만들어서 정렬한 수를 return 하는 것
         filteredArray = dataArray.sorted(by: { (user1, user2) -> Bool in
            return user1.points < user2.points // 오름차순
        })
         축약버전
         클로저 축약으로 return 도 생략되었고, $0가 user1, 다음인. $1은 user2를 가리킴
         filteredArray = dataArray.sorted(by: { $0.points < $1.points })
         
         */
        
        // 2. Filter
        /*
         filter는 array 안에 값들을 하나씩 보면서 조건에 맞는 값들만 나타내는 것
         filteredArray = dataArray.filter({ user in
            return user.points > 50
            return user.isChecked
            return user.name.contains("i")
         })
         축약버전 + sort 응용
         filteredArray = dataArray.filter({ $0.isChecked }).sorted(by: { $0.points > $1.points })
         */
        
        // 3. Map
        // map의 경우에는 dataArray의 각 요소를 변형할때 많이 사용
        // [UserModel]에서 name 만 뽑아내서 [String] 만들 수 있음 -> 특정 값만 추출하기
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name ?? "이름 없음
//        })
//        mappedArray = dataArray
//            .map({ $0.name })
//            .filter({ $0.contains("a") })
//            .sorted(by: { $0 < $1 })
        // 추가: CompactMap
//        mappedArray = dataArray.compactMap({ (user) -> String? in
//            return user.name
//        })
        // 축약
        mappedArray = dataArray.compactMap({ $0.name })
    }
}

// MARK: - View
@available(iOS 16.0, *)
struct HigherFunctionsInter: View {
    
    //property
    @StateObject var vm: UserViewModel = .init()
//    @StateObject var vm: UserViewModel = UserViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
//                    ForEach(vm.filteredArray, id: \.self) { user in
//                        VStack(alignment: .leading) {
//                            Text(user.name)
//                                .font(.headline)
//                            HStack {
//                                Text("점수\(user.points)")
//                                Spacer()
//                                if user.isChecked {
//                                    Image(systemName: "checkmark.seal.fill")
//                                } //:CONDITIONAL
//                            } //:HSTACK
//                        }//: VStack
//                        .foregroundStyle(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .padding(.horizontal)
//                    }//: Loop
                    
                    // map 일때 -> [String] 이라 Model 에서 id 값이 없기 때문에 id 값을 해줘야 함. \.self
                    ForEach(vm.mappedArray, id: \.self) { name in
                        Text(name)
                            .font(.title)
                    }
                } //:VSTACK
            } //:SCROLL
            .navigationTitle("학생 시험 성적표")
        } //:NAVSTACK
    }
}

@available(iOS 16.0, *)
#Preview {
    HigherFunctionsInter()
}
