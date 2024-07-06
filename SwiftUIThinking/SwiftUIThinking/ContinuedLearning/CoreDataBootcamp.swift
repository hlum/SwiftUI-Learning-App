//
//  CoreDataBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/25.
//

import SwiftUI
import CoreData

class CoreDataViewModel : ObservableObject{
    
    @Published var savedEntities : [FruitEntity] = []
    
    let container : NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Error Loading. \(error)")
            }
        }
        
        fetchFruits()
    }
    
    func fetchFruits(){
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do{
           savedEntities = try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching. \(error)")
        }
    }
    
    func addFruit(text:String){
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        print("added fruit")

        saveData()
        
    }
    
    func deleteFruit(indexSet : IndexSet){
       guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            fetchFruits()
        }catch let error{
            print("Error Saving \(error)")
        }
        
    }
}

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText : String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                TextField("Add fruits", text: $textFieldText)
                    .font(.headline)
                    .frame(height: 55)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    print("Button is pressed")
                    guard !textFieldText.isEmpty else {return}
                    print("Text field isn't empty")
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Add")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                
                Spacer()
                
                
                List{
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name
                             ?? "No name")
                            .font(.title)
                            .padding(.vertical,20)
                            .foregroundColor(.black)
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(SidebarListStyle())
            }
            
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataBootcamp()
}
