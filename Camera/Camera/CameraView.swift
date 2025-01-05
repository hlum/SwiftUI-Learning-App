//
//  CameraView.swift
//  Camera
//
//  Created by Hlwan Aung Phyo on 1/6/25.
//

import SwiftUI

struct CameraView: View {
    @Binding var image:CGImage?
    var body: some View {
        if let image = image{
            Image(image, scale: 1, label: Text("Camera"))
        }
    }
}
