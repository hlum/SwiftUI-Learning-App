//
//  MaskBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/22.
//

import SwiftUI

struct MaskBootcamp: View {
    @State var rating: Int = 3
    var body: some View {
        ZStack{
            starsView
                .overlay(overlayView.mask(starsView))
        }
        
    }
    
    private var overlayView:some View{
        GeometryReader{geometry in
            ZStack(alignment:.leading){
                Rectangle()
//                    .foregroundColor(.yellow)
                    .fill(LinearGradient(gradient: Gradient(colors: [.red,.yellow,.green]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating)/5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)//disallow the user to click on this overlay view
    }
    
    private var starsView:some View{
        HStack{
            ForEach(1..<6){index in
                Image(systemName:"star.fill")
                    .font(.largeTitle)
                    .foregroundColor(rating >= index ? .yellow : .gray)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            rating = index
                        }
                       
                    }
            }
        }
    }
}

#Preview {
    MaskBootcamp()
}
