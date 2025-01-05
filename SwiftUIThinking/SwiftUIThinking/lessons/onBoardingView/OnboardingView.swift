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
    let transition:AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    //onboarding inputs
    @State var name:String = ""
    @State var age :Double = 50
    @State var gender : String = ""
    
    //for the alert
    @State var alertTitle:String = ""
    @State var showAlert:Bool = false
    
    //app storage
    @AppStorage("name") var currentUserName : String?
    @AppStorage("age") var currentUserAge:Int?
    @AppStorage("gender") var currentUserGender : String?
    @AppStorage("signed_in") var currentUserSignedIn:Bool = false

    
    
    var body: some View {
        ZStack{
           //content
            Color.brown
            ZStack{
                switch onboardingState{
                case 0:
                    welcomeSection
                        .transition(transition)
                case 1:
                    addNameSection
                        .transition(transition)

                case 2:
                    addAgeSection
                        .transition(transition)

                case 3:
                    addGenderSection
                        .transition(transition)

                default:
                    RoundedRectangle(cornerRadius:25.0)
                        .foregroundColor(.green)
                }
            }
            //button
            VStack{
                Spacer()
                bottomButton
            }
            .padding(30)
        }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
                         })
        
    }
    }


// MARK: COMPONENTS
extension OnboardingView{
    private var bottomButton: some View{
        Text(onboardingState == 0 ? "Sign up" :
                onboardingState == 3 ? "Finish":
                "Next")
            .font(.headline)
            .foregroundColor(.purple)
            .frame(height:55)
            .frame(maxWidth:.infinity)
            .background(Color.white)
            .cornerRadius(10)
            .animation(nil)
            .onTapGesture {
                   handleNextButtonPressed()
            }
    }
    
    private var welcomeSection:some View{
        VStack(spacing:40){
            Spacer()
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width:200,height:200)
                .foregroundColor(.white)
            Text("Find your match")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .overlay(
                    Capsule(style:.continuous)
                        .frame(height:3)
                        .offset(y:5)
                        .foregroundColor(.white),
                    alignment: .bottom
                )
            Text("This is the no 1 app for your match online....")
                .fontWeight(.medium)
                .foregroundColor(.white)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
    
    private var addNameSection:some View{
        VStack(spacing:20){
            Spacer()
            Text("What's your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                
            TextField("Your name here...",text: $name)
            .font(.headline)
            .frame(height: 55)
            .padding(.horizontal)
            .background(.white)
            .cornerRadius(10)
            
            
            Spacer()
            Spacer()
            
        }.padding(30)
    }
    
    private var addAgeSection: some View{
        VStack(spacing:40){
            Spacer()
            Text("What's your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text("\(String(format:"%.0f",age))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Slider(value: $age, in: 18...100,step: 1)
                .accentColor(.white)
            
            
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
    
    private var addGenderSection: some View{
        VStack(spacing:40){
            Spacer()
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            
            Picker("Select a gender"
                ,
                   selection: $gender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("Non-Binary").tag("Non-Binary")
            }
                   .frame(maxWidth: .infinity)
                   .frame(height: 30)
                   .padding()
                   .background(Color.white)
                   .cornerRadius(10)
                   .pickerStyle(MenuPickerStyle())
                        
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
    

}
//MARK: FUNCTIONS
extension OnboardingView{
    
    func handleNextButtonPressed(){
        //Check inputs
        switch onboardingState{
            
        case 1:
            guard name.count >= 3 else{
                showAlertTitle(title:"Your name must be at least 3 characters long! ")
                return
            }
            break
        default:
            break
        }
        //Go to next section
        
        if onboardingState == 3{
            signIn()
        }else{
            withAnimation(.spring()){
                onboardingState += 1
            }
        }
    }
    func signIn(){
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        withAnimation(.spring()) {
            currentUserSignedIn = true
        }
      
    }
    
    func showAlertTitle(title :String){
        alertTitle = title
        showAlert.toggle()

    }
}

#Preview {
    OnboardingView()
}
