import SwiftUI

// Main view that presents a button and a sheet
struct ButtonCodePreview: View {
    @State private var isPresented: Bool = false // State variable to manage the presentation of the sheet
    var code: String // Variable to hold the code to be displayed in the sheet

    // Custom initializer to set the `code` variable based on the provided `Code` enum value
    init(code: Code) {
        switch code {
        case .initializedV:
            self.code = """
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
        }
    }
    
    // Enum to specify the different code options
    enum Code {
        case initializedV
        case forEachView
        case scrollViewBootCamp
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
        .sheet(isPresented: $isPresented) {
            VStack {
                ScrollView {
                    Text(code) // Display the selected code
                        .padding()
                }
                .padding()
            }
        }
    }
}

struct ButtonCodePreview_Previews: PreviewProvider {
    static var previews: some View {
        ButtonCodePreview(code: .forEachView) // Provide a default code option for preview
    }
}
