import SwiftUI

// Main view that presents a button and a sheet
struct ButtonCodePreview: View {
    @State private var isPresented: Bool = false // State variable to manage the presentation of the sheet
    var code: String // Variable to hold the code to be displayed in the sheet

    // Custom initializer to set the `code` variable based on the provided `Code` enum value
    init(code: Code) {
        switch code {
        case .ListBc :
            self.code = """
//
//  ListBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/27.
//

import SwiftUI

struct ListBootcamp: View {
    @State var fruits:[String] = [
    "apple","orange","banana","peach"
    ]
    @State var Veggies :[String] = [
    "Tomato","Potato","Carrot"
    ]
    var body: some View {
        NavigationView {
            List{
                Section(
                    header: Text("Fruits")){
                    ForEach(fruits, id: \\.self){ fruit in
                        Text(fruit.capitalized)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                        
                }
                
                Section(header:Text("Veggies")){
                    ForEach(Veggies,id: \\.self){veggie in
                        Text(veggie.capitalized)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Grocery List")
            .navigationBarItems(
                leading: EditButton(),
                trailing:addButton)
            .accentColor(.red)

        }
        ButtonCodePreview(code: .ListBc)
    }
    
    var addButton : some View{
        Button("Add",action : {
            add()
        })

    }
    
    func delete(indexSet:IndexSet){
        fruits.remove(atOffsets: indexSet)

    }
    
    func move(indices : IndexSet,newOffset : Int){
        fruits.move(fromOffsets: indices, toOffset: newOffset)
    }
    func add(){
        fruits.append("Banana")
    }
}

#Preview {
    ListBootcamp()
}
"""
        case .initializedV:
            self .code = """

            //
            //  ContentView.swift
            //  SwiftUIThinking
            //
            //  Created by Hlwan Aung Phyo on 2024/05/23.
            //

            import SwiftUI

            struct InitializedView: View {
                
                let backgroundColor: Color
                let count: Int
                let title: String
                
                // Custom initializer to set properties based on the provided `count` and `fruit`
                init(count: Int, fruit: Fruit) {
                    self.count = count
                    
                    if fruit == .apple {
                        self.title = "Apple"
                        self.backgroundColor = .red
                    } else {
                        self.title = "Orange"
                        self.backgroundColor = .orange
                    }
                }
                
                // Enum to represent different fruit types
                enum Fruit {
                    case apple
                    case orange
                }
                
                var body: some View {
                    VStack {
                        Text("\\(count)")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .underline()
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(width: 150, height: 150)
                    .background(backgroundColor)
                    .cornerRadius(10)
                    
                    Spacer()
                }
            }

            struct InitializedView_Previews: PreviewProvider {
                static var previews: some View {
                    HStack {
                        InitializedView(count: 5, fruit: .apple)
                        InitializedView(count: 7, fruit: .orange)
                    }
                }
            }
            """
        case .scrollViewBootCamp:
            self.code = """
            //
            //  ScrollView.swift
            //  SwiftUIThinking
            //
            //  Created by Hlwan Aung Phyo on 2024/05/23.
            //

            import SwiftUI

            struct ScrollViewBootCamp: View {
                var body: some View {
                    ScrollView(.horizontal, showsIndicators: true) {
                        LazyHStack {
                            ForEach(0..<10) { index in
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 300, height: 300)
                            }
                        }
                    }
                }
            }

            struct ScrollView2BootCamp: View {
                var body: some View {
                    ScrollView {
                        LazyVStack {
                            ForEach(0..<10) { index in
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(0..<20) { index in
                                            RoundedRectangle(cornerRadius: 25.0)
                                                .fill(Color.white)
                                                .frame(width: 200, height: 100)
                                                .shadow(radius: 10)
                                                .padding()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            struct ScrollView2BootCamp_Previews: PreviewProvider {
                static var previews: some View {
                    ScrollView2BootCamp()
                }
            }
            """
        case .forEachView:
            self.code = """
            //
            //  ForEach.swift
            //  SwiftUIThinking
            //
            //  Created by Hlwan Aung Phyo on 2024/05/23.
            //

            import SwiftUI

            struct ForEachView: View {
                var body: some View {
                    VStack {
                        ForEach(0..<10) { index in
                            Text("\\(index)")
                        }
                    }
                }
            }

            struct ForEachDataView: View {
                
                let data: [String] = ["I", "Hello", "afs"]
                
                var body: some View {
                    VStack {
                        ForEach(data.indices) { index in
                            Text("\\(data[index])")
                        }
                    }
                }
            }

            struct ForEachDataView_Previews: PreviewProvider {
                static var previews: some View {
                    ForEachDataView()
                }
            }
            """
        case .TenaryOperator:
            self.code = """
//
//  TenaryOperator.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/25.
//

import SwiftUI

struct TenaryOperator: View {
    @State var isStartingState:Bool = false
    var body: some View {
        VStack{
            Button("Button\\(isStartingState)"){
                isStartingState.toggle()
                
            }
            RoundedRectangle(cornerRadius: isStartingState ? 25 : 0)
                .fill(isStartingState ? Color.red : Color.blue)
                .frame(width: isStartingState ? 200:50,height: isStartingState ? 400:50)
            
            
            ButtonCodePreview(code:.initializedV)
        }    }
}

#Preview {
    TenaryOperator()
}

"""
        case .AnimationBc : self.code = """
//
//  AnimationBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/25.
//

import SwiftUI

struct AnimationBootcamp: View {
    @State var isAnimated : Bool = false
    var body: some View {
        VStack{
            Button("Button"){
                //You can also use .animation modifier for just one object if u have too many objects relying on withAnimation.
                withAnimation(
                    Animation
                        .default
                        //.repeatForever()//.delay()
                        .repeatCount(5,autoreverses: true)
                ){
                    isAnimated.toggle()
                }
                ButtonCodePreview(code:.AnimationBc)
            }
            Spacer()

            RoundedRectangle(cornerRadius: isAnimated ? 50 :25)
                .fill(isAnimated ? Color.red:Color.green)
                .frame(
                    width: isAnimated ? 100:300,
                    height: isAnimated ? 100:300)
                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
                .offset(y:isAnimated ? 300 : 0)
            Spacer()
        }    }
}

#Preview {
    AnimationBootcamp()
}
"""
        case .ActionSheet :
            self.code = """
//
//  ActionSheetBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/28.
//

import SwiftUI

struct ActionSheetBootcamp: View {
    @State var showActionSheet: Bool = false
    @State var actionSheetOption:ActionSheetOptions = .isOtherPost
    
    enum ActionSheetOptions{
        case isMyPost
        case isOtherPost
    }
    
    
    var body: some View {
        
        VStack {
            HStack{
                Circle()
                    .frame(width:30,height:30)
                Text("@username")
                Spacer()
                Button("\\(actionSheetOption)"){
                    if actionSheetOption == .isMyPost{
                        actionSheetOption = .isOtherPost
                    }else{
                        actionSheetOption = .isMyPost
                    }
                }
                Button(action: {
                    showActionSheet.toggle()
                }, label: {
                    Image(systemName:"ellipsis")
                })
                .accentColor(.primary)
            }
            .padding(.horizontal)
            Image("ImgGf")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 500)
                .blur(radius: 10.0)
        }
//        .padding()
        .actionSheet(isPresented: $showActionSheet, content: getActionSheet)
    }
    func getActionSheet() -> ActionSheet{
        let editButton : ActionSheet.Button = .default(Text("Edit")){
            
        }
        
        let shareButton : ActionSheet.Button = .default(Text("Share")){
            
        }
        let reportButton : ActionSheet.Button = .destructive(Text("Report")){
            
        }
        let deleteButton : ActionSheet.Button = .destructive(Text("Delete")){
            
        }
        let cancelButton : ActionSheet.Button = .cancel()
        
        let title = Text("What would u like to do")
        
        
        switch actionSheetOption{
        case .isMyPost:
            return ActionSheet(title: title, message: nil, buttons: [editButton,shareButton,deleteButton,reportButton,cancelButton])
        case .isOtherPost:
            return ActionSheet(title: title, message: nil, buttons: [shareButton,reportButton,cancelButton])
            
        }
        
//        let button1 :ActionSheet.Button = .default(Text("Default"))
//        let button2 :ActionSheet.Button = .destructive(Text("Destructive"))
//        let button3 :ActionSheet.Button = .cancel(Text("Cancel"))
//        return ActionSheet(
//            title: Text("This is title"),
//            message: Text("This is message"),
//            buttons: [button1,button2,button3]
//        )
    }
}

#Preview {
    ActionSheetBootcamp()
}
"""
        case .AnimationTimingBc :
            self.code = """
import SwiftUI

struct AnimationTimingBootcamp: View {
    @State var isAnimating : Bool = false
    @State var animationStyle: Animation = .linear(duration: 10.0)

    var body: some View {
        ButtonCodePreview(code: .AnimationTimingBc)
        VStack {
            HStack {
                Button("Button") {
                    isAnimating.toggle()
                }
                Button("Linear") {
                    animationStyle = .linear(duration: 10.0)
                    isAnimating.toggle()
                }
                Button("Ease In Out") {
                    animationStyle = .easeInOut(duration: 10)
                    isAnimating.toggle()
                }
                Button("Ease In") {
                    animationStyle = .easeIn(duration: 10)
                    isAnimating.toggle()
                }
                Button("Ease Out") {
                    animationStyle = .easeOut(duration: 10)
                    isAnimating.toggle()
                }
                Button("Bounce") {
                    animationStyle = .spring(response: 0.6,                                 dampingFraction: 0.3,
                                             blendDuration: 1.0)
                    isAnimating.toggle()
                }
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimating ? 350 : 50, height: 100)
                .animation(animationStyle, value: isAnimating)
        }
    }
}

#Preview {
    AnimationTimingBootcamp()
}
""" 
        case .TransitionTimingBc :
            self.code = """
//
//  TransitionBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/26.
//

import SwiftUI

struct TransitionBootcamp: View {
    @State var showView: Bool = false
    
    var body: some View {
        ZStack(alignment:.bottom){
            VStack{
                Button("Button"){
                    showView.toggle()
                }
                Spacer()
                
            }
            if showView {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.gray)
                    .frame(height : UIScreen.main.bounds.height * 0.5)
                    .transition(.move(edge: .bottom))//move,slide
                    .animation(.spring)
            }
           
        }
        .edgesIgnoringSafeArea(.bottom)

    }
    }

#Preview {
    TransitionBootcamp()
}
"""
        case .AsyncImageView:
            self.code = """
//
//  AsyncImageBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/15.
//

import SwiftUI


/**
 case empty -> No image is loadeed
 case sucess(Image) -> An image sucessfully loaded
 case failure(Error) -> An image is failed to load with an error
 
 **/

struct AsyncImageBootcamp: View {
    let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9PQoOkqv5ngE_XGDNJSS5DJ2XgVIG8b5y8A&s")
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
                
            case .failure(let error):
                Image(systemName:"questionmark")
                    .font(.headline)
            default:
                Image(systemName:"questionmark")
                    .font(.headline)
            }
        }
        
        //        AsyncImage(url: url,content: { returnedImage in
        //            returnedImage
        //                .resizable()
        //                .scaledToFit()
        //                .frame(width: 200, height: 200)
        //                .cornerRadius(20)
        //
        //        } ,placeholder: {
        //            ProgressView()
        //        })
        
    }
}

#Preview {
    AsyncImageBootcamp()
}
""" case .BMaterialBootcamp:
            self.code = """
//
//  BackgroundMaterialBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/15.
//

import SwiftUI

struct BackgroundMaterialBootcamp: View {
    var body: some View {
        VStack{
            Spacer()
            
            VStack{
                RoundedRectangle(cornerRadius: 4)
                    .frame(width:50,height:4)
                    .padding()
                Spacer()
            }
            .frame(height: 350)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(30)
            ButtonCodePreview(code: .BMaterialBootcamp)
        }
        .ignoresSafeArea()
        .background(
            Image("ImgGf")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity,maxHeight: .infinity)
        )
    }
}

#Preview {
    BackgroundMaterialBootcamp()
}
"""
        case .TextSelectionBootcamp:
            self.code =  """
//
//  TextSelectionBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/15.
//

import SwiftUI

struct TextSelectionBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .textSelection(.enabled)
        ButtonCodePreview(code: .TextSelectionBootcamp)
    }
}

#Preview {
    TextSelectionBootcamp()
}
"""
        case .FocusStateBootcamp:
            self.code = """
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
"""
        }
    }
    
    // Enum to specify the different code options
    enum Code {
        case initializedV
        case forEachView
        case scrollViewBootCamp
        case TenaryOperator
        case AnimationBc
        case AnimationTimingBc
        case TransitionTimingBc
        case ListBc
        case ActionSheet
        case AsyncImageView
        case BMaterialBootcamp
        case TextSelectionBootcamp
        case FocusStateBootcamp
    }
    
    var body: some View {
        Button(action: {
            isPresented.toggle() // Toggle the presentation state of the sheet
        }) {
            Text("コードを見る")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .heavy, design: .default))
                .frame(width: 200, height: 60, alignment: .center)
                .background(Color.black)
                .cornerRadius(10)
        }
        .sheet(isPresented: $isPresented){
            
            ZStack {
                Color.black
                    .ignoresSafeArea(.all)
                VStack {
                    ScrollView {
                        Text(code) // Display the selected code
                            .padding()
                            .foregroundColor(.white)
                            .textSelection(.enabled)
                    }
                    .padding()
                }
            }
        }
    }
}

struct ButtonCodePreview_Previews: PreviewProvider {
    static var previews: some View {
        ButtonCodePreview(code: .forEachView) // Provide a default code option for preview
    }
}
