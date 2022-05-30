//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralMusicDetails: View {
    @State private var showDeleteConfirm = false
    @EnvironmentObject private var navigationModel: NavigationModel
    @ObservedObject var vm: FuneralMusicViewModel
    var music: Music
    var confirmMessage = "Les informations liées seront supprimées définitivement"
    
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce musique") {
                vm.del(id: music.id) { success in
                    if success {
                        navigationModel.popContent(String(describing: FuneralMusicList.self))
                        vm.getMusics { _ in }
                    }
                }
            }
            NavigationStackView(String(describing: Self.self)) {
                ZStack(alignment:.top) {
                    Color.accentColor
                        .frame(height:70)
                        .edgesIgnoringSafeArea(.top)
                    VStack(spacing: 20) {
                        NavigationTitleView(menuTitle: "Musique", showExitAlert: .constant(false))
                        ScrollView {
                            DetailsTitleView(title: "\(music.artist_name) - \(music.song_title)")
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
                            DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                                vm.music = FuneralMusic(id: music.id, artist_name: music.artist_name, song_title: music.song_title, broadcast_song_note: music.broadcast_song_note, user: getUserId())
                                vm.updateRecord = true
                                vm.music.broadcast_song_note_attachments = addAttacments(music.broadcast_song_note_attachment)
                                navigationModel.pushContent(String(describing: Self.self)) {
                                    FuneralMusicArtist(vm: vm)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

//MARK: - Details Custom Views
struct DetailsTitleView: View {
    var title: String
    var body: some View {
        HStack {
            BackButton(iconColor: .gray)
            Text(title)
                .font(.system(size: 22), weight: .bold)
            Spacer()
        }
    }
}

struct DetailsActionsView: View {
    @Binding var showDeleteConfirm: Bool
    var modifyAction: () -> Void
    
    var body: some View {
        HStack {
            Group {
                Button(action: { modifyAction() }, label: {
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
}

struct DetailsDeleteView: View {
    @Binding var showDeleteConfirm: Bool
    var alertTitle: String
    var confirmMessage = "Les informations liées seront supprimées définitivement"
    var deleteAction: () -> Void
    
    var body: some View {
        if showDeleteConfirm {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .overlay(MyAlert(title: alertTitle, message: confirmMessage, action: { deleteAction() }, showAlert: $showDeleteConfirm))
                .zIndex(1.0)
        }
    }
}
