//
//  CameraManager.swift
//  Camera
//
//  Created by Hlwan Aung Phyo on 1/6/25.
//

//AsyncStream についての説明：https://qiita.com/tomoyuki_HAYAKAWA/items/8b5a3a3b801fc622553f

import Foundation
import AVFoundation

class CameraManager:NSObject{
    private var addToPreviewStream:((CGImage)->Void)?

    override init(){
        super.init()
        
        Task{
            await configureSession()
            await startSession()
        }
    }
    
    private let captureSession = AVCaptureSession()
    
    private var deviceInput:AVCaptureDeviceInput?
    
    private var videoOutput:AVCaptureVideoDataOutput?
    
    private let systemPreferredCamera = AVCaptureDevice.default(for: .video)
    
    private var sessionQueue = DispatchQueue(label: "video.preview.session")
    
    private var isAuthorized:Bool{
        get async{
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            
            if status == .notDetermined{
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }

    lazy var previewStream:AsyncStream<CGImage> = {
        AsyncStream{ continuation in
            addToPreviewStream = { cgImage in
                continuation.yield(cgImage)
            }
        }
    }()
    
    private func configureSession() async {
        guard await isAuthorized,
              let systemPreferredCamera,
              let deviceInput = try? AVCaptureDeviceInput(device: systemPreferredCamera) else{return}
        
        captureSession.beginConfiguration()
        
        defer{
//            At the end of the execution of the method commits the configuration to the running session
            self.captureSession.commitConfiguration()
        }
        
//        Define the video output and set the Sample Buffer Delegate and the queue for invoking callbacks
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        
        guard captureSession.canAddInput(deviceInput) else{
            print("Unable to add device input to capture session.")
            return
        }
        
        guard captureSession.canAddOutput(videoOutput) else{
            print("Unable to add video output to capture session.")
            return
        }
        
        captureSession.addInput(deviceInput)
        captureSession.addOutput(videoOutput)
        
    }
    
    private func startSession() async {
        guard await isAuthorized else{return}
        
        captureSession.startRunning()
    }
}


extension CameraManager : AVCaptureVideoDataOutputSampleBufferDelegate{
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let currentFrame = sampleBuffer.cgImage else{return}
        connection.videoOrientation = .portrait
        addToPreviewStream?(currentFrame)
    }
}
