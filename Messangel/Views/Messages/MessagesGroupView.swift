//
//  MessagesGroupView.swift
//  Messangel
//
//  Created by Saad on 5/31/21.
//

import SwiftUI
import NavigationStack

struct MessagesGroupView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var albumVM: AlbumViewModel
    var group: MsgGroup
    @State private var currentIndex: Int = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var fadeOut = false

    var body: some View {
        NavigationStackView("MessagesGroupView") {
            MenuBaseView(title: group.name) {
                if albumVM.albumImages.count == 0 {
                    GalleryPlaceHolder()
                } else {
                    Image(uiImage: albumVM.albumImages[currentIndex].image)
                        .resizable()
                        .animation(.spring())
                        .frame(height: 190)
                        .padding(.horizontal, -16)
                        .padding(.top, -16)
                        .opacity(fadeOut ? 0.5 : 1)
                        .animation(.easeInOut(duration: 0.5))
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
                }
                MiddleView(groupName: group.name)
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16.0), count: mediaCount() + 1), spacing: 16.0) {
                    CreateMessageCard()
                    if let groupTexts = group.texts {
                        ForEach(groupTexts, id: \.self) { text in
                            MessageCard(image: "ic_contacts", name: text.name, icon: "ic_text_msg")
                        }
                    }
                    if let groupAudios = group.audios {
                        ForEach(groupAudios, id: \.self) { audio in
                            MessageCard(image: "ic_contacts", name: audio.name, icon: "ic_video")
                        }
                    }
                    if let groupVideos = group.videos {
                        ForEach(groupVideos, id: \.self) { video in
                            MessageCard(image: "ic_contacts", name: video.name, icon: "ic_video")
                        }
                    }
                }
            }
        }
    }
    
    func mediaCount() -> Int {
        var mediaCount = 0
        if let texts = group.texts {
            mediaCount += texts.count
        }
        if let audios = group.audios {
            mediaCount += audios.count
        }
        if let videos = group.videos {
            mediaCount += videos.count
        }
        return mediaCount
    }
}


struct GalleryPlaceHolder: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var viewModel: AlbumViewModel
    var body: some View {
        Rectangle()
            .foregroundColor(.gray.opacity(0.5))
            .frame(height: 190)
            .padding(-16)
            .overlay(
                Button(action: {
                    navigationModel.pushContent(TabBarView.id) {
                        PhotosSelectionView()
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

struct MiddleView: View {
    var groupName: String
    var body: some View {
        HStack {
            HStack {
                Text(groupName)
                    .fontWeight(.bold)
                Spacer()
            }
        }
        HStack {
            Capsule()
                .foregroundColor(.white)
                .normalShadow()
                .frame(width: 160, height: 56)
                .overlay(HStack {
                    Text("0")
                        .foregroundColor(.accentColor)
                    Image("ic_contacts")
                    Text("Destinataires")
                        .font(.system(size: 13))
                })
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
                Divider()
                Text("03 aujourd’hui 2021")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary.opacity(0.5))
                    .padding(5)
                    .padding(.bottom, 10)
            })
    }
}

struct MessageCard: View {
    var image = ""
    var name = ""
    var icon = ""
    
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
                    .overlay(Image(image))
                    .padding(.bottom, 10)
                Text(name)
                Spacer()
                Image(icon)
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                Divider()
                Text("03 aujourd’hui 2021")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary.opacity(0.5))
                    .padding(5)
                    .padding(.bottom, 10)
            })
    }
}
