//
//  MagnificationGestureBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/21.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    @State var currentAmount : CGFloat = 0
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.title)
            .padding(40)
            .background(Color.red.cornerRadius(10))
            .scaleEffect(1 + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged({ (value) in
                        currentAmount = value - 1
                    })
                            
            )
        
        
        
    }
}

#Preview {
    MagnificationGestureBootcamp()
}
