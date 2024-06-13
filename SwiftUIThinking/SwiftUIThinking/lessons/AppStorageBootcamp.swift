//
//  AppStorageBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/05.
//

import SwiftUI

struct AppStorageBootcamp: View {
    @State var name:String = ""
    @State var currentUserName : String = ""
    var body: some View {
        VStack(spacing:10){
            
            TextField("Insert Text", text: $name )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width:300,height:100)
            Button("Saved".uppercased()){
                currentUserName = name
                UserDefaults.standard.setValue(name, forKey: "nameKey")
                //Saving the name data for later and set the key to "nameKey"
            }.frame(width:200,height:30)
                .buttonStyle(BorderedButtonStyle())
            
        }.onAppear{
            currentUserName = UserDefaults.standard.string(forKey: "nameKey") ?? ""
            //on appear we are fetching the data by using the key for the dataValue
        }
        
        Text(currentUserName)
            .font(.title)
            .padding()
            .frame(width:300)
            .background(.gray)
    }
}

#Preview {
    AppStorageBootcamp()
}
