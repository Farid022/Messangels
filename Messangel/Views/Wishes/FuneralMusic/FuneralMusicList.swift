//
//  FuneralMusicList.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralMusicList: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: FuneralMusicViewModel
    var refresh: Bool
    
    var body: some View {
        FuneralItemList(id:"FuneralMusicList", menuTitle: "Musique", newItemView: AnyView(FuneralMusicArtist(vm: FuneralMusicViewModel()))) {
            ForEach(vm.musics, id: \.self) { music in
                FuneralItemCard(title: music.song_title, icon: "ic_music_white")
                    .onTapGesture {
                        navigationModel.pushContent("FuneralMusicList") {
                            FuneralMusicDetails(vm: vm, music: music)
                        }
                    }
            }
        }
        .onDidAppear() {
            if refresh {
                vm.getMusics { _ in
                    
                }
            }
        }
    }
}

struct FuneralItemList<Content: View>: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    let id: String
    let menuTitle: String
    let newItemView: AnyView
    let content: Content
    init(id: String, menuTitle: String, newItemView: AnyView, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.id = id
        self.menuTitle = menuTitle
        self.newItemView = newItemView
    }
    var body: some View {
        NavigationStackView(id) {
            ZStack(alignment:.top) {
                Color.accentColor
                    .frame(height:70)
                    .edgesIgnoringSafeArea(.top)
                ZStack(alignment: .top) {
                    VStack {
                       Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                navigationModel.pushContent(id) {
                                    newItemView
                                }
                            }, label: {
                                Image("ic_add_btn")
                            })
                        }
                    }
                    .zIndex(1.0)
                    VStack(spacing: 20) {
                        NavbarButtonView(exitAction: {
                            navigationModel.popContent(TabBarView.id)
                        })
                        NavigationTitleView(menuTitle: menuTitle)
                        Spacer().frame(height: 17)
                        ScrollView(showsIndicators: false) {
                            content
                                .padding(.vertical)
                        }
                        Spacer()
                    }
                    .padding()
                    
                }
            }
        }
    }
}

struct FuneralItemCard: View {
    var title: String
    var icon: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.white)
            .frame(height: 96)
            .overlay(HStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.gray)
                    .frame(width: 56, height: 56)
                    .overlay(Image(icon))
                    .padding(.leading)
                Text(title)
                Spacer()
            })
            .normalShadow()
    }
}
