//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct AnimalDonationNote: View {
    @State private var showNote = false
    @State private var loading = false
    @State private var attachedFiles = [URL]()
    @ObservedObject var vm: AnimalDonatiopnViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title: String {
        return "Ajoutez des informations pratiques sur \(vm.animalDonation.animal_name) (alimentation, santé, fréquence de sortie, animaux nombreux)"
    }
    
    fileprivate func insertOrUpdateRecord() {
        if vm.updateRecord {
            vm.update(id: vm.animalDonation.id ?? 0) { success in
                loading.toggle()
                if success {
                    navModel.popContent("AnimalDonationsList")
                    vm.getAll { _ in }
                }
            }
        } else {
            vm.create { success in
                if success && vm.donations.isEmpty {
                    WishesViewModel.setProgress(tab: 10) { completed in
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
        FuneralNoteAttachCutomActionView(showNote: $showNote, note: $vm.animalDonation.animal_note, loading: $loading, attachFiles: $attachedFiles, menuTitle: "ANIMAUX", title: title) {
            loading.toggle()
            Task {
                if vm.localPhoto.cgImage != nil {
                    self.vm.animalDonation.animal_photo = await uploadImage(vm.localPhoto, type: "animal")
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
                            vm.animalDonation.animal_note_attachment = attachementIds
                            insertOrUpdateRecord()
                        }
                    }
                } else {
                    insertOrUpdateRecord()
                }
            }
        }
    }
}
