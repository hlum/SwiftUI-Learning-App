import SwiftUI

struct AnimationTimingBootcamp: View {
    @State var isAnimating : Bool = false
    @State var animationStyle: Animation = .linear(duration: 10.0)

    var body: some View {
        ButtonCodePreview(code: .AnimationTimingBc)
        VStack {
            HStack {
                Button("Button") {
                    isAnimating.toggle()
                }
                Button("Linear") {
                    animationStyle = .linear(duration: 10.0)
                    isAnimating.toggle()
                }
                Button("Ease In Out") {
                    animationStyle = .easeInOut(duration: 10)
                    isAnimating.toggle()
                }
                Button("Ease In") {
                    animationStyle = .easeIn(duration: 10)
                    isAnimating.toggle()
                }
                Button("Ease Out") {
                    animationStyle = .easeOut(duration: 10)
                    isAnimating.toggle()
                }
                Button("Bounce") {
                    animationStyle = .spring(response: 0.6,                                 dampingFraction: 0.3,
                        blendDuration: 1.0)
                    isAnimating.toggle()
                }
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimating ? 350 : 50, height: 100)
                .animation(animationStyle, value: isAnimating)
        }
    }
}

#Preview {
    AnimationTimingBootcamp()
}
