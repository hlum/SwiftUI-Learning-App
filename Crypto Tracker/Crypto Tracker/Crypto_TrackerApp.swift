//
//  Crypto_TrackerApp.swift
//  Crypto Tracker
//
//  Created by Hlwan Aung Phyo on 2024/07/23.
//

import SwiftUI

@main
struct Crypto_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            
            
        }
    }
}
