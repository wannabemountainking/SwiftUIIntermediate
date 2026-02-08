//
//  CoreDataInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 2/8/26.
//

import SwiftUI
import CoreData
import Combine


// @FetchRequest 를 사용하지 않고 View와 Business Logic 을 분리해서 작성하기 => MVVM 방식에서 사용

// MARK: - ViewModel
class CoreDataInterViewModel: ObservableObject {
    
    // core data container 선언
    let container: NSPersistentContainer
    
    // Core Data에 fetch해서 불러오ㅠㄴ 것을 View로 넘기기 위한 변수
    @Published var savedEntities: [Fish] = []
    
    // 최소한의 초기화
    init() {
        container = NSPersistentContainer(name: "FishContainer")
        container.loadPersistentStores { (description, error) in
            if let error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("SUCCESSFULLY LOADED CORE DATA. \(description)")
                self.fetchFish()
            }
        }
    }
    
    // MARK: - Fetch, SAVE, CRUD Functions
    // 1. Core Data에서 데이터 가져오기(model 목록표 가져오기)
    func fetchFish() {
        // core data 접근
        let request = NSFetchRequest<Fish>(entityName: "Fish")
        //container에 request 한 것을 Fetch 하기
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA: \(error)")
        }
    }
    
    // 2.Core Data 저장하기
    func saveData() {
        do {
            try container.viewContext.save()
            //저장할 때마다 Context의 저장 내용을 다시 저장해야 함. 그리고 savedEntities는 Context에 없기 때문에 항상 수동으로 fetchFish 로 갱신해줘야 함
            fetchFish()
        } catch {
            print("ERROR SAVING DATA: \(error)")
        }
    }
    
    // 3. Core Data ADD
    func addFish(text: String) {
        let newFish = Fish(context: container.viewContext)
        newFish.name = text
        saveData()
    }
    
    // 4. Delete Core Data
    func deleteFish(offsets: IndexSet) {
//        offsets.map { savedEntities[$0] }.forEach(container.viewContext.delete)
//        saveData()
        
        // index 가져오기
        guard let index = offsets.first else { return }
        // savedEntities 중의 index 번호에서 entity 지정
        let entity = savedEntities[index]
        // container에 viewContext 에서 entity 에 맞게 delete
        container.viewContext.delete(entity)
        // 삭제 후 변경된 사항 저장
        saveData()
    }
    
    // 5. UPDATE CORE DATA
    func updateFish(fish: Fish) {
        // 현제 이름 가져오고
        let currentName = fish.name ?? ""
        // 클릭하면 ~ 추가
        let newName = currentName + "~"
        // 추가된 것을 다시 fish.name에 지정
        fish.name = newName
        // Context 저장
        saveData()
    }
}


// MARK: - View

struct CoreDataInter: View {
    
    @StateObject private var vm: CoreDataInterViewModel = .init()
    @State private var tfText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("새로운 생선을 입력하세요", text: $tfText)
                    .withDefaultTextField()
                Button {
                    // textfield에 text가 있을 때만 vm.addFish() 실행
                    guard !tfText.isEmpty else {return}
                    vm.addFish(text: tfText)
                    // 추가 후에 다시 tfText 초기화
                    tfText = ""
                } label: {
                    Text("추가히기")
                        .withDefaultButtonFormat(backgroundColor: .green)
                }

                List {
                    ForEach(vm.savedEntities) { fish in
                        Text(fish.name ?? "이름 없음")
                            .onTapGesture {
                                vm.updateFish(fish: fish)
                            }
                    } //:LOOP
                    .onDelete(perform: vm.deleteFish)
                } //:LIST
                .listStyle(.plain)
            } //:VSTACK
            .navigationTitle("Fish Market")
        } //:NAVIGATION
    } //:BOX
}

#Preview {
    CoreDataInter()
}
