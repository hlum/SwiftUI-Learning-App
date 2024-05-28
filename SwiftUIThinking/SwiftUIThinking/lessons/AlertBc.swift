//
//  Alert.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/27.
//

import SwiftUI

struct AlertBc: View {
    @State var showPic : Bool = false
    @State var showAlert :Bool = false
    var body: some View {
        
        Button("Click to alert"){
            showAlert.toggle()
        }
        .alert(
            isPresented: $showAlert,
            content: {
                Alert(title: Text("Warning"), message:Text("Cutness Overloaded"),
                      
                      primaryButton: .destructive(Text("Accept"),action: {
                    showPic.toggle()
                }), secondaryButton: .cancel())
            })
        
        
        if showPic{
            Image("ImgGf")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300,height: 300)
                .transition(.move(edge:.bottom))//move,slide
                    .animation(.spring)
            Button("Close"){
                showPic.toggle()
            }
            
        }

    }
    
    
}

#Preview {
    AlertBc()
}
