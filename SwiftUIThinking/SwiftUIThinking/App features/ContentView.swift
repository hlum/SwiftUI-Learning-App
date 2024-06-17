import SwiftUI
import AVFAudio

// Define a model for the menu items
struct Lessons: Identifiable {
    let id = UUID()
    let title: String
    let destination: AnyView
}

// Initialize the data list
let lessons = [
    Lessons(title: "Init and Enum", destination: AnyView(InitializedView(count: 5, fruit: .apple))),
    Lessons(title: "ForEach", destination: AnyView(ForEachDataView())),
    Lessons(title: "ScrollView", destination: AnyView(ScrollView2BootCamp())),
    Lessons(title: "Animation", destination: AnyView(AnimationBootcamp())),
    Lessons(title: "Animation Timing", destination: AnyView(AnimationTimingBootcamp())),
    Lessons(title: "Transition", destination: AnyView(TransitionBootcamp())),
    Lessons(title:"List",destination: AnyView(ListBootcamp())),
    Lessons(title: "Alert", destination: AnyView(AlertBc())),
    Lessons(title: "ActionSheet", destination: AnyView(ActionSheetBootcamp())),
    Lessons(title: "PlaySound", destination: AnyView(PlaySound())),
    Lessons(title: "Text Field", destination: AnyView(TextFieldBootcamp())),
    Lessons(title: "TenaryOperator", destination: AnyView(TenaryOperator())),
    Lessons(title: "Test API", destination: AnyView(API())),
    Lessons(title: "AppStorage", destination: AnyView(AppStorageBootcamp())),
    Lessons(title: "onBoardingwithAppStorage", destination: AnyView(IntroView())),
    Lessons(title: "AsyncImage", destination: AnyView(AsyncImageBootcamp())),
    Lessons(title: "BackgroundMaterials", destination: AnyView(BackgroundMaterialBootcamp())),
    Lessons(title: "TextSelection", destination: AnyView(TextSelectionBootcamp())),
    Lessons(title: "FocusState", destination: AnyView(FocusStateBootcamp()))
    
]

struct ContentView: View {
    @State private var searchText:String = ""
    var body: some View {
        NavigationStack {
            List {
                ForEach(lessons.filter{ searchText.isEmpty || $0.title.localizedStandardContains(searchText)}){item in
                    HStack{
                        Image(systemName:"swift")
                        NavigationLink(item.title,
                                       destination: item.destination)
                        .padding()
                    }
                }
            }.searchable(text: $searchText,prompt: "Search lessons")
                .submitLabel(.next)
                .onSubmit(of: .search) {
                    // Handle search submission
                    print("Search submitted: \(searchText)")
                    // Add any additional actions here
                }
            
                .navigationTitle("Swiftul Learning")
            
            //            List(lessons) { item in
            //                HStack {
            //                    Image(systemName: "swift")
            //
            //                    NavigationLink(item.title, destination: item.destination)
            //                        .padding()
            //
            //                }
            //
            //            }
            //            .listStyle(SidebarListStyle())
            //            .navigationTitle("SwiftUI Learning")
            
            
            
            
            
            
        }
        
        
        
    }
    
}

#Preview {
    ContentView()
}
