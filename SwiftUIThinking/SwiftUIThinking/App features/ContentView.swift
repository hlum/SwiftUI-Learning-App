import SwiftUI

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
    Lessons(title: "ActionSheet", destination: AnyView(ActionSheetBootcamp()))
]

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(lessons) { item in
                HStack {
                    Image(systemName: "swift")
                    
                    NavigationLink(item.title, destination: item.destination)
                        .padding()
                    
                }
                
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("SwiftUI Learning")
            
            
            
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
