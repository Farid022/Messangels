//
//  MessagesGroupView.swift
//  Messangel
//
//  Created by Saad on 5/31/21.
//

import SwiftUI
import NavigationStack
import AVFoundation
import Kingfisher

struct MessagesGroupView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var albumVM: AlbumViewModel
    var group: MsgGroupDetail
    @State private var currentIndex: Int = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var fadeOut = false
    static let id = String(describing: Self.self)
    
    var body: some View {
        NavigationStackView(MessagesGroupView.id) {
            MenuBaseView(title: group.name) {
                if albumVM.albumImages.count > 0 {
                    Image(uiImage: albumVM.albumImages[currentIndex].image)
                        .centerCropped()
                        .frame(height: 190)
                        .padding(.horizontal, -16)
                        .padding(.top, -16)
                        .opacity(fadeOut ? 0.5 : 1)
                        .animation(.easeInOut(duration: 0.5), value: fadeOut)
                        .onReceive(timer) { _ in
                            if currentIndex < albumVM.albumImages.count - 1 {
                                fadeOut.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        currentIndex += 1
                                        self.fadeOut.toggle()
                                    }
                                }
                            }
                        }
                        .overlay(Button {
                            navigationModel.pushContent(MessagesGroupView.id) {
                                PhotosSelectionView(group: group)
                                    .environmentObject(albumVM)
                            }
                        } label: {
                            Image("ic_edit_gallery")
                                .padding(.bottom)
                        }, alignment: .bottomTrailing)
                } else if let galleries = group.galleries, !galleries.isEmpty  {
                    KFImage.url(URL(string: galleries[currentIndex].image_link))
                        .placeholder {
                            Loader()
                        }
                        .centerCropped()
                        .frame(height: 190)
                        .padding(.horizontal, -16)
                        .padding(.top, -16)
                        .opacity(fadeOut ? 0.5 : 1)
                        .animation(.easeInOut(duration: 0.5), value: fadeOut)
                        .onReceive(timer) { _ in
                            if currentIndex < galleries.count - 1 {
                                fadeOut.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        currentIndex += 1
                                        self.fadeOut.toggle()
                                    }
                                }
                            }
                        }
                        .overlay(
                            Button {
                            navigationModel.pushContent(MessagesGroupView.id) {
                                PhotosSelectionView(group: group)
                                    .environmentObject(albumVM)
                            }
                        } label: {
                            Image("ic_edit_gallery")
                                .padding(.bottom)
                        }, alignment: .bottomTrailing)
                } else {
                    GalleryPlaceHolder(group: group)
                }
                GroupDestinationView(group: group)
                VStack() {
                    if let groupTexts = group.texts {
                        ForEach(groupTexts, id: \.self) { text in
                            MessageCard(name: text.name, icon: "ic_text_msg", createdAt: unixStrToDateSring(text.created_at ?? ""))
                                .onTapGesture {
                                    navigationModel.presentContent(MessagesGroupView.id) {
                                        MessagesTextView(text: text, headerImage: "doc_header")
                                    }
                                }
                        }
                    }
                    if let groupAudios = group.audios {
                        ForEach(groupAudios, id: \.self) { audio in
                            MessageCard(name: audio.name, icon: "ic_audio", createdAt: unixStrToDateSring(audio.created_at ?? ""))
                                .onTapGesture {
                                    if let url = URL(string:audio.audio_link) {
                                        let player = Player(avPlayer: AVPlayer(url: url))
                                        navigationModel.presentContent(MessagesGroupView.id) {
                                            MessagesAudioPlayerView(player: player, audio: audio)
                                        }
                                    }
                                }
                        }
                    }
                    if let groupVideos = group.videos {
                        ForEach(groupVideos, id: \.self) { video in
                            MessageCard(name: video.name, icon: "ic_video", createdAt: unixStrToDateSring(video.created_at ?? ""))
                                .onTapGesture {
                                    navigationModel.presentContent(MessagesGroupView.id) {
                                        MessagesVideoPlayerView(video: video)
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}


struct GalleryPlaceHolder: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var viewModel: AlbumViewModel
    var group: MsgGroupDetail
    
    var body: some View {
        Rectangle()
            .foregroundColor(.gray.opacity(0.5))
            .frame(height: 190)
            .padding(-16)
            .overlay(
                Button(action: {
                    navigationModel.pushContent(MessagesGroupView.id) {
                        PhotosSelectionView(group: group)
                            .environmentObject(viewModel)
                    }
                }) {
                    RoundedRectangle(cornerRadius: 30.0)
                        .frame(width: 66, height: 66)
                        .foregroundColor(.gray)
                        .overlay(Image(systemName: "photo.fill").foregroundColor(.white))
                }
            )
            .padding(.bottom, 25)
    }
}

struct GroupDestinationView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var vm = GroupViewModel()
    var group: MsgGroupDetail
    
    var body: some View {
        HStack {
            HStack {
                Text(group.name)
                    .fontWeight(.bold)
                Spacer()
            }
        }
        HStack {
            Button {
                vm.group = MsgGroup(id: self.group.id, name: self.group.name, texts: self.group.texts, audios: self.group.audios , videos: self.group.videos, galleries: self.group.galleries)
                if let groupContacts = self.group.group_contacts {
                    vm.groupContacts = groupContacts
                    var ids = [Int]();
                    groupContacts.forEach { c in
                        ids.append(c.id)
                    }
                    vm.group.group_contacts = ids
                }
                navigationModel.presentContent(MessagesGroupView.id) {
                    MsgGroupContacts(vm: vm)
                }
            } label: {
                Capsule()
                    .foregroundColor(.white)
                    .normalShadow()
                    .frame(width: 160, height: 56)
                    .overlay(HStack {
                        Text("\(group.group_contacts?.count ?? 0)")
                            .foregroundColor(.accentColor)
                        Image("ic_contacts")
                        Text("Destinataires")
                            .font(.system(size: 13))
                    })
            }
            Spacer()
        }
        .padding(.bottom, 30)
    }
}

struct CreateMessageCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: 160, height: 250)
            .foregroundColor(.white)
            .normalShadow()
            .overlay(VStack {
                Spacer().frame(height: 30)
                RoundedRectangle(cornerRadius: 28.0)
                    .frame(width: 66, height: 66)
                    .foregroundColor(.white)
                    .normalShadow()
                    .overlay(Image(systemName: "plus").foregroundColor(.gray))
                    .padding(.bottom, 10)
                Text("Créer un nouveau message")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 13))
                Spacer()
            })
    }
}

struct MessageCard: View {
    var name = ""
    var icon = ""
    var createdAt = ""
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(height: 114)
            .foregroundColor(.white)
            .normalShadow()
            .overlay(
                HStack {
                    RoundedRectangle(cornerRadius: 28.0)
                        .frame(width: 66, height: 66)
                        .foregroundColor(.white)
                        .normalShadow()
                        .overlay(
                            Image(icon)
                                .renderingMode(.template)
                                .foregroundColor(.accentColor)
                        )
                    VStack(spacing: 10) {
                        HStack {
                            Text(name)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Image(icon)
                                .renderingMode(.template)
                                .foregroundColor(.gray)
                                .padding(.bottom)
                            Text(createdAt)
                                .font(.system(size: 11))
                                .foregroundColor(.secondary)
                                .padding(5)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                    .padding()
                    Spacer()
                }
                    .padding()
            )
    }
}
