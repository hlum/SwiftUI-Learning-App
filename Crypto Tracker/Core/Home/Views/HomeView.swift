//
//  HomeView.swift
//  Crypto Tracker
//
//  Created by Hlwan Aung Phyo on 2024/07/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack{
                Text("Header")
                Spacer(minLength: 0)
            }
        }
        
    }
}

#Preview {
    NavigationView{
        HomeView()
            .navigationBarHidden(true)
    }
   
}
