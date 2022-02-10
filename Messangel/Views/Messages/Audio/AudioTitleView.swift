//
//  DocTitleView.swift
//  Messangel
//
//  Created by Saad on 7/8/21.
//

import SwiftUI
import NavigationStack

struct AudioTitleView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @EnvironmentObject private var groupVM: GroupViewModel
    @ObservedObject var player: Player
    @StateObject private var vm = AudioViewModel()
    @State private var valid = false
    @State private var fullScreen = false

    var fileUrl: URL
    
    var body: some View {
        NavigationStackView("AudioTitleView") {
            MenuBaseView(height: 60, title: "Filtre") {
//                ZStack {
//                    Rectangle()
//                        .foregroundColor(.gray.opacity(0.5))
//                        .frame(height: screenSize.width / 1.15)
//                        .padding(.horizontal, 30)
//                        .padding(.bottom, 30)
//                    Image("audio_preview_waves")
//                    AudioPlayerButton(player: self.player)
//                }
                ZStack {
                    Image("audio_preview_waves")
                    AudioPlayerPreview(bgImage: "bg_audio_default", fullScreen: $fullScreen, player: player)
                }
                TextField("Titre de la audéo", text: $vm.audio.name, onCommit: {
                    valid = !vm.audio.name.isEmpty
                })
                    .textFieldStyle(MyTextFieldStyle())
                    .normalShadow()
                    .padding(.bottom)
                HStack {
                    Spacer()
                    Rectangle()
                        .fill(valid ? Color.accentColor : Color.accentColor.opacity(0.2))
                        .frame(width: 56, height: 56)
                        .cornerRadius(25)
                        .overlay(
                            Button(action: {
                                navigationModel.pushContent("AudioTitleView") {
                                    AudioImageView(player: player, vm: vm, fileUrl: fileUrl)
                                }
                            }) {
                                Image(systemName: "chevron.right").foregroundColor(Color.white)
                            }
                        )
                }
            }
        }
    }
}


