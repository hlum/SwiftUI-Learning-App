//
//  ListBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/27.
//

import SwiftUI

struct ListBootcamp: View {
    @State var fruits:[String] = [
    "apple","orange","banana","peach"
    ]
    @State var Veggies :[String] = [
    "Tomato","Potato","Carrot"
    ]
    var body: some View {
        NavigationView {
            List{
                Section(
                    header: Text("Fruits")){
                    ForEach(fruits, id: \.self){ fruit in
                        Text(fruit.capitalized)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                        
                }
                
                Section(header:Text("Veggies")){
                    ForEach(Veggies,id: \.self){veggie in
                        Text(veggie.capitalized)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Grocery List")
            .navigationBarItems(
                leading: EditButton(),
                trailing:addButton)
            .accentColor(.red)

        }
        ButtonCodePreview(code: .ListBc)
    }
    
    var addButton : some View{
        Button("Add",action : {
            add()
        })

    }
    
    func delete(indexSet:IndexSet){
        fruits.remove(atOffsets: indexSet)

    }
    
    func move(indices : IndexSet,newOffset : Int){
        fruits.move(fromOffsets: indices, toOffset: newOffset)
    }
    func add(){
        fruits.append("Banana")
    }
}

#Preview {
    ListBootcamp()
}
