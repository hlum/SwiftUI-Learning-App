//
//  TaskBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/10/24.
//

import SwiftUI

class TaskBootcampViewModel: ObservableObject {
    @Published var image:UIImage? = nil
    @Published var image2 : UIImage? = nil
    
    func fetchImage2() async {
        do{
            guard let url = URL(string: "https://picsum.photos/300") else {return}
            let (data, _) = try await URLSession.shared.data(from:url,delegate:nil)
            
            await MainActor.run{
                self.image2 = UIImage(data: data)
            }
            
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do{
            guard let url = URL(string: "https://picsum.photos/4000") else{return}
            let (data, _) = try await URLSession.shared.data(from:url,delegate: nil)
            await MainActor.run {
                self.image = UIImage(data:data)
                print("Image returned successfully")
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcampHomeView:View{
    var body:some View{
        NavigationStack{
            ZStack{
                NavigationLink("Click me") {
                    TaskBootcamp()
                }
            }
        }
    }
}


struct TaskBootcamp: View {
//    @State private var fetchImageTask:Task<(),Never>? = nil
    @StateObject var viewModel = TaskBootcampViewModel()
    var body: some View {
        VStack(spacing: 40){
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
                                
            }
            if let image2 = viewModel.image2{
                Image(uiImage: image2)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
//        .onDisappear{
//            fetchImageTask?.cancel()
//        }
//        .onAppear{
//            fetchImageTask = Task{
//                await viewModel.fetchImage()
//            }
//            
//            
//            Task{
//                print(Thread.current)
//                print(Task.currentPriority)
//                print("2")
//                await viewModel.fetchImage2()
//            }
            
//            Task(priority: .low) {
//                try? await Task.sleep(nanoseconds: 1_000_000_000)
//                print("LOW : \(Thread.current) : \(Task.currentPriority)" )
//            }
//            Task(priority: .medium) {
//                await Task.yield()
//                print("MEDIUM : \(Thread.current) : \(Task.currentPriority)" )
//            }
//            Task(priority: .high) {
//                print("HIGH : \(Thread.current) : \(Task.currentPriority)" )
//            }
//            Task(priority: .background) {
//                print("BACKGROUND : \(Thread.current) : \(Task.currentPriority)" )
//            }
//            Task(priority: .utility) {
//                print("UTILITY : \(Thread.current) : \(Task.currentPriority)" )
//            }
//            Task(priority: .userInitiated) {
//                print("USER INITIATED : \(Thread.current) : \(Task.currentPriority)" )
//            }
//        }
    }
}

#Preview {
    TaskBootcampHomeView()
}
