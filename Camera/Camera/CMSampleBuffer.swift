//
//  CMSampleBuffer.swift
//  Camera
//
//  Created by Hlwan Aung Phyo on 1/6/25.
//

import AVFoundation
import CoreImage

extension CMSampleBuffer{
    
    var cgImage:CGImage?{
        let pixelBuffer : CVPixelBuffer? = CMSampleBufferGetImageBuffer(self)
        
        guard let imagePixelBuffer = pixelBuffer else{
            print("nil")
            return nil
        }
        
        return CIImage(cvPixelBuffer: imagePixelBuffer).cgImage
    }
}
