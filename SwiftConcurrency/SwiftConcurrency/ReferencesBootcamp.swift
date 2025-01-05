//
//  ReferencesBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/12/24.
//

import SwiftUI

final class ReferencesDataService{
    
    func getData()async -> String{
        return "Updated Data"
    }
}

final class ReferencesBootcampViewModel: ObservableObject {
    @Published var data: String = ""
    let manager = ReferencesDataService()
    
    private var someTask:Task<Void,Never>?
    
    func cancelTask(){
        someTask?.cancel()
    }
    
    
    //This implies a strong reference....
    func updateData(){
        Task{
            data = await manager.getData()
        }
    }
    
    func updateData2(){
        Task{
            self.data = await manager.getData()
        }
    }
    func updateData3(){
        Task{[self] in
            self.data = await manager.getData()
        }
    }
    
    func updateData4(){
        Task{[weak self] in
            if let data = await self?.manager.getData(){
                self?.data = data
            }
        }
    }
    
}

struct ReferencesBootcamp: View {
    @StateObject var viewModel = ReferencesBootcampViewModel()
    var body: some View {
        Text(viewModel.data)
    }
        
}

#Preview {
    ReferencesBootcamp()
}
