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

            }
            ButtonCodePreview(code:.AnimationBc)
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
