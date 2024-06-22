//
//  SoundEffectsBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/22.
//

import SwiftUI
import AVKit


class SoundManager {
    
    
    static let instance = SoundManager()
    
    var player:AVAudioPlayer?
    
    
    enum SoundOption:String{
        case sound
        case make
    }
    
    func playSound(sound:SoundOption,extensionName:String){
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: extensionName) else {return}
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch let error{
            print("Error playing sound. \(error.localizedDescription)")
        }
        
        
    }
    
    
}

struct SoundEffectsBootcamp: View {
    var body: some View {
        VStack(spacing: 40){
            Button("Play Sound 1"){
                SoundManager.instance.playSound(sound: .sound,extensionName: "wav")
            }
            Button("Play Sound 2"){
                SoundManager.instance.playSound(sound: .make,extensionName: "mp3")
            }
        }
    }
}

#Preview {
    SoundEffectsBootcamp()
}
