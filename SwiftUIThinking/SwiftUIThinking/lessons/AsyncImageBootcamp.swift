//
//  AsyncImageBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/15.
//

import SwiftUI


/**
 case empty -> No image is loadeed
 case sucess(Image) -> An image sucessfully loaded
 case failure(Error) -> An image is failed to load with an error
 
 **/

struct AsyncImageBootcamp: View {
    let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9PQoOkqv5ngE_XGDNJSS5DJ2XgVIG8b5y8A&s")
    var body: some View {
        
        VStack {
            Spacer()
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                    
                case .failure(let error):
                    Image(systemName:"questionmark")
                        .font(.headline)
                default:
                    Image(systemName:"questionmark")
                        .font(.headline)
                }       
            }
            Text("This image is async with the internet!!")
                .font(.headline)
                .padding(20)
            Spacer()
            ButtonCodePreview(code: .AsyncImageView)
            Spacer()
        }
        
        //        AsyncImage(url: url,content: { returnedImage in
        //            returnedImage
        //                .resizable()
        //                .scaledToFit()
        //                .frame(width: 200, height: 200)
        //                .cornerRadius(20)
        //
        //        } ,placeholder: {
        //            ProgressView()
        //        })
        
    }
}

#Preview {
    AsyncImageBootcamp()
}
