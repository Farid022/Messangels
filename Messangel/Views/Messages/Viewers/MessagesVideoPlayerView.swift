//
//  MessagesVideoPlayerView.swift
//  Messangel
//
//  Created by Saad on 3/10/22.
//

import SwiftUI
import AVKit
import NavigationStack

struct MessagesVideoPlayerView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var vm = VideoViewModel()
    @State private var showDeleteConfirm = false
    @State private var deleting = false
    @State private var fullScreen = false
    var video: MsgVideo
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            VStack {
                Spacer().frame(height: 30)
                    MessagesViewerTopbar {
                        
                    } deleteAction: {
                        showDeleteConfirm.toggle()
                    }
                VideoPlayer(player: AVPlayer(url: URL(string: video.video_link)!))
                Spacer()
            }
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce message", confirmMessage: "Êtes-vous sur de vouloir supprimer ce message video ?") {
                deleting.toggle()
                vm.delete(id: video.id) { success in
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


