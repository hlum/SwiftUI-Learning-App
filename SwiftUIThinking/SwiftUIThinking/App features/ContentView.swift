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
    Lessons(title: "AppStorage", destination: AnyView(AppStorageBootcamp())),
    Lessons(title: "onBoardingwithAppStorage", destination: AnyView(IntroView())),
    Lessons(title: "AsyncImage", destination: AnyView(AsyncImageBootcamp())),
    Lessons(title: "BackgroundMaterials", destination: AnyView(BackgroundMaterialBootcamp())),
    Lessons(title: "TextSelection", destination: AnyView(TextSelectionBootcamp())),
    Lessons(title: "FocusState", destination: AnyView(FocusStateBootcamp())),
    Lessons(title: "Long Press Gesture", destination: AnyView(LongPressGestureBootcamp())),
    Lessons(title: "Magnification Gesture", destination: AnyView(MagnificationGestureBootcamp())),
    Lessons(title: "Mask Bootcamp", destination: AnyView(MaskBootcamp())),
    Lessons(title: "Haptic", destination: AnyView(HapticBootcamp())),
    Lessons(title: "Local Notification", destination: AnyView(NotificationBootcamp())),
//    Lessons(title: "Core Data", destination: AnyView(CoreDataBootcamp())),
//    Lessons(title: "CoreData Relationships", destination: AnyView(CoreDataRelationshipsBootcamp()))
]

struct ContentView: View {
    @State private var searchText: String = ""
    
    var filteredLessons: [Lessons] {
        lessons.filter { searchText.isEmpty || $0.title.localizedStandardContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if filteredLessons.isEmpty {
                    ContentUnavailableView
                    .search(text:searchText)
                } else {
                    ForEach(filteredLessons) { item in
                        HStack {
                            Image(systemName: "swift")
                            NavigationLink(item.title, destination: item.destination)
                                .padding()
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search lessons")
            .submitLabel(.next)
            .onSubmit(of: .search) {
                // Handle search submission
                print("Search submitted: \(searchText)")
                // Add any additional actions here
            }
            .navigationTitle("SwiftUI Learning")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    

}

#Preview {
    ContentView()
}
