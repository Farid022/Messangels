//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralInviteNewsPaper: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: FuneralAnnounceViewModel
    @EnvironmentObject var navModel: NavigationModel

    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.announcement.newspaper_note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: {
                loading.toggle()
                Task {
                    if !vm.updateRecord {
                        if vm.invitePhoto.cgImage != nil {
                            vm.announcement.invitation_photo = await uploadImage(vm.invitePhoto, type: "invitation")
                        }
                        vm.create() { success in
                            if success {
                                WishesViewModel.setProgress(tab: 3) { completed in
                                    loading.toggle()
                                    if completed {
                                        navModel.pushContent("Précisez un journal local dans lequel diffuser l’annonce") {
                                            FuneralDoneView()
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        vm.update(id: vm.announcements[0].id) { completed in
                            loading.toggle()
                            if completed {
                                navModel.pushContent("Précisez un journal local dans lequel diffuser l’annonce") {
                                    FuneralDoneView()
                                }
                            }
                        }
                    }
                }
            },note: false, showNote: .constant(false), menuTitle: "Annonces", title: "Précisez un journal local dans lequel diffuser l’annonce", valid: .constant(true)) {
                NoteView(showNote:$showNote, note: $vm.announcement.newspaper_note)
            }
        }
    }
}
