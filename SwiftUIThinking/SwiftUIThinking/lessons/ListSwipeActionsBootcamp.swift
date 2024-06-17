//
//  ListSwipeActionsBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/15.
//

import SwiftUI

struct ListSwipeActionsBootcamp: View {
    @State var fruits:[String] = [
    "apple","orange","banana","peach"
    ]
    @State var Veggies :[String] = [
    "Tomato","Potato","Carrot"
    ]

    var body: some View {
        List{
            ForEach(fruits, id: \.self) {
                Text($0.capitalized)
                
                
                
                    .swipeActions(edge: .trailing, allowsFullSwipe: true){
                        Button("Archive"){
                            
                        }
                        .tint(.green)
                        Button("Save"){
                            
                        }.tint(.blue)
                        Button("Junk"){
                            
                        }.tint(.black)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false){
                        Button("Share"){
                            
                        }.tint(.yellow)
                    }

            }
//            .onDelete(perform: delete)
        }
    }
    func delete(indexSet:IndexSet){
        
    }
}

#Preview {
    ListSwipeActionsBootcamp()
}
