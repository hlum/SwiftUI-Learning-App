import SwiftUI
import AVFoundation

struct PlaySound: View {
    // Make the player an instance variable
    @State private var player: AVAudioPlayer?

    var body: some View {
        
        Button(action: {
            playSound()
        }) {
            Text("助けて")
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    

    func playSound() {
        guard let url = Bundle.main.url(forResource: "sound", withExtension: "wav") else {
            print("Sound file not found")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    

}

#Preview {
    PlaySound()
}
