//
//  VideoRecoderView.swift
//  Messangel
//
//  Created by Saad on 6/15/21.
//

import SwiftUI
import AVKit
import Photos

struct VideoRecoderView: View {
    @State private var onComplete = false
    @State private var isRecording = false
    @StateObject var cameraController = CameraController()
    @StateObject var stopWatch = StopWatchManager()
    
    var body: some View {
        ZStack {
            CameraPreview(cameraController: cameraController)
                .ignoresSafeArea()
            VStack {
                Rectangle()
                    .foregroundColor(.black.opacity(0.01))
                    .frame(height: 60)
                    .overlay(
                        HStack {
                            BackButton()
                                .padding(.leading)
                            Spacer()
                            Text(stopWatch.stopWatchTime)
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .padding(.leading, -16)
                            Spacer()
                        }
                    )
                Spacer()
                RecordingView(isRecording: $isRecording, cameraController: cameraController, stopWatch: stopWatch)
            }
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var cameraController: CameraController
    
    func makeUIView(context: Context) ->  UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
            try? cameraController.displayPreview(on: view)
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct RecordingView: View {
    @Binding var isRecording:Bool
    @ObservedObject var cameraController: CameraController
    @ObservedObject var stopWatch: StopWatchManager
    var body: some View {
        Text("APPUYEZ POUR VOUS ENREGISTRER")
            .foregroundColor(.white)
            .font(.system(size: 13))
            .fontWeight(.semibold)
            .if(isRecording) { $0.hidden() }
        HStack {
            Image("gallery_preview")
                .padding(.leading, -24)
                .if(isRecording) { $0.hidden() }
            Spacer()
            Button(action: {
                DispatchQueue.main.async {
                    isRecording.toggle()
                }
                if !isRecording {
                    stopWatch.start()
                    cameraController.startRecording { url, err in
                        if let url = url {
                            print(url.absoluteString)
                            try? PHPhotoLibrary.shared().performChangesAndWait {
                                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                            }
                        }
                    }
                } else {
                    stopWatch.stop()
                    cameraController.stopRecording { err in
                        if let error = err {
                            print(error.localizedDescription)
                        }
                    }
                }
            }, label: {
                RecordButtonView(isRecording: $isRecording)
            })
            .padding(.leading, -30)
            Spacer()
            Button(action:{
                try? cameraController.switchCameras()
            }) {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.black.opacity(0.5))
                    .frame(width: 56, height: 56)
                    .overlay(Image("ic_toggle_camera"))
            }
            .if(isRecording) { $0.hidden() }
        }
        .padding(.trailing, 16)
    }
}


//struct VideoRecordingView: UIViewRepresentable {
//
//    @Binding var timeLeft: Int
//    @Binding var onComplete: Bool
//    @Binding var recording: Bool
//    func makeUIView(context: UIViewRepresentableContext<VideoRecordingView>) -> PreviewView {
//        let recordingView = PreviewView()
//        recordingView.onComplete = {
//            self.onComplete = true
//        }
//
//        recordingView.onRecord = { timeLeft, totalShakes in
//            self.timeLeft = timeLeft
//            self.recording = true
//        }
//
//        recordingView.onReset = {
//            self.recording = false
//            self.timeLeft = 30
//        }
//        return recordingView
//    }
//
//    func updateUIView(_ uiViewController: PreviewView, context: UIViewRepresentableContext<VideoRecordingView>) {
//
//    }
//}
//
//extension PreviewView: AVCaptureFileOutputRecordingDelegate{
//    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
//        print(outputFileURL.absoluteString)
//    }
//}
//
//class PreviewView: UIView {
//    private var captureSession: AVCaptureSession?
//    private var shakeCountDown: Timer?
//    let videoFileOutput = AVCaptureMovieFileOutput()
//    var recordingDelegate:AVCaptureFileOutputRecordingDelegate!
//    var recorded = 0
//    var secondsToReachGoal = 30
//
//    var onRecord: ((Int, Int)->())?
//    var onReset: (() -> ())?
//    var onComplete: (() -> ())?
//
//    init() {
//        super.init(frame: .zero)
//
//        var allowedAccess = false
//        let blocker = DispatchGroup()
//        blocker.enter()
//        AVCaptureDevice.requestAccess(for: .video) { flag in
//            allowedAccess = flag
//            blocker.leave()
//        }
//        blocker.wait()
//
//        if !allowedAccess {
//            print("!!! NO ACCESS TO CAMERA")
//            return
//        }
//
//        // setup session
//        let session = AVCaptureSession()
//        session.beginConfiguration()
//
//        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
//                                                  for: .video, position: .front)
//        guard videoDevice != nil, let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), session.canAddInput(videoDeviceInput) else {
//            print("!!! NO CAMERA DETECTED")
//            return
//        }
//        session.addInput(videoDeviceInput)
//        session.commitConfiguration()
//        self.captureSession = session
//    }
//
//    override class var layerClass: AnyClass {
//        AVCaptureVideoPreviewLayer.self
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
//        return layer as! AVCaptureVideoPreviewLayer
//    }
//
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        recordingDelegate = self
////        startTimers()
//        if nil != self.superview {
//            self.videoPreviewLayer.session = self.captureSession
//            self.videoPreviewLayer.videoGravity = .resizeAspect
//            self.captureSession?.startRunning()
////            self.startRecording()
//        } else {
//            self.captureSession?.stopRunning()
//        }
//    }
//
//    private func onTimerFires(){
//        print("🟢 RECORDING \(videoFileOutput.isRecording)")
//        secondsToReachGoal -= 1
//        recorded += 1
//        onRecord?(secondsToReachGoal, recorded)
//
//        if(secondsToReachGoal == 0){
////            stopRecording()
//            shakeCountDown?.invalidate()
//            shakeCountDown = nil
//            onComplete?()
//            videoFileOutput.stopRecording()
//        }
//    }
//
//    func startTimers(){
//        if shakeCountDown == nil {
//            shakeCountDown = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
//                self?.onTimerFires()
//            }
//        }
//    }
//
//    func startRecording(){
//        captureSession?.addOutput(videoFileOutput)
//
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let filePath = documentsURL.appendingPathComponent("tempPZDC")
//
//        videoFileOutput.startRecording(to: filePath, recordingDelegate: recordingDelegate)
//    }
//
//    func stopRecording(){
//        videoFileOutput.stopRecording()
//        print("🔴 RECORDING \(videoFileOutput.isRecording)")
//    }
//}
//
//
////////////////////----------------------////////////////////
//
//
//struct CameraView: View {
//
//    @StateObject var camera = CameraModel()
//
//    var body: some View{
//
//        ZStack{
//
//            // Going to Be Camera preview...
//            CameraPreview(camera: camera)
//                .ignoresSafeArea(.all, edges: .all)
//
//            VStack{
//
//                if camera.isTaken{
//
//                    HStack {
//
//                        Spacer()
//
//                        Button(action: camera.reTake, label: {
//
//                            Image(systemName: "arrow.triangle.2.circlepath.camera")
//                                .foregroundColor(.black)
//                                .padding()
//                                .background(Color.white)
//                                .clipShape(Circle())
//                        })
//                        .padding(.trailing,10)
//                    }
//                }
//
//                Spacer()
//
//                HStack{
//
//                    // if taken showing save and again take button...
//
//                    if camera.isTaken{
//
//                        Button(action: {if !camera.isSaved{camera.savePic()}}, label: {
//                            Text(camera.isSaved ? "Saved" : "Save")
//                                .foregroundColor(.black)
//                                .fontWeight(.semibold)
//                                .padding(.vertical,10)
//                                .padding(.horizontal,20)
//                                .background(Color.white)
//                                .clipShape(Capsule())
//                        })
//                        .padding(.leading)
//
//                        Spacer()
//                    }
//                    else{
//
//                        Button(action: camera.takePic, label: {
//
//                            ZStack{
//
//                                Circle()
//                                    .fill(Color.white)
//                                    .frame(width: 65, height: 65)
//
//                                Circle()
//                                    .stroke(Color.white,lineWidth: 2)
//                                    .frame(width: 75, height: 75)
//                            }
//                        })
//                    }
//                }
//                .frame(height: 75)
//            }
//        }
//        .onAppear(perform: {
//
//            camera.Check()
//        })
//        .alert(isPresented: $camera.alert) {
//            Alert(title: Text("Please Enable Camera Access"))
//        }
//    }
//}
//
//// Camera Model...
//
//class CameraModel: NSObject,ObservableObject,AVCapturePhotoCaptureDelegate{
//
//    @Published var isTaken = false
//
//    @Published var session = AVCaptureSession()
//
//    @Published var alert = false
//
//    // since were going to read pic data....
//    @Published var output = AVCapturePhotoOutput()
//
//    // preview....
//    @Published var preview : AVCaptureVideoPreviewLayer!
//
//    // Pic Data...
//
//    @Published var isSaved = false
//
//    @Published var picData = Data(count: 0)
//
//    func Check(){
//
//        // first checking camerahas got permission...
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//        case .authorized:
//            setUp()
//            return
//            // Setting Up Session
//        case .notDetermined:
//            // retusting for permission....
//            AVCaptureDevice.requestAccess(for: .video) { (status) in
//
//                if status{
//                    self.setUp()
//                }
//            }
//        case .denied:
//            self.alert.toggle()
//            return
//
//        default:
//            return
//        }
//    }
//
//    func setUp(){
//
//        // setting up camera...
//
//        do{
//
//            // setting configs...
//            self.session.beginConfiguration()
//
//            // change for your own...
//
//            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
//
//            let input = try AVCaptureDeviceInput(device: device!)
//
//            // checking and adding to session...
//
//            if self.session.canAddInput(input){
//                self.session.addInput(input)
//            }
//
//            // same for output....
//
//            if self.session.canAddOutput(self.output){
//                self.session.addOutput(self.output)
//            }
//
//            self.session.commitConfiguration()
//        }
//        catch{
//            print(error.localizedDescription)
//        }
//    }
//
//    // take and retake functions...
//
//    func takePic(){
//
//        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
//
//        DispatchQueue.global(qos: .background).async {
//
//            self.session.stopRunning()
//
//            DispatchQueue.main.async {
//
//                withAnimation{self.isTaken.toggle()}
//            }
//        }
//    }
//
//    func reTake(){
//
//        DispatchQueue.global(qos: .background).async {
//
//            self.session.startRunning()
//
//            DispatchQueue.main.async {
//                withAnimation{self.isTaken.toggle()}
//                //clearing ...
//                self.isSaved = false
//                self.picData = Data(count: 0)
//            }
//        }
//    }
//
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//
//        if error != nil{
//            return
//        }
//
//        print("pic taken...")
//
//        guard let imageData = photo.fileDataRepresentation() else{return}
//
//        self.picData = imageData
//    }
//
//    func savePic(){
//
//        guard let image = UIImage(data: self.picData) else{return}
//
//        // saving Image...
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//
//        self.isSaved = true
//
//        print("saved Successfully....")
//    }
//}
