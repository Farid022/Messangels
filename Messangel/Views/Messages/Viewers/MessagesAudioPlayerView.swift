//
//  MessagesAudioPlayerView.swift
//  Messangel
//
//  Created by Saad on 1/29/22.
//

import SwiftUI
import AVFoundation
import NavigationStack
import Kingfisher

struct MessagesAudioPlayerView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var vm = AudioViewModel()
    @State private var showDeleteConfirm = false
    @State private var deleting = false
    @State private var fullScreen = false
    @ObservedObject var player: Player
    var screenSize = UIScreen.main.bounds
    var audio: MsgAudio

    var body: some View {
        
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            VStack {
                Spacer().frame(height: 30)
                if !fullScreen {
                    MessagesViewerTopbar {
                        
                    } deleteAction: {
                        showDeleteConfirm.toggle()
                    }
                }
                AudioPlayerPreview(bgImage: audio.audio_image ?? "https://google.com", fullScreen: $fullScreen, player: player)
                Spacer()
            }
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce message", confirmMessage: "Êtes-vous sur de vouloir supprimer ce message audio ?") {
                deleting.toggle()
                vm.delete(id: audio.id) { success in
                    deleting.toggle()
                    if success {
                        navigationModel.popContent(TabBarView.id)
                    }
                }
            }
            if deleting {
                Loader()
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
    var updateAction: () -> Void = {}
    var deleteAction: () -> Void = {}
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                navigationModel.hideTopViewWithReverseAnimation()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
            }
            Spacer()
//            Button(action: { updateAction() }) {
//                Image("ic_modify")
//            }
            Button(action: { deleteAction() }) {
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
                KFImage.url(URL(string: bgImage))
                    .placeholder {
                        Color.gray
                    }
                    .centerCropped()
                    .frame(width: fullScreen ? screenSize.width : 252, height: fullScreen ? screenSize.height - 100 : 463)
                    .overlay (
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
