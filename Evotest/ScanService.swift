//
//  ScanService.swift
//  Evotest
//
//  Created by Eugene Dimitrow on 07/12/2018.
//  Copyright © 2018 Eugene Dimitrov. All rights reserved.
//

import UIKit
import AVFoundation

class ScanService: NSObject {

    weak var scanView: UIView?
    weak var output: ScanServiceOutput?
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    init(_ scanView: UIView) {
        
        super.init()
        
        self.scanView = scanView
        captureSession = AVCaptureSession()
        
        
        if self.checkIfDeviceCompatible() {
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = scanView.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
        }
        
        
    }
    
    func checkIfDeviceCompatible() -> Bool {
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return false }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return false
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return false
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
//            failed()
            return false
        }
        
        return true
    }
    
    func attachOutput(output: ScanServiceOutput) {
        
        self.output = output
    }
    
    func startScan() {
        
        scanView?.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
    
    func stopScan() {
        
        self.previewLayer.removeFromSuperlayer()
        captureSession.stopRunning()
    }
    
    func failed() {

        captureSession = nil
    }
    
}

extension ScanService: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
                
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            guard (self.output != nil) else { return }
            
            self.stopScan()
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            self.output?.scanSuccessfull(with: stringValue)
        }
    }
}
