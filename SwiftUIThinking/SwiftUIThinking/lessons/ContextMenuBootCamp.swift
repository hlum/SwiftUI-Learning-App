//
//  ContextMenuBootCamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/29.
//

import SwiftUI

struct ContextMenuBootCamp: View {
    
    @State var backgroundColor : Color = .black
    var body: some View {
        VStack(alignment:.leading,spacing: 10.0){
            Image(systemName:"house.fill")
                .font(.title)
            Text("Swiftul Thinking")
                .font(.headline)
            Text("How to use context menu")
                .font(.subheadline)
        }
        .padding(30)
        .foregroundColor(.white)
        .background(backgroundColor.cornerRadius(30))
        .contextMenu(menuItems:{
            Button(action: {
                backgroundColor = .gray
            }, label: {
                Label("Share Post",systemImage: "flame.fill")
            })
            
            Button(action: {
                
                backgroundColor = .yellow
                
            }, label: {
                
                Text("report post")
            })

            Button(action: {
                
                backgroundColor = .red
                
            }, label: {
                
                HStack{
                    Text("like post")
                    Image(systemName:"heart.fill")
                }
            })
        })

    }
}

#Preview {
    ContextMenuBootCamp()
}
