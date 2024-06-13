//
//  TapGestureBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/31.
//

import SwiftUI

struct TapGestureBootcamp: View {
    @State var isSelected : Bool = false
    
    var body: some View {
        VStack(spacing:40){
            RoundedRectangle(cornerRadius: 25)
                .frame(height:200)
                .foregroundColor(isSelected ? Color.blue : Color.red)
                .onTapGesture {
                    isSelected.toggle()
                }
            
            Button(action:{
                isSelected.toggle()
            },label: {
                Text("Button")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height:55)
                    .frame(maxWidth:.infinity)
                    .background(Color.blue)
                    .cornerRadius(25)
                
            })
            Spacer()
        }.padding(40)
    }
}

#Preview {
    TapGestureBootcamp()
}
