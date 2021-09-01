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

struct VideoTrimView: View {
    @State var videoUrl: URL
    var asset: AVURLAsset
    let finishedObserver: PlayerFinishedObserver
    @State private var valid = false
    @State private var loading = false
    @State private var frames = [UIImage]()
    @StateObject var playerManager: PlayerManager
    @ObservedObject var slider: CustomSlider
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        NavigationStackView("VideoTrimView") {
            ZStack(alignment: .bottom) {
                MenuBaseView(height: 60, title: "Aperçu") {
                    AVPlayerControllerRepresented(player: playerManager.player)
                        .frame(width: 212, height: 390)
                        .padding(.top, -20)
                    #if DEBUG
                    Text("Start Time:") + Text("\(slider.lowHandle.currentValue)")
                    #endif
                    SliderView(slider: slider, frames: frames)
                        .padding(.vertical, 30)
                    #if DEBUG
                    Text("End Time:") + Text("\(slider.highHandle.currentValue)")
                    #endif
                    Button(action: {
                        playerManager.playPause()
                        valid = true
                    }, label: {
                        RoundedRectangle(cornerRadius: 22.0)
                            .foregroundColor(.white)
                            .frame(width: 55, height: 52)
                            .shadow(color: .gray.opacity(0.2), radius: 5)
                            .overlay(Image(systemName: playerManager.playing ? "pause.fill" : "play.fill").foregroundColor(.accentColor))
                    })
                    Spacer().frame(height: 50)
                }
                HStack {
                    Button(action: {
                        if valid && !loading {
                            loading = true
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
                        }
                    }, label: {
                        Text(slider.lowHandle.currentValue > 1 || slider.highHandle.currentValue < asset.duration.seconds ? "Rogner" : "Valider")
                            .font(.system(size: 15))
                            .padding(3)
                    })
                    .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: valid ? .accentColor : .gray))
                    .padding(.bottom, 50)
                    .padding(.top, 20)
                }
                .frame(maxWidth: .infinity)
                .background(
                    Color.white
                        .clipShape(CustomCorner(corners: [.topLeft,.topRight]))
                )
                .shadow(color: Color.gray.opacity(0.15), radius: 5, x: -5, y: -5)
            }
        }
        .onReceive(finishedObserver.publisher) {
            playerManager.playing = false
            seekVideo(toPosition: CGFloat(slider.lowHandle.currentValue))
        }
        .onDidAppear() {
            getVideoFrames()
        }
        .onChange(of: slider.lowHandle.currentValue) { value in
            seekVideo(toPosition: CGFloat(value))
        }
        .onChange(of: slider.highHandle.currentValue) { value in
            seekVideo(toPosition: CGFloat(value))
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
    
    func seekVideo(toPosition position: CGFloat) {
        let time: CMTime = CMTimeMakeWithSeconds(Float64(position), preferredTimescale: playerManager.player.currentTime().timescale)
        playerManager.player.seek(to: time, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
      }
    
    func cropVideo(sourceURL1: URL, statTime:Float, endTime:Float, completion: @escaping (Result<URL,Error>) -> Void ) {
        let manager = FileManager.default
        
        guard let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return}
        let mediaType = "mp4"
        if mediaType == kUTTypeMovie as String || mediaType == "mp4" as String {
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

class PlayerFinishedObserver {

    let publisher = PassthroughSubject<Void, Never>()

    init(player: AVPlayer) {
        let item = player.currentItem

        var cancellable: AnyCancellable?
        cancellable = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: item).sink { [weak self] change in
            self?.publisher.send()
            cancellable?.cancel()
        }
    }
}

struct SliderView: View {
    @ObservedObject var slider: CustomSlider
    var frames: [UIImage]
    
    var body: some View {
        RoundedRectangle(cornerRadius: slider.lineWidth)
            .fill(Color.clear)
            .frame(width: slider.width, height: slider.lineWidth)
            .overlay(
                ZStack {
                    //Path between both handles
                    SliderPathBetweenView(frames: frames)
                    
                    //Low Handle
                    SliderHandleView(handle: slider.lowHandle, handelImage: "lowerBound")
                        .highPriorityGesture(slider.lowHandle.sliderDragGesture)
                    
                    //High Handle
                    SliderHandleView(handle: slider.highHandle, handelImage: "upperBound")
                        .highPriorityGesture(slider.highHandle.sliderDragGesture)
                }
            )
    }
}

struct SliderHandleView: View {
    @ObservedObject var handle: SliderHandle
    var handelImage: String
    
    var body: some View {
        Image(handelImage)
            .resizable()
            .frame(width: 23.95, height: 65)
            .position(x: handle.currentLocation.x, y: handle.currentLocation.y + 28.5)
    }
}

struct SliderPathBetweenView: View {
    var frames: [UIImage]
    
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
        .border(Color.black, width: 8)
    }
}



