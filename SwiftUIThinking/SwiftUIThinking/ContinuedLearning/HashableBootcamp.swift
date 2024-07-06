//
//  HashableBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/22.
//

import SwiftUI

struct MyCustomModel: Hashable{
    //    let id = UUID().uuidString
    
    let title : String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    let data : [MyCustomModel] = [
        
        MyCustomModel(title: "One"),
        MyCustomModel(title: "One"),
        MyCustomModel(title: "One"),
        MyCustomModel(title: "One"),
        MyCustomModel(title: "One"),
        MyCustomModel(title: "One")
        
    ]
    
    var body: some View {
        ScrollView{
            VStack(spacing:40) {
                //                ForEach(data) { item in
                //                    Text(item.id)
                //                        .font(.headline)
                //                }
                ForEach(data, id:\.self ) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                    Divider()
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}
