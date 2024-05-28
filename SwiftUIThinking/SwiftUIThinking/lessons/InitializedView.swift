//
//  ContentView.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/23.
//

import SwiftUI

struct InitializedView: View {
    
    let backgroundColor : Color
    let count : Int
    let title : String
    
    init(count:Int , fruit : Fruit){
        self.count = count
        
        if fruit == .apple{
            self.title = "Apple"
            self.backgroundColor = .red
        }else{
            self.title = "Orange"
            self.backgroundColor = .orange
        }
    }
    enum Fruit{
        case apple
        case orange
    }
    
    var body: some View {
        Spacer()
        Text("init && enum")
            .font(.largeTitle)
        VStack {
            Text("\(count)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .underline()
            Text("Apples")
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(10)
        .padding()
        
        Spacer()
           
        ButtonCodePreview(code: .initializedV)
    }
}

#Preview {
    InitializedView(count: 5, fruit: .apple)

    
}
