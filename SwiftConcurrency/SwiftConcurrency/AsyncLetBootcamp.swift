//
//  AsyncLetBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/11/24.
//

import SwiftUI

struct AsyncLetBootcamp: View {
    let url :URL = URL(string: "https://picsum.photos/300")!
    @State private var images:[UIImage] = []
    let colums = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns:colums){
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height:150)
                    }
                }
            }
            .navigationTitle("Async let Bootcamp")
            .onAppear{
                Task{
                    do{
                        async let fetchImage1 = fetchImage()
                        async let fetchImage2 = fetchImage()
                        async let fetchImage3 = fetchImage()
                        async let fetchImage4 = fetchImage()
                        async let fetchImage5 = fetchImage()
                        
                        let (image1,image2,image3,image4,image5) = await (try fetchImage1,try fetchImage2,try fetchImage3,try fetchImage4,try fetchImage5)
                        
                        self.images.append(contentsOf: [image1,image2,image3,image4,image5])
                    }catch {
                        
                    }
                }
            }
        }
    }
    func fetchImage() async throws -> UIImage{
        do {
            let (data,_) = try await URLSession.shared.data(from: self.url,delegate: nil)
            
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

#Preview {
    AsyncLetBootcamp()
}
