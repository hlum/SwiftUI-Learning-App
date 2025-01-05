//
//  ContentView.swift
//  Camera
//
//  Created by Hlwan Aung Phyo on 1/6/25.
//

import SwiftUI

class ContentViewModel:ObservableObject{
    let cameraManager = CameraManager()
    @Published var currentFrame : CGImage?
    
    init(){
        Task{
            await handleCameraPreviews()
        }
    }
    
    func handleCameraPreviews() async{
        for await image in cameraManager.previewStream{
            Task{ @MainActor in
                currentFrame = image
                print("Frame captured: \(String(describing: currentFrame))")
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject private var vm = ContentViewModel()
    var body: some View {
        CameraView(image: $vm.currentFrame)
    }
}

#Preview {
    ContentView()
}
