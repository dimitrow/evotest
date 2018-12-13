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

    weak var scanView: UIView!
    weak var output: ScanServiceOutput?
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    init(_ scanView: UIView) {
        
        super.init()
        
        self.scanView = scanView
        self.captureSession = AVCaptureSession()
        
        if !self.checkIfDeviceCompatible() {
            self.captureSession = nil
            failed()
        }
    }
    
    func attachOutput(output: ScanServiceOutput) {
        
        self.output = output
    }
    
    func startScan() {
        
        guard captureSession != nil else {
            
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.cornerRadius = 0.2
        previewLayer.borderWidth = 1.6
        previewLayer.borderColor = evoBlueColor.cgColor

        previewLayer.frame = scanView.layer.bounds
        scanView.layer.addSublayer(previewLayer)
        captureSession.startRunning()
        animateLayerAppearance(false)
    }
    
    func stopScan() {
        
        guard captureSession != nil, self.previewLayer != nil else { return }
        animateLayerAppearance(true)
    }
    
    private func checkIfDeviceCompatible() -> Bool {
        
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
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .code128, .code39]
        } else {
            return false
        }
        
        return true
    }
    
    private func failed() {
   
        self.output?.scanFailed()
    }
    
    private func animateLayerAppearance(_ reversed: Bool) {

        CATransaction.begin()
        
        var fromValue: CGFloat = 0.0
        var toValue: CGFloat = scanView.frame.height

        if reversed {
            fromValue = previewLayer.bounds.size.height
            previewLayer.bounds.size.height = 0.0
            toValue = 0.0
        }
        
        let animation = CABasicAnimation(keyPath: "bounds.size.height")
        
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        animation.duration = 0.06
        
        CATransaction.setCompletionBlock{ [weak self] in

            if reversed {
                self?.previewLayer.removeFromSuperlayer()
                self?.previewLayer = nil
            }
        }
        previewLayer.add(animation, forKey: nil)
        CATransaction.commit()
    }
}

extension ScanService: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
                
        if let metadataObject = metadataObjects.first {
            
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            guard (self.output != nil) else { return }
            
            captureSession.stopRunning()
            stopScan()
            let notification = UINotificationFeedbackGenerator()
            notification.notificationOccurred(.success)
            
            self.output?.scanSuccessful(stringValue)
        }
    }
}
