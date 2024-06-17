//
//  IntroView.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/12.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn:Bool = false
    var body: some View {
        ZStack{
            RadialGradient(
                gradient: Gradient(colors:[Color(.purple),Color.blue]),
                center:.center,
                startRadius:5,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            if currentUserSignedIn {
                ProfileView()
                    .transition(.asymmetric(
                        insertion:
                                .move(edge:.bottom),
                        removal:
                                .move(edge: .top)))
            }else{
                OnboardingView()
                    .background(.purple)
                    .transition(.asymmetric(
                        insertion:
                                .move(edge:.top),
                        removal:
                                .move(edge: .bottom)))
                                }
            //if user sign in
            //profile view
            //else
            //onboarding
            
        }.animation(.bouncy(), value: currentUserSignedIn)
    }
}

#Preview {
    IntroView()
}
