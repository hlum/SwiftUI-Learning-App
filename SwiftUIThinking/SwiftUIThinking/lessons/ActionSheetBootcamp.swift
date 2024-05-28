//
//  ActionSheetBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/28.
//

import SwiftUI

struct ActionSheetBootcamp: View {
    @State var showActionSheet: Bool = false
    var body: some View {
        Button("Click me"){
            showActionSheet.toggle()
        }
        .actionSheet(isPresented: $showActionSheet, content: getActionSheet)
    }
    func getActionSheet() -> ActionSheet{
        return ActionSheet(title: Text("This is title"))
    }
}

#Preview {
    ActionSheetBootcamp()
}
