//
//  GlobalActorBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/12/24.
//

import SwiftUI


@globalActor struct MyFirstGlobalActor {
    static var shared = myNewDataManager()
    
}


actor myNewDataManager {
    func getDataFromDatabase() -> [String]{
        return ["one","two","three","four","Five"]
    }
}

class GlobalActorBootcampViewModel: ObservableObject {
    let manager = MyFirstGlobalActor.shared
    @Published var dataArray:[String] = []
    
    @MyFirstGlobalActor
    func getData() {
        Task{
            let data = await manager.getDataFromDatabase()
            self.dataArray = data
        }
    }
    
}

struct GlobalActorBootcamp: View {
    @StateObject private var viewModel = GlobalActorBootcampViewModel()
    var body: some View {
        ScrollView{
            VStack{
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task{
            await viewModel.getData()
        }
    }
}

#Preview {
    GlobalActorBootcamp()
}
