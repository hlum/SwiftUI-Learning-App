//
//  TransitionBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/26.
//

import SwiftUI

struct TransitionBootcamp: View {
    @State var showView: Bool = false
    
    var body: some View {
        ZStack(alignment:.bottom){
            VStack{
                ButtonCodePreview(code:.TransitionTimingBc)
                Button("Button"){
                    showView.toggle()
                }.padding(.top,100)
                Spacer()
                
            }
            if showView {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.gray)
                    .frame(height : UIScreen.main.bounds.height * 0.5)
                    .transition(.move(edge: .bottom))//move,slide
                    .animation(.spring)
            }
           
        }
        .edgesIgnoringSafeArea(.bottom)

    }
    }

#Preview {
    TransitionBootcamp()
}
