//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralMusicNote: View {
    @State private var showNote = false
    @State private var loading = false
    @EnvironmentObject var navModel: NavigationModel
    @ObservedObject var vm: FuneralMusicViewModel
    var title = "Indiquez si vous avez des souhaits en particulier concernant ce titre (moments de diffusion, interprétation live…)"
    
    var body: some View {
        FuneralNoteCutomActionView(showNote: $showNote, note: $vm.music.broadcast_song_note, loading: $loading, menuTitle: wishesCeremony.last!.name, title: title) {
            loading.toggle()
            if vm.updateRecord {
                vm.update(id: vm.music.id ?? 0) { success in
                    if success {
                        navModel.popContent("FuneralMusicList")
                        vm.getMusics { _ in
                            print("Funeral Music List Updated")
                        }
                    }
                }
            } else {
                vm.create() { success in
                    if success && vm.musics.isEmpty {
                        WishesViewModel.setProgress(tab: 9) { completed in
                            loading.toggle()
                            if completed {
                                navModel.pushContent(title) {
                                    FuneralDoneView()
                                }
                            }
                        }
                    } else {
                        loading.toggle()
                        if success {
                            navModel.pushContent(title) {
                                FuneralDoneView()
                            }
                        }
                    }
                }
            }
           
        }
    }
}


// MARK: - FuneralNoteCutomActionView
struct FuneralNoteCutomActionView: View {
    @Binding var showNote: Bool
    @Binding var note: String
    @Binding var loading: Bool
    var menuTitle: String
    var title: String
    var customAction: () -> Void
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: customAction, note: false, showNote: .constant(false), menuTitle: menuTitle, title: title, valid: .constant(true)) {
                VStack(spacing: 0.0) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 161, height: 207.52)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(note.isEmpty ? Color.gray : Color.accentColor)
                                .frame(width: 56, height: 56)
                                .overlay(
                                    Button(action: {
                                        showNote.toggle()
                                    }) {
                                        Image(note.isEmpty ? "ic_add_note" : "ic_notes")
                                    }
                                )
                        )
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 161, height: 44)
                        .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
                        .overlay(Text("Note"))
                    if loading {
                        Loader()
                            .padding(.top)
                    }
                }
                .thinShadow()
            }
        }
    }
}
