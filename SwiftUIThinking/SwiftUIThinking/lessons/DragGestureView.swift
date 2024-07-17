import SwiftUI

struct DragGestureView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<20) { index in
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.blue)
                            .frame(height: 150)
                            .scaleEffect(scaleValue(geo: geo))
                            .opacity(opacityValue(geo: geo))
                            .rotation3DEffect(
                                .degrees(rotationValue(geo: geo)),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    .frame(height: 150)
                }
            }
            .padding()
        }
    }
    
    private func scaleValue(geo: GeometryProxy) -> CGFloat {
        let midX = geo.frame(in: .global).midX
        let screenWidth = UIScreen.main.bounds.width
        let scale = max(0.7, 1 - abs(screenWidth / 2 - midX) / (screenWidth / 2))
        return scale
    }
    
    private func opacityValue(geo: GeometryProxy) -> Double {
        let midX = geo.frame(in: .global).midX
        let screenWidth = UIScreen.main.bounds.width
        let opacity = Double(max(0.5, 1 - abs(screenWidth / 2 - midX) / (screenWidth / 2)))
        return opacity
    }
    
    private func rotationValue(geo: GeometryProxy) -> Double {
        let midX = geo.frame(in: .global).midX
        let screenWidth = UIScreen.main.bounds.width
        let rotation = Double((screenWidth / 2 - midX) / 20)
        return rotation
    }
}


