//
//  CIImage.swift
//  Camera
//
//  Created by Hlwan Aung Phyo on 1/6/25.
//

import CoreImage

extension CIImage{
    
    var cgImage : CGImage? {
        let cIContext = CIContext()
        
        guard let cgImage = cIContext.createCGImage(self, from: self.extent) else{
            return nil
        }
        
        return cgImage
    }
}
