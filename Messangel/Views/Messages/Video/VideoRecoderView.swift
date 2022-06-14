//
//  VideoRecoderView.swift
//  Messangel
//
//  Created by Saad on 6/15/21.
//

import SwiftUI
import AVKit
import Photos
import NavigationStack

struct VideoRecoderView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var onComplete = false
    @State private var isRecording = false
    @StateObject var cameraController = CameraController()
    @StateObject var stopWatch = StopWatchManager()

    
    var body: some View {
        NavigationStackView("VideoRecoderView") {
            ZStack {
                Color.black
                    .ignoresSafeArea()
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
                    RecordingView(navigationModel: navigationModel, isRecording: $isRecording, cameraController: cameraController, stopWatch: stopWatch)
                }
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
    var navigationModel: NavigationModel
    @Binding var isRecording:Bool
    @ObservedObject var cameraController: CameraController
    @ObservedObject var stopWatch: StopWatchManager
    @State var showPicker = false
    @State var videoUrl = NSURL()
    
    fileprivate func trimVideoAtUrl(_ url: URL) {
        let asset = AVURLAsset(url: url, options: nil)
        let playermanager = PlayerViewModel(videoUrl: url)
        navigationModel.pushContent("VideoRecoderView") {
            VideoTrimView(videoUrl: .constant(url), asset: asset, playerVM: playermanager, slider: CustomSlider(start: 1, end: asset.duration.seconds))
        }
    }
    
    var body: some View {
        Text("APPUYEZ POUR VOUS ENREGISTRER")
            .foregroundColor(.white)
            .font(.system(size: 13))
            .fontWeight(.semibold)
            .if(isRecording) { $0.hidden() }
        HStack {
            Button {
                showPicker.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.black.opacity(0.5))
                    .frame(width: 56, height: 56)
                    .overlay(Image("ic_gallery"))
            }
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
                            trimVideoAtUrl(url)
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
        .padding()
        .sheet(isPresented: $showPicker) {
            VideoPicker(videoUrl: $videoUrl, isShown: $showPicker)
        }
        .onChange(of: videoUrl) { value in
            if value.isFileURL {
                trimVideoAtUrl(value as URL)
            }
        }
    }
}
