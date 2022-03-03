//
//  MessagesAudioPlayerView.swift
//  Messangel
//
//  Created by Saad on 1/29/22.
//

import SwiftUI
import AVFoundation
import NavigationStack

struct MessagesAudioPlayerView: View {
    @ObservedObject var player: Player
    @State private var fullScreen = false
    var screenSize = UIScreen.main.bounds
    var bgImage: String

    var body: some View {
        
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            VStack {
                Spacer().frame(height: 30)
                if !fullScreen {
                    MessagesViewerTopbar()
                }
                AudioPlayerPreview(bgImage: bgImage, fullScreen: $fullScreen, player: player)
                Spacer()
            }
        }
    }
}

var durationFormatter: DateComponentsFormatter {

    let durationFormatter = DateComponentsFormatter()
    durationFormatter.allowedUnits = [.minute, .second]
    durationFormatter.unitsStyle = .positional
    durationFormatter.zeroFormattingBehavior = .pad

    return durationFormatter
}

struct MessagesViewerTopbar: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                navigationModel.hideTopViewWithReverseAnimation()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
            }
            Spacer()
            Button(action: {}) {
                Image("ic_modify")
            }
            Button(action: {}) {
                Image("ic_delete")
            }
        }
        .padding()
    }
}

struct AudioPlayerButton: View {
    @ObservedObject var player: Player
    var body: some View {
        Button {
            switch self.player.timeControlStatus {
            case .paused:
                self.player.play()
            case .waitingToPlayAtSpecifiedRate:
                self.player.pause()
            case .playing:
                self.player.pause()
            @unknown default:
                fatalError()
            }
        } label: {
            Image(systemName: self.player.timeControlStatus == .paused ? "play.circle.fill": "pause.circle.fill")
                .font(.system(size: 56))
        }
        .foregroundColor(.black.opacity(0.2))
    }
}

struct AudioPlayerPreview: View {
    var bgImage: String
    @Binding var fullScreen: Bool
    @ObservedObject var player: Player
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topTrailing) {
                Text(durationFormatter.string(from: self.player.displayTime) ?? "")
                    .foregroundColor(.white)
                    .padding()
                    .zIndex(1.0)
                AsyncImage(url: URL(string: bgImage)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                } placeholder: {
                    Color.gray
                }
                .frame(width: fullScreen ? screenSize.width : 252, height: fullScreen ? screenSize.height - 100 : 463)
                .overlay(
                    ZStack {
                        HStack {
                            if self.player.itemDuration > 0 {
                                Slider(value: self.$player.displayTime, in: (0...self.player.itemDuration), onEditingChanged: {
                                    (scrubStarted) in
                                    if scrubStarted {
                                        self.player.scrubState = .scrubStarted
                                    } else {
                                        self.player.scrubState = .scrubEnded(self.player.displayTime)
                                    }
                                }) .accentColor(.white)
                            } else {
                                Loader(tintColor: .white)
                                Spacer()
                            }
                            if fullScreen {
                                Text(durationFormatter.string(from: self.player.displayTime) ?? "")
                                    .foregroundColor(.white)
                            }
                            Button(action: { fullScreen.toggle() }) {
                                Image(fullScreen ? "ic_minimize" : "ic_maximize")
                            }
                        }
                        .if (fullScreen) {$0.padding(.horizontal)}
                        .zIndex(1.0)
                        if fullScreen {
                            Capsule()
                                .foregroundColor(.black.opacity(0.2))
                                .frame(height: 45)
                        }
                    }.padding(), alignment: .bottom
                )
                    
//                Image(bgImage)
//                    .resizable()
//                    .frame(width: fullScreen ? screenSize.width : 252, height: fullScreen ? screenSize.height - 100 : 463)
//                    .overlay(
//                        )
            }
            AudioPlayerButton(player: self.player)
        }
    }
}
