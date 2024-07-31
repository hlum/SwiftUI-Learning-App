//
//  CircleButtonView.swift
//  Crypto Tracker
//
//  Created by Hlwan Aung Phyo on 2024/07/23.
//

import SwiftUI

struct CircleButtonView: View {
    var body: some View {
        Image(systemName:"heart.fill")
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width:58,height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0.0, y: 0.0)
            .padding()
        
    }
}


#Preview {
    Group{
        CircleButtonView()
            .padding()
        CircleButtonView()
            .padding()
            .colorScheme(.dark)
    }
    .previewLayout(.sizeThatFits)
    
}
