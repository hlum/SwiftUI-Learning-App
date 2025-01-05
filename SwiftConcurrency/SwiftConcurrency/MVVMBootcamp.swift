//
//  MVVMBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/12/24.
//

import SwiftUI
final class MyManagerClass{
    func getData() async throws -> String{
        "Some Data!"
    }
}

actor MyManagerActor{
    func getData() async throws -> String{
        "Some Data!"
    }
}

final class MVVMBootcampViewModel: ObservableObject {
    let manager = MyManagerClass()
    let managerActor = MyManagerActor()
    
    @MainActor
    @Published private(set) var myData:String = "Starting Text"
    private var tasks:[Task<Void,Never>] = []
    
    func cancelTasks(){
        tasks.forEach {
            $0.cancel()
            tasks = []
        }
    }
    
    func onCallToActionButtonPressed(){
        let task = Task{@MainActor in
            do{
                myData = try await manager.getData()
            }catch{
                print(error.localizedDescription)
            }
        }
        tasks.append(task)
    }
}



struct MVVMBootcamp: View {
    @StateObject private var viewModel = MVVMBootcampViewModel()
    var body: some View {
        VStack{
            Button("Click me") {
                viewModel.onCallToActionButtonPressed()
            }
            
            Button("Click me") {
                viewModel.onCallToActionButtonPressed()
            }
        }
        .onDisappear{
            viewModel.cancelTasks()
        }
    }
}

#Preview {
    MVVMBootcamp()
}
