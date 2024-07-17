//
//  TimerBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/07/17.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in:.common).autoconnect()
    @State var currentDate : Date = Date()
    var body: some View {
        ZStack{
            RadialGradient(
                gradient: Gradient(colors:[Color.purple,Color.blue]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            
            Text(currentDate.description)
                .font(.system(size: 100,weight: .semibold,design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
            
        }
        .onReceive(timer) { value in
            currentDate = value
        }
        
    }
}

#Preview {
    TimerBootcamp()
}
