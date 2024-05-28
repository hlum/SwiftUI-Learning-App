//
//  TenaryOperator.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/25.
//

import SwiftUI

struct TenaryOperator: View {
    @State var isStartingState:Bool = false
    var body: some View {
        VStack{
            Button("Button\(isStartingState)"){
                isStartingState.toggle()
                
            }
            RoundedRectangle(cornerRadius: isStartingState ? 25 : 0)
                .fill(isStartingState ? Color.red : Color.blue)
                .frame(width: isStartingState ? 200:50,height: isStartingState ? 400:50)
            
            
            ButtonCodePreview(code:.TenaryOperator)
        }    }
}

#Preview {
    TenaryOperator()
}
