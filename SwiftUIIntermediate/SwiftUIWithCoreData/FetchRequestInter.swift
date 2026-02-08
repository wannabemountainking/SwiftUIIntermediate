//
//  FetchRequestInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 2/8/26.
//

import SwiftUI
import CoreData


struct FetchRequestInter: View {
    
    // Environment로 container.viewContext 연결
    @Environment(\.managedObjectContext) private var viewContext

    // @FetchRequest -> Core data <-> SwiftUI View와 직접 연결
    @FetchRequest(
        entity: FishEntity.entity(),
        // 정리한 데이터를 불러올 수 있음 -> 새로 생기는 우럭도 오름차순으로 정리됨
        sortDescriptors: [NSSortDescriptor(keyPath: \FishEntity.name, ascending: true)]
    )
    var fishes: FetchedResults<FishEntity>
    
    @State private var text: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                List {
                    TextField("새로운 생선을 입력하세요", text: $text)
                        .withDefaultTextField()
                    
                    Button {
                        //action
                        addItem()
                    } label: {
                        Text("추가하기")
                    }
                    .withDefaultButtonFormat(backgroundColor: Color.green)
                    
                    ForEach(fishes) { fish in
                        Text(fish.name ?? "")
                            .onTapGesture {
                                updateItem(fish: fish)
                            }
                    } //:LOOP
                    .onDelete(perform: deleteItems)
                } //:LIST
                .listStyle(.plain)
            } //:VSTACK
            .navigationTitle("Fish Market")
        } //:NAVIGATION
    }//:body
    
    // MARK: - CRUD Functions
    // SAVE
    private func saveItem() {
        do {
            try viewContext.save()
        } catch {
            print("ERROR SAVE DATA: \(error.localizedDescription)")
        }
    }

    // ADD
    private func addItem() {
        withAnimation(.spring()) {
            let newFish = FishEntity(context: viewContext)
            newFish.name = text
            saveItem()
            // 저장하고 나서 다시 blank 만들기
            text = ""
        }
    }

    private func deleteItems(offsets: IndexSet) {
        // indexSet에서 index를 뽑으면 옵셔널이므로 guard let 사용
        guard let index = offsets.first else {return}
        
        // fishes에서 선택한 item을 고르고 delete 하기
        let selectedFish = fishes[index]
        viewContext.delete(selectedFish)
        
        //  지우고 나서 저장하기
        saveItem()
    }
    
    // UPDATE
    private func updateItem(fish: FishEntity) {
        withAnimation(.spring()) {
            guard let currentName = fish.name else {return}
            let newName = currentName + "~~"
            fish.name = newName
            saveItem()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    FetchRequestInter()
        .environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext
        )
}


// MARK: - ViewModifier

struct DefaultTextField: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(.leading)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
    }
}

extension View {
    func withDefaultTextField() -> some View {
        self.modifier(DefaultTextField())
    }
}
