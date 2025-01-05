//
//  RefreshableBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/12/24.
//

import SwiftUI

final class RefreshableDataService{
    func getData()async throws -> [String]{
        try await Task.sleep(nanoseconds: 5_000_000_000)
        return ["Apple", "Banana", "Orange"].shuffled()
    }
}

@MainActor
final class RefeshableBootcampViewModel: ObservableObject {
    @Published private(set) var items:[String] = []
    let manager = RefreshableDataService()
    
    func loadData() async{
        do{
            items = try await manager.getData()
        }catch{
            print(error.localizedDescription)
        }
        
    }
}

struct RefreshableBootcamp: View {
    @StateObject var vm = RefeshableBootcampViewModel()
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach(vm.items, id: \.self) { item in
                        Text(item)
                            .font(.headline)
                    }
                }
            }
            .refreshable {
                await vm.loadData()
            }
            .navigationTitle("Refreshable")
            .task{
                await vm.loadData()
            }
            
        }
        
    }
}

#Preview {
    RefreshableBootcamp()
}
