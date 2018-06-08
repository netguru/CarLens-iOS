//
//  LiveVideoViewController.swift
//  CarRecognition
//


import UIKit
import AVFoundation

internal final class LiveVideoViewController: TypedViewController<LiveVideoView>, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private var session: AVCaptureSession?
    
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    private let carRecognizerService = CarRecognizerService()
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        carRecognizerService.completionHandler = { [weak self] result in
            self?.handleRecognition(result: result)
        }
    }
    
    /// SeeAlso: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSession()
        session?.startRunning()
    }
    
    /// SeeAlso: UIViewController
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session?.stopRunning()
    }
    
    /// SeeAlso: UIViewController
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPreviewLayer?.frame = customView.previewView.bounds
    }
    
    /// SeeAlso: AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        carRecognizerService.perform(on: imageBuffer)
    }
    
    private func setupSession() {
        session = AVCaptureSession()
        guard let session = session else { return }
        session.sessionPreset = .hd1280x720
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: backCamera) else { return }
        session.addInput(input)
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .userInitiated))
        session.addOutput(output)
        
        videoPreviewLayer?.removeFromSuperlayer()
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        guard let videoPreviewLayer = videoPreviewLayer else { return }
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        customView.previewView.layer.addSublayer(videoPreviewLayer)
    }
    
    private func handleRecognition(result: CarRecognizeResponse) {
        guard let first = result.cars.first else { return }
        if first.confidence > 0.6 {
            customView.modelLabel.text = "\(first.car)\n(\(CRNumberFormatter.percentageFormatted(first.confidence)))"
            customView.analyzeTimeLabel.text = CRTimeFormatter.intervalMilisecondsFormatted(result.analyzeDuration)
        } else {
            customView.modelLabel.text = ""
        }
    }
}
