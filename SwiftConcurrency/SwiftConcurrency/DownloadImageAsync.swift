//
//  DownloadImageAsync.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 2024/07/30.
//

import SwiftUI
import Combine

class DownloadImageAsyncImageLoader: ObservableObject{
    let url = URL(string: "https://picsum.photos/200")!
    
    func handleResponse(data:Data?,response:URLResponse?) -> UIImage?{
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else{
            return nil
        }
        return image 
    }
    
    
    func downloadWithEscaping(completionHandler: @escaping (_ image:UIImage?,_ error:Error?) -> ()){
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image,error)
        }
        .resume()
    }
    
    
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error>{
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({$0})
            .eraseToAnyPublisher()
    }
    
}

class DownloadImageAsyncModel : ObservableObject{
    @Published var image:UIImage? = nil
    let loader = DownloadImageAsyncImageLoader()
    
    
    func fetchImage(){
        loader.downloadWithEscaping(completionHandler: {[weak self] image, error in
            DispatchQueue.main.async {
                    self?.image = image
                }
    })
    
        func fetchImageWithCombine(){
            loader.downloadWithCombine()
                .sink { _ in
                    
                } receiveValue: {[weak self] image in
                    self?.image = image
                }

        }


                
            
    }
}

struct DownloadImageAsync: View {
    @ObservedObject private var viewModel = DownloadImageAsyncModel()
    var body: some View {
        VStack{
            Button("image"){
                viewModel.fetchImage()
            }
            if let image = viewModel.image{
                Image(uiImage:image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250,height: 250)
                
            }
        }
    }
}

#Preview {
    DownloadImageAsync()
}
