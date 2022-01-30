//
//  MessagesAudioPlayerView.swift
//  Messangel
//
//  Created by Saad on 1/29/22.
//

import SwiftUI
import AVFoundation
import NavigationStack

//struct MessagesAudioPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessagesAudioPlayerView()
//    }
//}

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
                ZStack {
                    ZStack(alignment: .topTrailing) {
                        Text(durationFormatter.string(from: self.player.displayTime) ?? "")
                            .foregroundColor(.white)
                            .padding()
                            .zIndex(1.0)
                        Image(bgImage)
                            .resizable()
                            .frame(width: fullScreen ? screenSize.width : 252, height: fullScreen ? screenSize.height - 100 : 463)
                            .overlay(ZStack {
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
                        }.padding(), alignment: .bottom)
                    }
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
