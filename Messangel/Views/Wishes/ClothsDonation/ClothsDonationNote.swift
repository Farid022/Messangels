//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct ClothsDonationNote: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: ClothDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title = "Ajoutez des informations complémentaires (exemples : vêtement fragile, cas particuliers)"

    fileprivate func createOrUpdateRecord() {
        if vm.updateRecord {
            vm.update(id: vm.clothDonation.id ?? 0) { success in
                loading.toggle()
                if success {
                    navModel.popContent("ClothsDonationsList")
                    vm.getAll { _ in
                        print("ClothsDonationsList Updated")
                    }
                }
            }
        } else {
            vm.createClothDonation { success in
                if success && vm.donations.isEmpty {
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
    
    var body: some View {
        FuneralNoteAttachCutomActionView(totalSteps: 7.0, showNote: $showNote, note: $vm.clothDonation.clothing_note, loading: $loading, oldAttachedFiles: $vm.clothDonation.clothing_note_attachments, noteAttachmentIds: $vm.clothDonation.clothing_note_attachment, menuTitle: "Vêtements et accessoires", title: title) {
            loading.toggle()
            Task {
                if vm.localPhoto.cgImage != nil {
                    self.vm.clothDonation.clothing_photo = await uploadImage(vm.localPhoto, type: "clothing").0
                }
                createOrUpdateRecord()
            }
        }
    }
}

