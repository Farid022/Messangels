//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralMusicDetails: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showDeleteConfirm = false
    @ObservedObject var vm: FuneralMusicViewModel
    var music: Music
    var confirmMessage = "Les informations liées seront supprimées définitivement"

    var body: some View {
        ZStack {
            if showDeleteConfirm {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .overlay(MyAlert(title: "Supprimer ce smartphone", message: confirmMessage, action: {
                        vm.del(id: music.id) { success in
                            if success {
                                navigationModel.popContent(TabBarView.id)
                            }
                        }
                    }, showAlert: $showDeleteConfirm))
                    .zIndex(1.0)
            }
            NavigationStackView("FuneralMusicDetails") {
                ZStack(alignment:.top) {
                    Color.accentColor
                        .frame(height:70)
                        .edgesIgnoringSafeArea(.top)
                    VStack(spacing: 20) {
                        Color.accentColor
                            .frame(height:90)
                            .padding(.horizontal, -20)
                            .overlay(
                                HStack {
                                    BackButton()
                                    Spacer()
                                }, alignment: .top)
                        
                        VStack {
                            Color.accentColor
                                .frame(height: 35)
                                .overlay(Text("Musique")
                                            .font(.system(size: 22))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding([.leading, .bottom])
                                         ,
                                         alignment: .leading)
                            Color.white
                                .frame(height: 15)
                        }
                        .frame(height: 50)
                        .padding(.horizontal, -16)
                        .padding(.top, -16)
                        .overlay(HStack {
                            Spacer()
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 60, height: 60)
                                .cornerRadius(25)
                                .normalShadow()
                                .overlay(Image("info"))
                        })
                        //
                        HStack {
                            // <
                            Text("\(music.artist_name) - \(music.song_title)")
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        HStack {
                            Image("ic_item_info")
                            Text("Artiste –  \(music.artist_name)")
                            Spacer()
                        }
                        HStack {
                            Image("ic_item_info")
                            Text("Nom du titre –  \(music.song_title)")
                            Spacer()
                        }
                        
                        DetailsNoteView(note: music.broadcast_song_note)
                        HStack {
                            Group {
                                Button(action: {
                                    vm.music = FuneralMusic(id: music.id, artist_name: music.artist_name, song_title: music.song_title, broadcast_song_note: music.broadcast_song_note, user: getUserId())
                                    vm.updateRecord = true
                                    navigationModel.popContent(FuneralMusicArtist.title)
//                                    navigationModel.pushContent("FuneralMusicDetails") {
//                                        FuneralMusicArtist(vm: vm)
//                                    }
                                }, label: {
                                    Text("Modifier")
                                })
                                Button(action: {
                                    showDeleteConfirm.toggle()
                                }, label: {
                                    Text("Supprimer")
                                })
                            }
                            .buttonStyle(MyButtonStyle(padding: 0, maxWidth: false, foregroundColor: .black))
                            .normalShadow()
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }
}
