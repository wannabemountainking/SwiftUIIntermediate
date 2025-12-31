//
//  TypealiaseInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 12/31/25.
//

import SwiftUI

// MARK: - MODEL
struct MovieModel: Identifiable {
    let id = UUID()
    let title: String
    let director: String
    var count: Int
}

//struct TVModel: Identifiable {
//    let id = UUID()
//    let title: String
//    let director: String
//    var count: Int
//}

// typealias를 사용하여 MovieModel에 있는 내용을(properties) reference해서  TVModel 에서 그대로 사용할 수 있게 되는 것임
typealias TVModel = MovieModel

// MARK: - VIEW
struct TypealiaseInter: View {
    @State private var movieModel = MovieModel(title: "영화 제목 1", director: "Yoonie", count: 10)
    @State private var tvModel = TVModel(title: "드라마 제목 1", director: "John", count: 3)
    
    var body: some View {
        VStack(spacing: 20) {
            Text(movieModel.title)
            Text(movieModel.director)
            Text("\(movieModel.count)")
        } //:VSTACK
        
        Divider()
        
        VStack(spacing: 20) {
            Text(tvModel.title)
            Text(tvModel.director)
            Text("\(tvModel.count)")
        } //:VSTACK
        
    }
}

#Preview {
    TypealiaseInter()
}
