//
//  QRScannerView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI
import AVKit
import PhotosUI

enum Permission: String {
    case approved = "Access Granted"
    case denied = "Access Denied"
    case unknown = "Not Determined"
}

struct QRScannerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.openURL) private var openURL
    @EnvironmentObject var data: CryptoAppData
    @State var cameraPermission: Permission = .unknown
    @State private var session: AVCaptureSession = .init()
    @State private var qrScannerOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var isTorchOn: Bool = false
    @StateObject private var qrScannerDelegate = QRScannerViewDelegate()
    @State private var device: AVCaptureDevice? = nil
    @State private var qrImagePickerItem: PhotosPickerItem? = nil
    @Binding var scannedCode: String
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader {
                let size = $0.size
                
                ScannerView(frameSize: CGSize(width: size.width, height: size.height), session: $session)
                    .overlay(
                        ZStack {
                            Color(.black.withAlphaComponent(0.5))
                            
                            RoundedRectangle(cornerRadius: 4.0)
                                .frame(width: 200, height: 200)
                                .blendMode(.destinationOut)
                            ZStack {
                                ForEach(0...4, id: \.self){ index in
                                    let rotation = Double(index) * 90
                                    RoundedRectangle(cornerRadius: 2.0, style: .circular)
                                        .trim(from: 0.35, to: 0.4)
                                        .stroke(.white.opacity(0.7), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                        .rotationEffect(.init(degrees: rotation))
                                }
                            }
                            .frame(width: 200.0, height: 200.0)
                        }
                        .compositingGroup()
                    )
                    .overlay(
                        VStack {
                            Spacer()
                            HStack {
                                Button {
                                    isTorchOn.toggle()
                                    toggleTorchMode()
                                } label: {
                                    Image(isTorchOn ? "bolt" : "bolt-slash")
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 36.0, height: 36.0)
                                        .foregroundColor(isTorchOn ? Colors.brown : .gray)
                                }
                                Spacer()
                                
                                PhotosPicker(selection: $qrImagePickerItem, matching: .images) {
                                    Image("photo-library")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 36.0, height: 36.0)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal, 64.0)
                        .padding(.bottom, 84.0)
                    )
            }
            CustomText(
                name: data.strings.qrCameraInstruction,
                textColor: .white,
                alignment: .center,
                font: Fonts.regularFont14)
            .padding(.horizontal)
            .padding(.top, 24.0)
        }
        .ignoresSafeArea(.all, edges: [.bottom])
        .background(
            BackgroundGradientView()
        )
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                qrScannerDelegate.scannedCode = nil
                scannedCode = ""
                clearSession()
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("back")
                    .padding(.leading, 12)
            }
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                ToolbarContentView(title: data.strings.scanQRCodeSetting)
            }
        }
        .onAppear(perform: checkCameraPermission)
        .onChange(of: qrScannerDelegate.scannedCode, perform: { newValue in
            if let code = newValue {
                qrScannerDelegate.scannedCode = nil
                scannedCode = code
                clearSession()
                presentationMode.wrappedValue.dismiss()
            }
        })
        .alert(errorMessage, isPresented: $showError) {
            if cameraPermission == .denied {
                Button(data.strings.settings) {
                    UIApplication.openAppSetting()
                }
                
                Button(data.strings.cancel, role: .cancel) {
                    
                }
            }
        }
        .onChange(of: qrImagePickerItem) { _ in
            Task {
                guard let data = try? await qrImagePickerItem?.loadTransferable(type: Data.self),
                      let code = UIImage(data: data)?.parseQRCode() else {
                    qrImagePickerItem = nil
                    return
                }
                
                qrScannerDelegate.scannedCode = nil
                scannedCode = code
                clearSession()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func setupCamera() {
        do {
            guard let camera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                displayErrorMessage("⚠️ Unknown Error!!!")
                return
            }
            
            device = camera
            
            let input = try AVCaptureDeviceInput(device: device!)
            
            /// for added security, confirming whether Input and Output can be added to the session
            guard session.canAddInput(input),
                  session.canAddOutput(qrScannerOutput) else {
                displayErrorMessage("⚠️ Unknown Error!!!")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrScannerOutput)
            qrScannerOutput.metadataObjectTypes = [.qr]
            qrScannerOutput.setMetadataObjectsDelegate(qrScannerDelegate, queue: .main)
            
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
        }catch {
            displayErrorMessage(error.localizedDescription)
        }
    }
    
    func toggleTorchMode() {
        guard let device = device else {
            print("Device not set")
            return
        }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if isTorchOn == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                setupCamera()
            case .notDetermined:

                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    setupCamera()
                }else {
                    cameraPermission = .denied
                    displayErrorMessage(data.strings.enableCameraInstruction)
                }
            case .denied, .restricted:
                cameraPermission = .denied
                displayErrorMessage(data.strings.enableCameraInstruction)
            default: break
            }
        }
    }
    
    func displayErrorMessage(_ message: String) {
        errorMessage = message
        showError.toggle()
    }
    
    func clearSession() {
        
        session.stopRunning()
        
        if !session.inputs.isEmpty {
            session.inputs.forEach { input in
                session.removeInput(input)
            }
        }
        
        if !session.outputs.isEmpty {
            session.outputs.forEach { output in
                session.removeOutput(output)
            }
        }
    }
}

struct QRScannerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QRScannerView(scannedCode: .constant(""))
                .environmentObject(CryptoAppData())
        }
    }
}

