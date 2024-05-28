//
//  SheetsBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/26.
//

import SwiftUI

struct SheetsBootcamp: View {
    @State var showSheet : Bool = false
    var body: some View {
        ZStack{
            Color.green
                .edgesIgnoringSafeArea(.all)
            
            Button(action:{
                showSheet.toggle()
            },label:{
                Text("Button")
                    .foregroundColor(.green)
                    .font(.headline)
                    .padding(20)
                    .background(Color.white.cornerRadius(10))

            })
            .fullScreenCover(isPresented : $showSheet, content: {
                SecondScreen()
            })
            //.sheet(isPresented: $showSheet, content: {
                //SecondScreen()
           // })
            
        }
    }
}


struct SecondScreen : View {
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        ZStack(alignment:.topLeading){
            Color.red
                .edgesIgnoringSafeArea(.all)
            
            Button(action:{
                presentationMode.wrappedValue.dismiss()
            },label:{
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            })
        }
    }
}

#Preview {
    SheetsBootcamp()
}
