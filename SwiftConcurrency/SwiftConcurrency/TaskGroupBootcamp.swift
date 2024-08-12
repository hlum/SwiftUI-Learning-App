//
//  TaskGroupBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/11/24.
//

import SwiftUI
class TaskGroupBootcampDataManager{
    
    func fetchImagesWithAsyncLet() async throws -> [UIImage]{
            async let fetchImage1 = fetchImage(urlString: "https://picsum.photos/500")
            async let fetchImage2 = fetchImage(urlString: "https://picsum.photos/500")
            
            async let fetchImage3 = fetchImage(urlString: "https://picsum.photos/500")
            
            async let fetchImage4 = fetchImage(urlString: "https://picsum.photos/500")
            
            let (image1,image2,image3,image4) = await (try fetchImage1,try fetchImage2, try fetchImage3,try fetchImage4)
            return [image1,image2,image3,image4]
    }
    
    func fetchImagesWithTaskGroup()async throws -> [UIImage]{
        let urlStrings = ["https://picsum.photos/500",
                         "https://picsum.photos/50",
                         "https://picsum.photos/500",
                         "https://picsum.photos/500",
                         "https://picsum.photos/500",
                         "https://picsum.photos/500"]
        return try await withThrowingTaskGroup(of: UIImage?.self){[weak self] group in
            guard let self = self else{return []}
            var images :[UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            
            for urlString in urlStrings{
                group.addTask{
                    try? await self.fetchImage(urlString: urlString)
                }
            }
            
//            group.addTask{
//                try await self.fetchImage(urlString: "https://picsum.photos/500")
//            }
//            group.addTask{
//                try await self.fetchImage(urlString: "https://picsum.photos/500")
//            }
//
//            group.addTask{
//                try await self.fetchImage(urlString: "https://picsum.photos/500")
//            }
//
//            group.addTask{
//                try await self.fetchImage(urlString: "https://picsum.photos/500")
//             }
//
//            group.addTask{
//                try await self.fetchImage(urlString: "https://picsum.photos/500")
//            }
//            
            for try await image in group{
                if let image = image{
                    images.append(image)
                }
            }
            
            return images
        }
    }
    
    private func fetchImage(urlString:String) async throws -> UIImage{
        guard let url = URL(string:urlString)else{
            throw URLError(.badURL)
        }
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url,delegate: nil)
            
            if let image = UIImage(data:data){
                return image
            }else{
                throw URLError(.badURL)
            }
            
        } catch {
            throw error
        }
        
        
    }
    
}
class TaskGroupBootcampViewModel:ObservableObject {
    let dataManager = TaskGroupBootcampDataManager()
    
    @Published var images: [UIImage] = []

    
    
    func getImage() async{
        guard let images = try? await dataManager.fetchImagesWithTaskGroup() else{return}
        self.images.append(contentsOf: images)
    }
}

struct TaskGroupBootcamp: View {
    @StateObject private var viewModel = TaskGroupBootcampViewModel()
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images, id: \.self) { image in
                        NavigationLink {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height:150)
                                
                        } label: {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height:150)

                        }

                    }
                }
            }
            .navigationTitle("Task Group Bootcamp")
            .task {
                if viewModel.images.isEmpty{
                    await viewModel.getImage()
                }
            }
        }
    }
}

#Preview {
    TaskGroupBootcamp()
}
