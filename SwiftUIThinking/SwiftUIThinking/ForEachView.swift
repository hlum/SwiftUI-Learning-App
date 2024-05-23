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
            ForEach(0..<10){ index in
                Text("\(index)")
            }
        }
        
    }
}


struct ForEachDataView: View {
    
    let data: [String] = ["I","Hello","afs"]
    
    var body: some View {
        VStack{
            ForEach(data.indices){index in
                Text("\(data[index])")
            }
            ButtonCodePreview(code: .forEachView)
        }
            }
}

#Preview {
    ForEachDataView()
}

