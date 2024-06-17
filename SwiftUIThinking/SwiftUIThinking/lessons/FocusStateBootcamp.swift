//
//  FocusStateBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/15.
//

import SwiftUI

struct FocusStateBootcamp: View {
    
    enum OnboardingFields: Hashable{
        case username
        case password
    }
    
    
    @State private var username:String = ""
//    @FocusState private var usernameInFocus:Bool
    
    @State private var password:String = ""
//    @FocusState private var passwordInFocus:Bool
    
    @FocusState private var fieldInFocus: OnboardingFields?

    var body: some View {
        VStack(spacing:20){
            Spacer()
            TextField("Add your name here...", text: $username)
                .focused($fieldInFocus,equals: .username)
                .padding(.leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            SecureField("Add your password here...", text: $password)
                .focused($fieldInFocus,equals: .password)
                .padding(.leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            
            Button("Sign UP"){
                let usernameIsValid = !username.isEmpty
                let passwordIsValid = !password.isEmpty
                
                if usernameIsValid && passwordIsValid{
                    print("Signed up")                }else if usernameIsValid{
                    fieldInFocus = .password
                }else{
                    fieldInFocus = .username
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.extraLarge)
            
            Spacer()
            
            ButtonCodePreview(code: .FocusStateBootcamp)
            
        }
        .padding(70)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.fieldInFocus = .username
            }
        }
    }
}

#Preview {
    FocusStateBootcamp()
}
