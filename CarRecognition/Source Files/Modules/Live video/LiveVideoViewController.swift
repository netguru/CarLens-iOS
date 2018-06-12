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
        customView.checkDetailsButton.addTarget(self, action: #selector(didTapCheckDetailsButton), for: .touchUpInside)
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
        session.sessionPreset = .vga640x480
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: backCamera) else { return }
        session.addInput(input)
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .userInitiated))
        session.addOutput(output)
        output.connection(with: .video)?.videoOrientation = .portrait
        
        videoPreviewLayer?.removeFromSuperlayer()
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        guard let videoPreviewLayer = videoPreviewLayer else { return }
        videoPreviewLayer.videoGravity = .resizeAspectFill
        customView.previewView.layer.addSublayer(videoPreviewLayer)
    }
    
    private func handleRecognition(result: CarRecognizeResponse) {
        customView.analyzeTimeLabel.text = CRTimeFormatter.intervalMilisecondsFormatted(result.analyzeDuration)
        
        let labels = [customView.modelFirstLabel, customView.modelSecondLabel, customView.modelThirdLabel]
        for (index, element) in result.cars.prefix(3).enumerated() {
            labels[index].text = "\(element.car)\n(\(CRNumberFormatter.percentageFormatted(element.confidence)))"
        }
    }
    
    @objc private func didTapCheckDetailsButton() {
        guard let lastRecognition = carRecognizerService.lastTopRecognition else { return }
        let carDetailsViewController = CarDetailsViewController(recognizedCars: lastRecognition)
        navigationController?.pushViewController(carDetailsViewController, animated: true)
    }
}
