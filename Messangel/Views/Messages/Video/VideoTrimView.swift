//
//  VideoTrimView.swift
//  Messangel
//
//  Created by Saad on 8/20/21.
//

import SwiftUI
import Combine
import AVKit
import MobileCoreServices
import NavigationStack
import UniformTypeIdentifiers

struct VideoTrimView: View {
    @Binding var videoUrl: URL
    var asset: AVURLAsset
    @State private var frames = [UIImage]()
    @State private var fullScreen = false
    @StateObject var playerVM: PlayerViewModel
    @ObservedObject var slider: CustomSlider
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        Group {
            if fullScreen {
                MsgVideoPlayerView(fullScreen: $fullScreen, playerVM: playerVM)
            } else {
                NavigationStackView("VideoTrimView") {
                    MenuBaseView(height: 60, title: "Aperçu") {
                        MsgVideoPlayerView(fullScreen: $fullScreen, playerVM: playerVM)
                        SliderView(playerManager: playerVM, slider: slider, frames: frames, handleMoved: .constant(slider.lowHandle.currentValue > 1 || slider.highHandle.currentValue < asset.duration.seconds))
                            .padding(.vertical, 50)
                        HStack {
                            Spacer()
                            Button(action: {
                                if slider.lowHandle.currentValue > 1 || slider.highHandle.currentValue < asset.duration.seconds {
                                    cropVideo(sourceURL1: videoUrl, statTime: Float(slider.lowHandle.currentValue), endTime: Float(slider.highHandle.currentValue)) { result in
                                        switch result {
                                            
                                        case .success(let outputUrl):
                                            navigationModel.pushContent("VideoTrimView") {
                                                VideoFilterView(filename: outputUrl)
                                            }
                                        case .failure(let err):
                                            print(err)
                                        }
                                    }
                                } else {
                                    navigationModel.pushContent("VideoTrimView") {
                                        VideoFilterView(filename: videoUrl)
                                    }
                                }
                            }, label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.accentColor)
                                        .frame(width: 56, height: 56)
                                        .cornerRadius(25)
                                    Image(systemName: "chevron.right").foregroundColor(.white)
                                }
                            })
                        }
                    }
                }
            }
        }
        .onDidAppear() {
            getVideoFrames()
        }
        .onChange(of: playerVM.isFinishedPlaying) { finished in
            if finished {
                playerVM.seekVideo(toPosition: CGFloat(slider.lowHandle.currentValue))
            }
        }
        .onChange(of: slider.lowHandle.currentValue) { value in
            playerVM.seekVideo(toPosition: CGFloat(value))
        }
        .onChange(of: slider.highHandle.currentValue) { value in
            playerVM.seekVideo(toPosition: CGFloat(value))
        }
    }
    func getVideoFrames() {
        let videoDuration = asset.duration
        
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        var frameForTimes = [NSValue]()
        let sampleCounts = 17
        let totalTimeLength = Int(videoDuration.seconds * Double(videoDuration.timescale))
        let step = totalTimeLength / sampleCounts
        
        for i in 0 ..< sampleCounts {
            let cmTime = CMTimeMake(value: Int64(i * step), timescale: Int32(videoDuration.timescale))
            frameForTimes.append(NSValue(time: cmTime))
        }
        
        generator.generateCGImagesAsynchronously(forTimes: frameForTimes, completionHandler: {requestedTime, image, actualTime, result, error in
            DispatchQueue.main.async {
                if let image = image {
                    print(requestedTime.value, requestedTime.seconds, actualTime.value)
                    self.frames.append(UIImage(cgImage: image))
                }
            }
        })
    }
    
    func cropVideo(sourceURL1: URL, statTime:Float, endTime:Float, completion: @escaping (Result<URL,Error>) -> Void ) {
        let manager = FileManager.default
        
        guard let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return}
        let mediaType = "mp4"
        //        if mediaType == kUTTypeMovie as String || mediaType == "mp4" as String {
        if mediaType == UTType.movie.identifier as String || mediaType == "mp4" as String {
            let asset = AVAsset(url: sourceURL1 as URL)
            let length = Float(asset.duration.value) / Float(asset.duration.timescale)
            print("video length: \(length) seconds")
            
            let start = statTime
            let end = endTime
            
            var outputURL = documentDirectory.appendingPathComponent("output")
            do {
                try manager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
                outputURL = outputURL.appendingPathComponent("\(UUID().uuidString).\(mediaType)")
            }catch let error {
                print(error)
            }
            
            //Remove existing file
            _ = try? manager.removeItem(at: outputURL)
            
            
            guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {return}
            exportSession.outputURL = outputURL
            exportSession.outputFileType = .mp4
            
            let startTime = CMTime(seconds: Double(start ), preferredTimescale: 1000)
            let endTime = CMTime(seconds: Double(end ), preferredTimescale: 1000)
            let timeRange = CMTimeRange(start: startTime, end: endTime)
            
            exportSession.timeRange = timeRange
            exportSession.exportAsynchronously{
                switch exportSession.status {
                case .completed:
                    print("exported at \(outputURL)")
                    DispatchQueue.main.async {
                        self.videoUrl = outputURL
                        completion(.success(outputURL))
                    }
                case .failed:
                    print("failed \(String(describing: exportSession.error))")
                    completion(.failure(exportSession.error!))
                case .cancelled:
                    print("cancelled \(String(describing: exportSession.error))")
                    completion(.failure(exportSession.error!))
                default: break
                }
            }
        }
    }
    
    //    func saveToCameraRoll(url: URL) {
    //        PHPhotoLibrary.shared().performChanges({
    //        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
    //      }) { saved, error in
    //        if saved {
    //         print("Trimmed video saved to Photos")
    //      }}}
    //
}

struct MsgVideoPlayerView: View {
    @Binding var fullScreen: Bool
    @ObservedObject var playerVM: PlayerViewModel
    var body: some View {
        ZStack {
            AVPlayerControllerRepresented(player: playerVM.player)
            VStack {
                HStack {
                    Button {
                        playerVM.player.isMuted.toggle()
                    } label: {
                        Image(systemName: playerVM.player.isMuted ? "speaker.slash.fill": "speaker.wave.2.fill")
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .padding()
                    }
                    Spacer()
                    Text(durationFormatter.string(from: playerVM.currentTime) ?? "")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                        .padding()
                }
                .padding(.top, fullScreen ? 20 : 0)
                Spacer()
                Button {
                    playerVM.playPause()
                } label: {
                    Image(systemName: playerVM.isPlaying ? "pause.circle.fill": "play.circle.fill")
                        .font(.system(size: 56))
                        .foregroundColor(.black.opacity(0.3))
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        fullScreen.toggle()
                    }) {
                        Image(fullScreen ? "ic_minimize" : "ic_maximize")
                            .padding()
                    }
                }
            }
        }
        .frame(width: fullScreen ? screenSize.width : 252, height: fullScreen ? screenSize.height : 448)
        .if (!fullScreen) { $0.padding(.top, -20) }
        .ignoresSafeArea()
        .statusBar(hidden: fullScreen)
    }
}

struct AVPlayerControllerRepresented : UIViewControllerRepresentable {
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

class PlayerManager : ObservableObject {
    let player: AVPlayer
    @Published var playing = false
    
    init(videoUrl: URL) {
        self.player = AVPlayer(url: videoUrl)
    }
    
    func play() {
        player.play()
        playing = true
    }
    
    func playPause() {
        if playing {
            player.pause()
        } else {
            player.play()
        }
        playing.toggle()
    }
}

struct SliderView: View {
    @ObservedObject var playerManager: PlayerViewModel
    @ObservedObject var slider: CustomSlider
    var frames: [UIImage]
    @Binding var handleMoved: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: slider.lineWidth)
            .fill(Color.clear)
            .frame(width: slider.width, height: slider.lineWidth)
            .overlay(
                ZStack {
                    //Path between both handles
                    SliderPathBetweenView(frames: frames, handleMoved: $handleMoved)
                    
                    //Low Handle
                    SliderHandleView(handle: slider.lowHandle, handelImage: "lowerBound", handleMoved: $handleMoved)
                        .highPriorityGesture(slider.lowHandle.sliderDragGesture)
                    
                    //High Handle
                    SliderHandleView(handle: slider.highHandle, handelImage: "upperBound", handleMoved: $handleMoved)
                        .highPriorityGesture(slider.highHandle.sliderDragGesture)
                    
                    VideoCursorView(playerManager: playerManager, handle: slider.lowHandle)
                }
            )
    }
}

struct VideoCursorView: View {
    @ObservedObject var playerManager: PlayerViewModel
    @ObservedObject var handle: SliderHandle
    @State private var offset = 0.0
    var body: some View {
        Image("ic_video_cursor")
            .position(x: handle.currentLocation.x + 10.0, y: handle.currentLocation.y + 28.5)
            .offset(x: offset)
            .animation(.default, value: offset)
            .onChange(of: playerManager.currentTime) { value in
                if !playerManager.isPlaying {
                    offset = .zero
                } else {
                    offset = (value / (playerManager.player.currentItem!.asset.duration.seconds / 0.25)) * 1250.0
                }
            }
    }
}

struct SliderHandleView: View {
    @ObservedObject var handle: SliderHandle
    var handelImage: String
    @Binding var handleMoved: Bool
    
    var body: some View {
        Image(handelImage)
            .renderingMode(.template)
            .resizable()
            .frame(width: 23.95, height: 65)
            .foregroundColor(handleMoved ? Color(uiColor: UIColor(red: 0.29, green: 0.27, blue: 0.29, alpha: 1.00)) : .black)
            .position(x: handle.currentLocation.x, y: handle.currentLocation.y + 28.5)
    }
}

struct SliderPathBetweenView: View {
    var frames: [UIImage]
    @Binding var handleMoved: Bool
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(frames, id: \.self) { frame in
                Image(uiImage: frame)
                    .resizable()
                    .scaledToFill()
                    .frame(width:17, height: 65)
                    .clipped()
            }
        }
        .border(handleMoved ? Color(uiColor: UIColor(red: 0.29, green: 0.27, blue: 0.29, alpha: 1.00)) : Color.black, width: 8)
        .cornerRadius(10.0)
    }
}
