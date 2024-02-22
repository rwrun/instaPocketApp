//
//  CameraService.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 13.02.2024.
//

import AVFoundation

protocol CameraServiceProtocol: AnyObject{
    var captureSession: AVCaptureSession { get set }
    var output: AVCapturePhotoOutput { get set }
    
    func setupCaptureSession()
    func stopSession()
    func switchCamera()
}

class CameraService: CameraServiceProtocol{
    private var captureDevice: AVCaptureDevice?
    private let cameraQueue = DispatchQueue(label: "ru.namari.CaptureQueue")
    
    
    private var backCamera: AVCaptureDevice?
    private var frontCamera: AVCaptureDevice?
    
    private var backInput: AVCaptureDeviceInput!
    private var frontInput: AVCaptureDeviceInput!
    
    private var isBackCamera = true
    
    var captureSession: AVCaptureSession = AVCaptureSession()
    var output: AVCapturePhotoOutput = AVCapturePhotoOutput()
    
    
    
    
    func setupCaptureSession() {
        cameraQueue.async { [weak self] in
            self?.captureSession.beginConfiguration()
            
            if let isSetPreset = self?.captureSession.canSetSessionPreset(.photo),
               isSetPreset {
                self?.captureSession.sessionPreset = .photo
            }
            self?.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            self?.setInputs()
            self?.setOutputs()
            
            self?.captureSession.commitConfiguration()
            self?.captureSession.startRunning()
            
        }
    }
    
    private func setInputs(){
        backCamera = currentDevice()
        frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        
        guard let backCamera = backCamera,
        let frontCamera = frontCamera else { return }
        
        do {
            backInput = try AVCaptureDeviceInput(device: backCamera)
            guard captureSession.canAddInput(backInput) else { return }
            
            frontInput = try AVCaptureDeviceInput(device: frontCamera)
            guard captureSession.canAddInput(frontInput) else { return }
            
            captureSession.addInput(backInput)
            captureDevice = backCamera
            
        } catch {
            fatalError("not connected camera")
        }
    }
    
    private func setOutputs(){
        guard captureSession.canAddOutput(output) else { return }
        output.maxPhotoQualityPrioritization = .balanced
        captureSession.addOutput(output)
    }
    
    func stopSession() {
        captureSession.stopRunning()
        captureSession.removeInput(backInput)
        captureSession.removeInput(frontInput)
        isBackCamera = true
    }
    
    func switchCamera() {
        captureSession.beginConfiguration()
        if isBackCamera {
            captureSession.removeInput(backInput)
            captureSession.addInput(frontInput)
            captureDevice = frontCamera
            isBackCamera = false
        } else {
            captureSession.removeInput(frontInput)
            captureSession.addInput(backInput)
            captureDevice = backCamera
            isBackCamera = true
        }
        captureSession.commitConfiguration()
    }
    
    private func currentDevice() -> AVCaptureDevice? {
        let sessionDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInTripleCamera, .builtInDualCamera, .builtInWideAngleCamera, .builtInDualWideCamera],
                                                             mediaType: .video, position: .back)
        
        guard let device = sessionDevice.devices.first else { return nil }
        return device
    }
    
    
}
