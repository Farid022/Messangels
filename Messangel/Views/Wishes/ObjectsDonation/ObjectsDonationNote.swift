//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct ObjectsDonationNote: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: ObjectDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title: String {
        return "\(vm.objectDonation.object_name) – Note"
    }
    var body: some View {
        FuneralNoteCutomActionView(showNote: $showNote, note: $vm.objectDonation.object_note, loading: $loading, menuTitle: "Objets", title: title) {
            loading.toggle()
            Task {
                if vm.localPhoto.cgImage != nil {
                    self.vm.objectDonation.object_photo = await uploadImage(vm.localPhoto, type: "object")
                }
                if vm.updateRecord {
                    vm.update(id: vm.objectDonation.id ?? 0) { success in
                        loading.toggle()
                        if success {
                            navModel.popContent("ObjectsDonationsList")
                            vm.getAll { _ in }
                        }
                    }
                } else {
                    vm.create { success in
                        if success && vm.donations.isEmpty {
                            WishesViewModel.setProgress(tab: 11) { completed in
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
}
