//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

private let title = "Indiquez si vous souhaitez que les invités portent des accessoires en particulier"

struct FuneralGuestsWearings: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: FueneralAstheticViewModel
    @EnvironmentObject var navModel: NavigationModel
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.asthetic.guest_accessories_note, attachements: $vm.attachements, noteAttachmentIds: $vm.asthetic.guest_accessories_note_attachment)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 4.0, totalSteps: 4.0, isCustomAction: true, customAction: {
                loading.toggle()
                if !vm.updateRecord {
                    vm.create() { success in
                        if success {
                            WishesViewModel.setProgress(tab: 7) { completed in
                                loading.toggle()
                                if completed {
                                    navModel.pushContent(title) {
                                        FuneralDoneView()
                                    }
                                }
                            }
                        }
                    }
                } else {
                    vm.update(id: vm.asthetics[0].id) { success in
                        loading.toggle()
                        if success {
                            navModel.pushContent(title) {
                                FuneralDoneView()
                            }
                        }
                    }
                }
            },note: false, showNote: .constant(false), menuTitle: "Esthétique", title: title, valid: .constant(true)) {
                NoteView(showNote:$showNote, note: $vm.asthetic.guest_accessories_note)
            }
        }
    }
}
