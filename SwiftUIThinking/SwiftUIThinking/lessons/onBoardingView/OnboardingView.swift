//
//  OnboardingView.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/12.
//

import SwiftUI


struct OnboardingView: View {
    //Onboarding States:
    /**
        0 - welcome screen
        1 - add name
        2 - add age
        3 - add gender
     
     **/
    @State var onboardingState :Int = 0
    var body: some View {
        ZStack{
           //content
            //button
            VStack{
                Spacer()
                bottomButton
            }
            .padding(30)
        }
    }
    }


// MARKS: COMPONENTS
extension OnboardingView{
    private var bottomButton: some View{
        Text("サインイン")
            .typesettingLanguage(Locale.current.language, isEnabled: true)
            .font(.headline)
            .foregroundColor(.purple)
            .frame(height:55)
            .frame(maxWidth:.infinity)
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                
            }
    }
}

#Preview {
    OnboardingView()
        .background(Color.purple)
}
