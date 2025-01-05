//
//  PhotoPickerBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/13/24.
//

import SwiftUI
import PhotosUI

@MainActor
final class PhotoPickerBootcampModel: ObservableObject {
    @Published private(set) var selectedImage:UIImage? = nil
    @Published var imageSelection:PhotosPickerItem? = nil{
        didSet{
            setImage(from: imageSelection)
        }
    }
    @Published private(set) var selectedImages:[UIImage] = []
    @Published var imageSelections:[PhotosPickerItem] = []{
        didSet{
            setImages(from: imageSelections)
        }
    }
    
    private func setImage(from selection : PhotosPickerItem?){
        guard let selection = selection  else {return}
        
        Task{
//            if let data = try? await selection.loadTransferable(type: Data.self){
//                if let uiImage = UIImage(data: data){
//                    selectedImage = uiImage
//                    return
//                }
//            }
            do {
                let data = try await selection.loadTransferable(type: Data.self)
                guard let data,let uiImage = UIImage(data:data)else{
                    throw URLError(.badServerResponse)
                }
                
                selectedImage = uiImage
                
                
            } catch  {
                print(error.localizedDescription)
            }

        }
        
    }
    private func setImages(from selections : [PhotosPickerItem]){
        Task{
            var images:[UIImage] = []
            for selection in selections{
                if let data = try? await selection.loadTransferable(type: Data.self){
                    if let uiImage = UIImage(data: data){
                        images.append(uiImage)
                    }
                }
            }
            selectedImages = images
//            do {
//                let data = try await selection.loadTransferable(type: Data.self)
//                guard let data,let uiImage = UIImage(data:data)else{
//                    throw URLError(.badServerResponse)
//                }
//                
//                selectedImage = uiImage
//                
//                
//            } catch  {
//                print(error.localizedDescription)
//            }

        }
        
    }
}

struct PhotoPickerBootcamp: View {
    
    @StateObject private var viewModel = PhotoPickerBootcampModel()
    var body: some View {
        VStack(spacing:40){
            if let image = viewModel.selectedImage{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width:200,height: 200)
                    .cornerRadius(10)
            }
            PhotosPicker(selection: $viewModel.imageSelection,matching: .images) {
                Text("Open the photo picker")
                    .foregroundColor(.red)
            }
            if !viewModel.imageSelections.isEmpty{
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        ForEach(viewModel.selectedImages,id:\.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width:100,height: 100)
                                .cornerRadius(10)

                        }
                    }
                }
            }
            PhotosPicker(selection: $viewModel.imageSelections,matching: .images) {
                Text("Open the photos picker")
                    .foregroundColor(.red)
            }

        }
    }
}

#Preview {
    PhotoPickerBootcamp()
}
