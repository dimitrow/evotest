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
        captureSession = AVCaptureSession()
        
        
        if !self.checkIfDeviceCompatible() {
            captureSession = nil
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
        previewLayer.frame = scanView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.backgroundColor = UIColor.red.cgColor
        previewLayer.cornerRadius = 10.0
        previewLayer.borderWidth = 0.6
        previewLayer.borderColor = UIColor.lightGray.cgColor
        
        scanView.layer.addSublayer(previewLayer)

        animateLayerAppearance(false)
    }
    
    func stopScan() {
        
//        guard captureSession != nil, self.previewLayer != nil else { return }
        
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
        
        // why I come her more then once????
        guard self.captureSession != nil, self.previewLayer != nil else { return }
        
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
        
        animation.duration = 0.075
        animation.isRemovedOnCompletion = false
        
        CATransaction.setCompletionBlock{ [weak self] in
            if !reversed {
                self?.captureSession.startRunning()
            } else {
                self?.captureSession.stopRunning()
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
            
            self.stopScan()
            let notification = UINotificationFeedbackGenerator()
            notification.notificationOccurred(.success)
            
            self.output?.scanSuccessful(stringValue)
        }
    }
}
