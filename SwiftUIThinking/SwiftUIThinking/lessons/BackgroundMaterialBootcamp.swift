//
//  BackgroundMaterialBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/15.
//

import SwiftUI

struct BackgroundMaterialBootcamp: View {
    var body: some View {
        VStack{
            Spacer()
            
            VStack{
                RoundedRectangle(cornerRadius: 4)
                    .frame(width:50,height:4)
                    .padding()
                Spacer()
            }
            .frame(height: 350)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(30)
            ButtonCodePreview(code: .BMaterialBootcamp)
                .padding(.bottom)
        }
        .ignoresSafeArea()
        .background(
            Image("ImgGf")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity,maxHeight: .infinity)
        )
    }
}

#Preview {
    BackgroundMaterialBootcamp()
}
