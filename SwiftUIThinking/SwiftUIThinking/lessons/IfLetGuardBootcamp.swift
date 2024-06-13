//
//  IfLetGuardBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/31.
//

import SwiftUI

struct IfLetGuardBootcamp: View {
    @State var displayText: String? = nil
    @State var isLoading : Bool  = false
    var body: some View {
        NavigationView{
            VStack{
                Text("Here we are practiong safe coding")
                Text(displayText ?? "NO data found yet wait")
                    .font(.title)
                if(isLoading){
                    ProgressView()
                }
                Spacer()
            }
            .navigationTitle("Safe Coding")
            .onAppear{
             loadData()
            }
        }
    }
    func loadData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            displayText = "This is the new data"
            isLoading = false
        })
    }
}

#Preview {
    IfLetGuardBootcamp()
}
