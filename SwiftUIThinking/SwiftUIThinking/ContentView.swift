//
//  ContentView.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            
        }
        NavigationView{
            VStack{
                NavigationLink("Init and Enum",destination: InitializedView(count: 5, fruit: .apple))
                    .padding()
                NavigationLink("ForEach",destination: ForEachDataView())
                    .padding()
                NavigationLink("ScrollView",destination: ScrollView2BootCamp())
                    .padding()

            }
        }
    }
}

#Preview {
    ContentView()
}
