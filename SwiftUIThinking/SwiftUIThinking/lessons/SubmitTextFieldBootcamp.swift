//
//  SubmitTextFieldBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/15.
//

import SwiftUI

struct SubmitTextFieldBootcamp: View {
    @State var text:String = ""
    var body: some View {
        TextField("Placeholder...", text: $text)
            .submitLabel(.continue)
            .onSubmit {
                print(text)
            }
    }
}

#Preview {
    SubmitTextFieldBootcamp()
}
