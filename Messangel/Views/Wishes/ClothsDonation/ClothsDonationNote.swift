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
    @State private var attachedFiles = [URL]()
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
        FuneralNoteAttachCutomActionView(showNote: $showNote, note: $vm.clothDonation.clothing_note, loading: $loading, attachFiles: $attachedFiles, menuTitle: "Vêtements et accessoires", title: title) {
            loading.toggle()
            Task {
                if vm.localPhoto.cgImage != nil {
                    self.vm.clothDonation.clothing_photo = await uploadImage(vm.localPhoto, type: "clothing")
                }
                if !attachedFiles.isEmpty {
                    vm.attachements.removeAll()
                    let uploadedFiles = await uploadFiles(attachedFiles)
                    for uploadedFile in uploadedFiles {
                        vm.attachements.append(Attachement(url: uploadedFile))
                    }
                    vm.attach { success in
                        if success {
                            var attachementIds = [Int]()
                            for attachement in vm.attachements {
                                if let id = attachement.id {
                                    attachementIds.append(id)
                                }
                            }
                            vm.clothDonation.clothing_note_attachment = attachementIds
                            createOrUpdateRecord()
                        }
                    }
                } else {
                    createOrUpdateRecord()
                }
            }
        }
    }
}

