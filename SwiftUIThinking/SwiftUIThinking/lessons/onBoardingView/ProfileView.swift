//
//  ProfileView.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/15.
//

import SwiftUI

struct ProfileView: View {
    
    
    @AppStorage("name") var currentUserName : String?
    @AppStorage("age") var currentUserAge:Int?
    @AppStorage("gender") var currentUserGender : String?
    @AppStorage("signed_in") var currentUserSignedIn:Bool = false

    var body: some View {
        VStack{
            Image(systemName:"person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width:150,height: 150)
            Text(currentUserName ?? "Your name here")
            Text("This user is \(currentUserAge ?? 0) years old")
            Text("Their gender is \(currentUserGender ?? "unknown")")
            Text("Sign out")
                .foregroundColor(.white)
                .font(.headline)
                .frame(height:55)
                .frame(maxWidth: .infinity)
                .background(.black)
                .cornerRadius(10)
                .onTapGesture {
                    signOut()
                }
                
            
            
        }
        .font(.title)
        .padding()
        .padding(.vertical,40)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
    func signOut(){
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        withAnimation(.spring()) {
            currentUserSignedIn = false
        }
    }
}

#Preview {
    ProfileView()
}
