//
//  TextFieldBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/29.
//

import SwiftUI

struct TextFieldBootcamp: View {
    @State private var selection: Set<String> = []
    @State var text:String = ""
    @State var texts:[String] = []
    var body: some View {
        Spacer()
        TextField("Type something...",text:$text)
            .frame(width:350,height:80)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(30)

        HStack{
            Button(action: {
                texts.append(text)
            }, label: {
                Image(systemName: "square.and.arrow.down")
                    .foregroundColor(.white)
                
                Text("Submit")
                    .frame(height:30)
                    .foregroundColor(.white)
                    

            }).buttonStyle(.bordered)
                .background(Color.black)
                .cornerRadius(10.0)
                
            
            Button(action : {
                if let selected = selection.first {
                    if let index = texts.firstIndex(of: selected) {
                        texts.remove(at: index)
                        selection.remove(selected)
                    }
                }
            },label: {
                Image(systemName: "delete.left.fill")
                    .foregroundColor(.red)
                Text("Delete")
                    .frame(height:30)
                    .foregroundColor(.white)
            }).buttonStyle(.bordered)
                .background(Color.black)
                .cornerRadius(10.0)
            
            
            
        }
        //            Text("\($selection)")
        List(selection:$selection){
            ForEach(texts, id: \.self){savedText in
                Text(savedText)
                
            }
        }
        
    }
    
    
    
}

#Preview {
    TextFieldBootcamp()
}
