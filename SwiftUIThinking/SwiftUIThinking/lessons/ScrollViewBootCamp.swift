//
//  ScrollView.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/23.
//

import SwiftUI

struct ScrollViewBootCamp: View {
    var body: some View {
        ScrollView(.horizontal,showsIndicators: true,content:{
            LazyHStack{
                ForEach(0..<10){index in
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width:300,height:300)
            }
                
            }

        })
    }
}

struct ScrollView2BootCamp: View {
    var body: some View {
        ScrollView{
            LazyVStack{
                
                ForEach(0..<50){ index in
                    ScrollView(.horizontal,showsIndicators: false,content:{
                        LazyHStack {
                            ForEach(0..<50){index in
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.white)
                                    .frame(width: 200,height: 100)
                                    .shadow(radius:10)
                                    .padding()

                            }
                                                    }
                    })
                    
                }
            }
        }
        ButtonCodePreview(code: .scrollViewBootCamp)
            .padding()
    }
}
#Preview {
    ScrollView2BootCamp()
}
