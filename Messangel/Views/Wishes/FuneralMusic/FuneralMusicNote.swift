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
        FuneralNoteAttachCutomActionView(totalSteps: 4.0, showNote: $showNote, note: $vm.music.broadcast_song_note, loading: $loading, attachements: $vm.attachements, noteAttachmentIds: $vm.music.broadcast_song_note_attachment, menuTitle: wishesCeremony.last!.name, title: title) {
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
                        WishesViewModel.setProgress(tab: 8) { completed in
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
